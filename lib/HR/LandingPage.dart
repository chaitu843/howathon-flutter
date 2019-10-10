import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_template/HR/drawer.dart';
import 'package:flutter_template/appbar.dart';
import 'package:http/http.dart' as http;
import '../routes.dart';

Future fetchSuccessRatioAndRequiredInterviews() async {
  final response = await http.get(URLs.GET_REQUIRED_INTERVIEWS_URL);
  return json.decode(response.body);
}
class HRLandingPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const HRLandingPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return HRLandingPageState();
  }
}

class HRLandingPageState extends State<HRLandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      drawer: getDrawer(context, this.widget.user),
      body: Center(
          child: FutureBuilder(
        future: fetchSuccessRatioAndRequiredInterviews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Text(snapshot.data['successPercentage'], style: TextStyle(color: Colors.white),),
                        Text('Success', style: TextStyle(color: Colors.white),),
                        Text('Ratio', style: TextStyle(color: Colors.white),)
                      ],
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: EdgeInsets.all(30.0),
                    child: Column( 
                      children:<Widget>[
                        Text(snapshot.data['totalReq'].toString(), style: TextStyle(color: Colors.white),),
                        Text('Candidates', style: TextStyle(color: Colors.white,),),
                        Text('Required', style: TextStyle(color: Colors.white,),)
                      ],
                    )
                  )
                ],),
                 Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: EdgeInsets.all(50.0),
                    child: Column(
                      children: <Widget>[
                        Text(snapshot.data['forcastInterviews'].toString(), style: TextStyle(color: Colors.white),),
                        Text('Interviews', style: TextStyle(color: Colors.white),),
                        Text('Required', style: TextStyle(color: Colors.white),)
                      ],
                    )
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text(
                snapshot.error,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return Container(
            color: Colors.black45,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            ),
          );
        },
      )),
    );
  }
}
