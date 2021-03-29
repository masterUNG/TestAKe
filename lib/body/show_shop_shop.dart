import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungfoodaroi/widgets/show_process.dart';

class ShowShopShop extends StatefulWidget {
  @override
  _ShowShopShopState createState() => _ShowShopShopState();
}

class _ShowShopShopState extends State<ShowShopShop> {
  bool statusLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDataShop();
  }

  Future<Null> readDataShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    String apiReadShop =
        'https://androidthai.in.th/ae/getShopWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiReadShop).then((value) {
      setState(() {
        statusLoad = false;
      });
      if (value.toString() == 'null') {
      } else {}
    });
  }

  // Test

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: statusLoad ? ShowProcess() :  Text('Load Finish') ,
    );
  }
}
