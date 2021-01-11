import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Constants {

  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static toastMessage({@required String msg}){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 15.0
    );
  }

  static Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static progressDialog(bool isLoading, BuildContext context) {
    AlertDialog dialog =  AlertDialog(
      backgroundColor: Colors.black,
      content:  Container(
          color: Colors.black,
          height: 40.0,
          child:  Center(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Please wait",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,
                    fontSize: 18
                ),),
                SizedBox(height: 8),
                LinearProgressIndicator(backgroundColor: Colors.white)
              ],
            ),
          )),
      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    );
    if (!isLoading) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }
  }
}
