import 'dart:convert';

import 'package:flutter/material.dart';
import './drawer.dart';
import 'package:flutter_template/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

import '../routes.dart';

Future getRequirements() async {
  final response = await http.get(URLs.GET_REQUIREMENTS_URL);
  return json.decode(response.body);
}

class StaffingLandingPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const StaffingLandingPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return StaffingLandingPageState();
  }
}

class StaffingLandingPageState extends State<StaffingLandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> lufthansaMap = new Map(),
        tescoMap = new Map(),
        lloydsMap = new Map();
    int lufthansaReq = 0, tescoReq = 0, lloydsReq = 0;
    String key, skill, level, dummy = '_';
    return Scaffold(
      appBar: getAppBar(),
      drawer: getDrawer(context, this.widget.user),
      body: FutureBuilder(
        future: getRequirements(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            lufthansaReq = 0; tescoReq = 0; lloydsReq = 0;
            lufthansaMap = new Map();
            tescoMap = new Map();
            lloydsMap = new Map();
            for (var i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i]['account']['accname'] == 'Lufthansa') {
                skill = snapshot.data[i]['account']['skillSet'][0];
                level = snapshot.data[i]['account']['level'];
                key = skill + dummy + level;
              if(lufthansaMap.containsKey(key)) lufthansaMap.update(key, (value) => value + snapshot.data[i]['account']['req'].toDouble());
                else {
                   lufthansaMap.putIfAbsent(
                    key, () => snapshot.data[i]['account']['req'].toDouble());
                }
                lufthansaReq += snapshot.data[i]['account']['req'];
              } else if (snapshot.data[i]['account']['accname'] == 'Tesco') {
                skill = snapshot.data[i]['account']['skillSet'][0];
                level = snapshot.data[i]['account']['level'];
                key = skill + dummy + level;
               if(tescoMap.containsKey(key)) tescoMap.update(key, (value) => value+snapshot.data[i]['account']['req'].toDouble());
                else {
                   tescoMap.putIfAbsent(
                    key, () => snapshot.data[i]['account']['req'].toDouble());
                }
                tescoReq += snapshot.data[i]['account']['req'];
              } else if (snapshot.data[i]['account']['accname'] == 'Lloyds') {
                skill = snapshot.data[i]['account']['skillSet'][0];
                level = snapshot.data[i]['account']['level'];
                key = skill + dummy + level;
                if(lloydsMap.containsKey(key)) lloydsMap.update(key, (value) => value + snapshot.data[i]['account']['req'].toDouble());
                else {
                   lloydsMap.putIfAbsent(
                    key, () => snapshot.data[i]['account']['req'].toDouble());
                }
                lloydsReq += snapshot.data[i]['account']['req'];
              }
            }
            // return Text('Doing Soem');
            return SingleChildScrollView(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 15.0,),
                  Text('Requirements per Account', style: TextStyle(fontSize: 26.0, fontFamily: 'Nunito Bold', color: Theme.of(context).primaryColor),),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        PieChart(
                          dataMap: tescoMap,
                          legendFontColor: Colors.black,
                          legendFontSize: 16.0,
                          legendFontWeight: FontWeight.bold,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32.0,
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                          showChartValuesInPercentage: false,
                          showChartValues: true,
                          chartValuesColor:
                              Colors.white,
                          showLegends: true,
                        ),
                        Text('TESCO($tescoReq)', style: TextStyle(fontSize: 18.0, color:Color.fromRGBO(1, 63, 80, 1.0), fontWeight: FontWeight.bold), ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        PieChart(
                          dataMap: lloydsMap,
                          legendFontColor: Colors.black,
                          legendFontSize: 16.0,
                          legendFontWeight: FontWeight.bold,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32.0,
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                          showChartValuesInPercentage: false,
                          showChartValues: true,
                          chartValuesColor:
                              Colors.white,
                          showLegends: true,
                        ),
                        Text('LLOYDS($lloydsReq)', style: TextStyle(fontSize: 18.0, color:Color.fromRGBO(1, 63, 80, 1.0), fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        PieChart(
                          dataMap: lufthansaMap,
                          legendFontColor: Colors.black,
                          legendFontSize: 16.0,
                          legendFontWeight: FontWeight.bold,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32.0,
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                          showChartValuesInPercentage: false,
                          showChartValues: true,
                          chartValuesColor:
                              Colors.white,
                          showLegends: true,
                        ),
                        Text('LUFTHANSA($lufthansaReq)', style: TextStyle(fontSize: 18.0, color:Color.fromRGBO(1, 63, 80, 1.0), fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0,)
                ],
              ),);
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
      ),
    );
  }
}
