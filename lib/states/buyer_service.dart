import 'package:flutter/material.dart';
import 'package:ungfoodaroi/widgets/show_sign_out.dart';

class BuyerService extends StatefulWidget {
  @override
  _BuyerServiceState createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Buyer'),),
      drawer: Drawer(child: ShowSignOut(),),
    );
  }
}