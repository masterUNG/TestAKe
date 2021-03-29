import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungfoodaroi/models/user_model.dart';
import 'package:ungfoodaroi/utility/dialog.dart';
import 'package:ungfoodaroi/widgets/show_wallpaper.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ShowWallpaper(),
          buildCreateAccount(),
          buildCenter(),
        ],
      ),
    );
  }

  Column buildCreateAccount() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Non Account ?'),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/createAccount'),
              child: Text('Create Account'),
            ),
          ],
        ),
      ],
    );
  }

  Center buildCenter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildLogo(),
          buildAppName(),
          buildUser(),
          buildPassword(),
          buildLogin(),
        ],
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String apiCheckAuthen =
        'https://androidthai.in.th/ae/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiCheckAuthen).then((value) async {
      if (value.toString() == 'null') {
        normalDialot(
            context, 'User False', 'ไม่มี $user นี่ ในฐานข้อมูลของเรา');
      } else {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);

          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('id', model.id);
          preferences.setString('name', model.name);
          preferences.setString('typeUser', model.typeUser);

          if (password == model.password) {
            switch (model.typeUser) {
              case 'buyer':
                Navigator.pushNamedAndRemoveUntil(
                    context, '/buyerService', (route) => false);
                break;
              case 'shoper':
                Navigator.pushNamedAndRemoveUntil(
                    context, '/shopService', (route) => false);
                break;
              case 'rider':
                Navigator.pushNamedAndRemoveUntil(
                    context, '/riderService', (route) => false);
                break;
              default:
            }
          } else {
            normalDialot(
                context, 'Password False ?', 'กรุณาลองใหม่ password คุณผิด');
          }
        }
      }
    });
  }

  Container buildLogin() {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialot(context, 'มีช่องว่าง', 'กรุณา กรอกทุกช่อง สิคะ');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(color: Colors.white70),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: 'User :',
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(color: Colors.white70),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: 250,
      child: TextField(
        obscureText: true,
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
          labelText: 'Password :',
        ),
      ),
    );
  }

  Text buildAppName() {
    return Text(
      'Ung Food Aroi',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue[900],
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/logo.png'),
    );
  }
}
