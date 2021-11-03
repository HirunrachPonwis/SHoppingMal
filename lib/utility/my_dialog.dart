//import 'dart:js';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoppingmallbydew/utility/my_constant.dart';
import 'package:shoppingmallbydew/widgets/show_image.dart';
import 'package:shoppingmallbydew/widgets/show_title.dart';

class MyDialog {
  Future<Null> alertLocationservice(BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image4),
          title: ShowTitle(
            title:title ,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(
            title: message,
            textStyle: MyConstant().h3Style(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openLocationSettings();
                exit(0); //ให้ทำการปิด app เราทิ้ง
              },
              child: Text('OK'))
        ],
      ),
    );
  }
}
