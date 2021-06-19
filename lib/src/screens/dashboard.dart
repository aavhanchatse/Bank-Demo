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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BankProvider>(context);
    final name = provider.name;
    final amount = provider.amount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Account Holders Name',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Balance',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              amount.toString(),
              style: TextStyle(fontSize: 24),
            ),
            TextFormField()
        
          ],
        ),
      ),
    );
  }
}
