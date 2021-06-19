import 'package:bank_demo/src/providers/bankProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _form = GlobalKey<FormState>();

  String _name = '';
  int _amount = 0;

  void onCreate() {
    FocusScope.of(context).unfocus();
    
    final valid = _form.currentState!.validate();
    if (!valid) {
      return;
    }

    final provider = Provider.of<BankProvider>(context, listen: false);

    provider.setName = _name;
    provider.setAmount = _amount;

    Navigator.of(context).pushNamedAndRemoveUntil(
        '/dashboard', ModalRoute.withName('/dashboard'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[100],
                ),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Create an account',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      nameField(),
                      SizedBox(height: 10),
                      amountField(),
                      SizedBox(height: 50),
                      createButton(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createButton() {
    return ElevatedButton(
      onPressed: onCreate,
      child: Text(
        'Create',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter name';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Name',
      ),
      style: TextStyle(fontSize: 18),
    );
  }

  Widget amountField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter amount';
        }
        if (int.parse(value) < 2000) {
          return 'Minimum amount is Rs. 2000';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          if (value == '') {
            _amount = 0;
          } else {
            _amount = int.parse(value);
          }
        });
      },
      decoration: InputDecoration(
        labelText: 'Amount',
      ),
      style: TextStyle(fontSize: 18),
    );
  }
}
