import 'package:flutter/material.dart';
import 'package:ungfoodaroi/widgets/show_sign_out.dart';


class RiderService extends StatefulWidget {
  @override
  _RiderServiceState createState() => _RiderServiceState();
}

class _RiderServiceState extends State<RiderService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Welcome Rider'),),
       drawer: Drawer(child: ShowSignOut(),),
    );
  }
}