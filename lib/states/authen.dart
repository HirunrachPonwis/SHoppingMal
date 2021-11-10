import 'package:flutter/material.dart';
import 'package:shoppingmallbydew/utility/my_constant.dart';
import 'package:shoppingmallbydew/widgets/show_image.dart';
import 'package:shoppingmallbydew/widgets/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          //เมื่อเปิด คีย์บอร์อขขึนมาแล้ว click ตรงที่ว่างเปล่าคีย์บอร์ดจะทำการเก็บพับลงไป
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: [
              buildImage(size),
              buildAppName(),
              buildCreateAccount(),
              buildLogin(size),
            ],
          ),
        ),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowTitle(title:'Are you ready ?', textStyle: MyConstant().h3Style(),),
                //TextButton(onPressed: ()=> Navigator.pushNamed(context, MyConstant.routeCreateAccount), child: Text('Ready'),)
              ],
            );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical:16), //กำหนดให้ปุ่ม login ห่างจากกล่องข้อความทั้งบนและล่าง
          width: size * 0.2,
          child: ElevatedButton(
            style: MyConstant().myBottonStyle(),
            onPressed: () => Navigator.pushNamed(context, MyConstant.routeCreateAccount),
            child: Text('start',style: MyConstant().h4Style(),),
          ),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'User:',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            obscureText: statusRedEye, //password to *
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye =
                        !statusRedEye; //when click on RedEye จะโชว์รหัส และแมื่อกดอีกครั้งจะซ่อนรหัส
                  });
                },
                icon: statusRedEye
                    ? Icon(
                        //การเขียน if else อย่างง่าย ถ้าเป็น true ทำหลัง ? ถ้าเป็น false ทำหลัง :
                        Icons.remove_red_eye,
                        color: MyConstant.dark,
                      )
                    : Icon(
                        Icons.remove_red_eye_outlined,
                        color: MyConstant.dark,
                      ),
              ),
              labelStyle: MyConstant().h3Style(),
              labelText: 'Password:',
              prefixIcon: Icon(
                Icons.lock_outline,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: MyConstant.appName,
          textStyle: MyConstant().h1Style(),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 1.0,
          child: ShowImage(path: MyConstant.image6),
        ),
      ],
    );
  }
}
