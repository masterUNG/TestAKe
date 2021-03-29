import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungfoodaroi/body/show_order_shop.dart';
import 'package:ungfoodaroi/body/show_product_shop.dart';
import 'package:ungfoodaroi/body/show_shop_shop.dart';
import 'package:ungfoodaroi/widgets/header_drawer.dart';
import 'package:ungfoodaroi/widgets/show_sign_out.dart';

class ShoperSerivce extends StatefulWidget {
  @override
  _ShoperSerivceState createState() => _ShoperSerivceState();
}

class _ShoperSerivceState extends State<ShoperSerivce> {
  String name;
  List<Widget> widgets = [
    ShowOrderShop(),
    ShowShopShop(),
    ShowProductShop(),
  ];
  Widget current;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDataUser();
    current = widgets[0];
  }

  Future<Null> readDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Shoper'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                HeaderDrawer(
                  name: name == null ? 'name' : name,
                  typeUser: 'Shoper',
                  pathWall: 'images/shoper.jpg',
                ),
                buildMenuShowOrder(),
                buildMenuShowShop(),
                buildMenuShowProduct(),
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),body: current,
    );
  }

  ListTile buildMenuShowOrder() {
    return ListTile(
      leading: Icon(Icons.filter_1),
      title: Text('Show Order'),
      subtitle: Text('แสดง Order ที่ลูกค้า สั่งซื้อ'),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          current = widgets[0];
        });
      },
    );
  }

  ListTile buildMenuShowShop() {
    return ListTile(
      leading: Icon(Icons.filter_2),
      title: Text('Show Shop'),
      subtitle: Text('แสดง รายละเอียดร้าน'),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          current = widgets[1];
        });
      },
    );
  }

  ListTile buildMenuShowProduct() {
    return ListTile(
      leading: Icon(Icons.filter_3),
      title: Text('Show Product'),
      subtitle: Text('แสดง สินค้าของร้าน'),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          current = widgets[2];
        });
      },
    );
  }
}
