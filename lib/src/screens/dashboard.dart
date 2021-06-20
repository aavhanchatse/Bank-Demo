import 'package:bank_demo/src/providers/bankProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  static final routeName = '/dashboard';

  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _form = GlobalKey<FormState>();
  int _amount = 0;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(milliseconds: 2000),
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Future<void> _showBalance(BuildContext context) async {
    final provider = Provider.of<BankProvider>(context, listen: false);
    final amount = provider.amount;

    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            children: <Widget>[
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Balance',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    amount.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                ],
              )
            ],
          );
        })) {
    }
  }

  void _withdraw() {
    FocusScope.of(context).unfocus();

    final valid = _form.currentState!.validate();
    if (!valid) {
      return;
    }
    if (_amount > 2000) {
      _showSnackBar('Maximum withdraw limit is Rs. 2000');
      _form.currentState!.reset();
      return;
    }

    final provider = Provider.of<BankProvider>(context, listen: false);
    final balance = provider.amount;

    if (balance < _amount) {
      _showSnackBar("You don't have enough balance for this transaction.");
      _form.currentState!.reset();
      return;
    }

    provider.withdraw(_amount);

    _form.currentState!.reset();
    _showSnackBar('Transaction Successful');
  }

  void _deposit() {
    FocusScope.of(context).unfocus();

    final valid = _form.currentState!.validate();
    if (!valid) {
      return;
    }

    final provider = Provider.of<BankProvider>(context, listen: false);
    provider.deposit(_amount);

    _form.currentState!.reset();
    _showSnackBar('Transaction Successful');
  }

  void onChange(String value) {
    setState(() {
      if (value == '') {
        _amount = 0;
      } else {
        _amount = int.parse(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BankProvider>(context);
    final name = provider.name;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80,
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Account Holders Name',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Enter Amount',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      inputField(),
                    ],
                  ),
                ),
              ),
              buttons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField() {
    return Form(
      key: _form,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          onChange(value);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter amount';
          }
          if (int.parse(value) < 0) {
            return 'Enter valid amount';
          }
          return null;
        },
      ),
    );
  }

  Widget buttons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                _withdraw();
              },
              child: Text(
                'Withdraw',
              )),
          TextButton(
              onPressed: () {
                _showBalance(context);
              },
              child: Text(
                'Balance',
              )),
          TextButton(
              onPressed: () {
                _deposit();
              },
              child: Text(
                'Deposit',
              )),
        ],
      ),
    );
  }
}
