import 'package:flutter/material.dart';

class BankProvider with ChangeNotifier {
  String _name = '';
  int _amount = 0;

  get name => _name;

  get amount => _amount;

  set setName(String val) {
    _name = val;
  }

  set setAmount(int val) {
    _amount = val;
  }

  void withdraw(int val) {
    _amount = _amount - val;
    print(_amount);

    notifyListeners();
  }

  void deposit(int val) {
    _amount = _amount + val;
    print(_amount);

    notifyListeners();
  }
}
