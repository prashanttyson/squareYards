import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prashantmishrasquareyards/Model/PropertyDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prashantmishrasquareyards/Utils/AppRoute.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PropertyDetails propertyDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Square Yards'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Text('Square Yards',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  Icon(Icons.home_rounded,size: 100,),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, enquiry_screen);
              },
              child: ListTile(
                title: Text('Ask Us'),

              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<PropertyDetails>>(
        future: _fetchPropertyDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PropertyDetails> data = snapshot.data;
            return _propertiesListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<PropertyDetails>> _fetchPropertyDetails() async {
    final propertiesListAPIUrl =
        'https://5fcb788251f70e00161f19cd.mockapi.io/api/v1/properties';
    final response = await http.get(propertiesListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((properties) => new PropertyDetails.fromJson(properties))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _propertiesListView(data) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _items(data[index].propertyName, data[index].address,
              data[index].bedroom, data[index].washroom, data[index].image);
        });
  }

  Container _items(
          String property, String address, String bedroom, String washroom, String image) =>
      Container(
        height: MediaQuery.of(context).size.height*0.4,
        margin: EdgeInsets.only(top:30,left:30,right:30),
        decoration: BoxDecoration(

            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Card(
          color: Colors.blueGrey[50],
          shadowColor:Colors.black,
          elevation: 10,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.black87,
                  child: Text(property,
                      style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          height: MediaQuery.of(context).size.height*0.2,
                          child: Image(
                            image: NetworkImage(image),
                            alignment: Alignment.topRight,
                            fit: BoxFit.fill,
                          ),
                        ),

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Text('Bedroom(s)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                        Text(bedroom),
                        Text('Washroom(s)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                        Text(washroom),
                      ],
                    ),





                  ],
                ),
                Container(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(address,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      )),
                ),
                RaisedButton(
                  color: Colors.black,
                  child: Text("Enquire",style: TextStyle(color: Colors.white),),
                  onPressed: () => Navigator.of(context).pushNamed(enquiry_screen),
                ),
              ],
            ),

        ),
      );

  }

