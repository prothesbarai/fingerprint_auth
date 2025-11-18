import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintAndPinAuth extends StatefulWidget {
  const FingerprintAndPinAuth({super.key});

  @override
  State<FingerprintAndPinAuth> createState() => _FingerprintAndPinAuthState();
}

class _FingerprintAndPinAuthState extends State<FingerprintAndPinAuth> {

  final LocalAuthentication localAuthentication = LocalAuthentication();
  final String pin = '1234';
  final TextEditingController controller = TextEditingController();
  bool bioMetricsIsAvailable = false;
  bool isLoading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Column(
        children: [

        ],
      ),
    );
  }
}
