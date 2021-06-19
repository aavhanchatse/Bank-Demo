import 'package:bank_demo/src/providers/bankProvider.dart';
import 'package:bank_demo/src/screens/addAccount.dart';
import 'package:bank_demo/src/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BankProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AddAccount(),
        routes: {
          Dashboard.routeName: (context) => Dashboard(),
        },
      ),
    );
  }
}