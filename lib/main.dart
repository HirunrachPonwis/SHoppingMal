import 'package:flutter/material.dart';
import 'package:shoppingmallbydew/states/authen.dart';

import 'package:shoppingmallbydew/states/create_account.dart';
import 'package:shoppingmallbydew/states/rider_service.dart';

import 'package:shoppingmallbydew/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/riderService': (BuildContext context) => RiderService(),
};

String? initlalRoute;

void main() {
  initlalRoute = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}
