import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prashantmishrasquareyards/Networking/config.dart';
import 'package:prashantmishrasquareyards/Utils/AppRoute.dart';
import 'package:prashantmishrasquareyards/Utils/Constants.dart';

class EnquiryScreen extends StatefulWidget {
  @override
  _EnquiryScreenState createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  int mobileNumber;
  final _formKey = GlobalKey<FormState>();
  final ApiProvider _api = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask Us'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Your Email id'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email id';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      mobileNumber = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                      hintText: 'Enter Your Mobile Number'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _enquiry();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _enquiry() async {
    if (_formKey.currentState.validate()) {
      Constants.progressDialog(true, context);
      Map<String, dynamic> map = {
        "name": nameController.text,
        "email": emailController.text,
        "mobile": mobileNumber.toInt(),
      };
      var result = await _api.enquiryService(map);
      Constants.progressDialog(false, context);
      if (result != null) {
        Navigator.pushReplacementNamed(context, home_screen);
        Constants.toastMessage(msg: 'Your Enquiry is Sent Successfully');
      } else {
        Constants.toastMessage(msg: 'Enquiry Not Sent');
      }
    }
  }
}
