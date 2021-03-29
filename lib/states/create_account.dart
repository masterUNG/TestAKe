import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungfoodaroi/utility/dialog.dart';
import 'package:ungfoodaroi/widgets/show_wallpaper.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String typeUser, name, user, password;

  Container buildName() {
    return Container(
      decoration: BoxDecoration(color: Colors.white70),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.fingerprint),
          labelText: 'Name :',
        ),
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
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
          labelText: 'Password :',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Stack(
        children: [
          ShowWallpaper(),
          buildCenter(),
        ],
      ),
    );
  }

  Center buildCenter() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildName(),
            buildRadio(),
            buildUser(),
            buildPassword(),
            buildCreateAccount(),
          ],
        ),
      ),
    );
  }

  Future<Null> checkAndInsertUser() async {
    String apiCheckUser =
        'https://androidthai.in.th/ae/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiCheckUser).then((value) async {
      if (value.toString() != 'null') {
        normalDialot(context, 'User ซ้ำ',
            'โปรดเปลี่ยน User ใหม่ ? User นี่มีคนอื่นใช้ไปแล้ว');
      } else {
        String apiInsertData =
            'https://androidthai.in.th/ae/insertDataUng.php?isAdd=true&name=$name&user=$user&password=$password&typeUser=$typeUser';
        await Dio().get(apiInsertData).then((value) => Navigator.pop(context));
      }
    });
  }

  Container buildCreateAccount() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((name?.isEmpty ?? true) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            normalDialot(context, 'Have Space', 'Please Fill Every Blank');
          } else if (typeUser?.isEmpty ?? true) {
            normalDialot(context, 'ยังไม่ได้เลือก ชนิดของ User',
                'กรุณาเลือก ชนิดของ User ด้วย คะ ?');
          } else {
            checkAndInsertUser();
          }
        },
        child: Text('Create Account'),
      ),
    );
  }

  Container buildRadio() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value;
              });
            },
            title: Text('Buyer'),
          ),
          RadioListTile(
            value: 'shoper',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value;
              });
            },
            title: Text('Shoper'),
          ),
          RadioListTile(
            value: 'rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value;
              });
            },
            title: Text('Rider'),
          ),
        ],
      ),
    );
  }
}
