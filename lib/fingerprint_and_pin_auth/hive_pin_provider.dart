import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HivePinProvider with ChangeNotifier{
  final Box pinBox = Hive.box("pinBox");

  String get pin => pinBox.get("userPin",defaultValue: '1234');

  void setPin(String newPin) async{
    await pinBox.put("userPin", newPin);
    notifyListeners();
  }

  bool validatePin(String enteredPin) => enteredPin == pin;

}