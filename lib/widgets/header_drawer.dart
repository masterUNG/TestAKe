import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  final String name, typeUser, pathWall;
  HeaderDrawer({@required this.name, this.typeUser, this.pathWall});
  @override
  _HeaderDrawerState createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  String name, typeUser, pathWall;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
    typeUser = widget.typeUser;
    pathWall = widget.pathWall;
  }

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(pathWall),
          fit: BoxFit.cover,
        ),
      ),
      accountName: Text(name),
      accountEmail: Text(typeUser),
      currentAccountPicture: Image.asset('images/logo.png'),
    );
  }
}
