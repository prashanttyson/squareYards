import 'package:flutter/material.dart';
import 'package:prashantmishrasquareyards/Screens/enquiry_screen.dart';
import 'package:prashantmishrasquareyards/Screens/home_screen.dart';


const home_screen = 'home_screen';
const enquiry_screen = 'enquiry_screen';


Map<String,WidgetBuilder> getAppRoute(){
  return {
     '/': (BuildContext context) => HomeScreen(),
     home_screen: (BuildContext context) => HomeScreen(),
    enquiry_screen: (BuildContext contex)=> EnquiryScreen(),

  };
}