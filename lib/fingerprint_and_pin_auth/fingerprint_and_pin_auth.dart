import 'package:fingerprint_auth/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'hive_pin_provider.dart';

class FingerprintAndPinAuth extends StatefulWidget {
  const FingerprintAndPinAuth({super.key});

  @override
  State<FingerprintAndPinAuth> createState() => _FingerprintAndPinAuthState();
}

class _FingerprintAndPinAuthState extends State<FingerprintAndPinAuth> {

  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool showRegisterButton = false;
  final TextEditingController controller = TextEditingController();
  bool bioMetricsIsAvailable = false;
  bool isLoading = false;



  @override
  void initState() {
    super.initState();
    initialCheckBiometricAvailability();
  }


  /// >>> Detect whether the device supports biometric authentication ==========
  void initialCheckBiometricAvailability() async{
    try{
      bool available = await localAuthentication.canCheckBiometrics;
      setState(() {bioMetricsIsAvailable = available;});
    }catch(e){
      debugPrint("Error $e");
    }
  }
  /// <<< Detect whether the device supports biometric authentication ==========


  /// >>> Bio-Metric Authentication ============================================
  void _biometricAuthentication() async{
    if(!bioMetricsIsAvailable) return;
    setState(() {isLoading = true;});
    try{
      bool authentication = await localAuthentication.authenticate(localizedReason: "Please authenticate for attendance",biometricOnly: true,);
      if(authentication){
        _navigateTargetedPage();
      }
    }catch(e){
      debugPrint("Biometric Authentication Error $e");
    }finally{
      setState(() {isLoading = false;});
    }
  }
  /// <<< Bio-Metric Authentication ============================================


  /// >>> Navigate targeted page ===============================================
  void _navigateTargetedPage(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
  }
  /// <<< Navigate targeted page ===============================================



  /// >>> If Incorrect Pin =====================================================
  void _registerNewPin() {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController newPinController = TextEditingController();
          return AlertDialog(
            title: Text("Register New PIN"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Pinput(controller: newPinController, length: 4, obscureText: true, inputFormatters: [FilteringTextInputFormatter.digitsOnly],),],
            ),
            actions: [
              ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Cancel"),),
              ElevatedButton(
                onPressed: () {
                  if (newPinController.text.length == 4) {
                    Provider.of<HivePinProvider>(context, listen: false).setPin(newPinController.text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New PIN saved successfully!")),);
                    setState(() {showRegisterButton = false;});
                  }
                },
                child: Text("Save"),
              ),
            ],
          );
        }
    );
  }
  /// <<< If Incorrect Pin =====================================================


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pinProvider = Provider.of<HivePinProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + MediaQuery.of(context).size.height * 0.05,),
            Text("Enter Pin",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 28,color: Colors.black87),),
            SizedBox(height: 10,),
            Text("Please enter your 4-digit pin to continue..",style: TextStyle(fontSize: 18,color: Colors.grey),),
            SizedBox(height: 32,),
            Pinput(
              controller: controller,
              length: 4,
              obscureText: false,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
              validator: (value) => pinProvider.validatePin(value ?? '') ? null : 'Pin is incorrect',
              autofocus: true,
              onCompleted: (value) {
                if(pinProvider.validatePin(value)){_navigateTargetedPage();}
                else{controller.clear();setState(() { showRegisterButton = true; });}
              },
            ),

            SizedBox(height: 15,),
            if(showRegisterButton)...[
              TextButton(onPressed: _registerNewPin, child: Text("Register New PIN", style: TextStyle(fontSize: 18),textAlign: TextAlign.end,)),
            ],
            Spacer(),
            
            if(bioMetricsIsAvailable)...[
              Column(
                children: [
                  Text("or",style: TextStyle(fontSize: 18,color: Colors.grey),),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: isLoading ? null : _biometricAuthentication,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(color: Colors.blue[50],shape: BoxShape.circle,border: Border.all(color: Colors.blue[200]!)),
                      child: isLoading ? CircularProgressIndicator(strokeWidth: 2,valueColor: AlwaysStoppedAnimation(Colors.blue),):
                      Icon(Icons.fingerprint,size: 32,color: Colors.blue[600],),
                    ),
                  )
                ],
              )
            ],
            SizedBox(height: 10,),
            Text("use biometric",style: TextStyle(color: Colors.blue[600],fontSize: 18),),
            SizedBox(height: kBottomNavigationBarHeight + MediaQuery.of(context).size.height * 0.02,)
          ],
        ),
      ),
    );
  }
}
