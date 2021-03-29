import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungfoodaroi/states/authen.dart';
import 'package:ungfoodaroi/states/buyer_service.dart';
import 'package:ungfoodaroi/states/create_account.dart';
import 'package:ungfoodaroi/states/rider_service.dart';
import 'package:ungfoodaroi/states/shoper_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/shopService': (BuildContext context) => ShoperSerivce(),
  '/riderService': (BuildContext context) => RiderService(),
};

String initialRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String typeUser = preferences.getString('typeUser');
  if (typeUser?.isEmpty ?? true) {
    initialRoute = '/authen';
    runApp(MyApp());
  } else {
    switch (typeUser) {
      case 'buyer':
        initialRoute = '/buyerService';
        runApp(MyApp());
        break;
      case 'shoper':
        initialRoute = '/shopService';
        runApp(MyApp());
        break;
      case 'rider':
        initialRoute = '/riderService';
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
