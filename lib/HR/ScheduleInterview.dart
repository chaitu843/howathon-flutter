import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_template/routes.dart';
import 'package:http/http.dart' as http;

import '../appbar.dart';
import './drawer.dart';

// class ScheduleInterview extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return ScheduleInterviewState();
//   }
// }

Future fetchCandidates() async {
  final response = await http.get(URLs.GET_CANDIDATES_URL);
  return json.decode(response.body);
}

class ScheduleInterview extends StatelessWidget {
  final Map<String, dynamic> user;

  const ScheduleInterview(this.user);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      drawer: getDrawer(context, this.user),
      body: Center(
        child: FutureBuilder(
          future: fetchCandidates(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                      title: Text(snapshot.data[index]['name']),
                      leading: Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(1, 63, 80, 1.0),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      enabled: true,
                      trailing: InkWell(
                        child: Icon(Icons.schedule,
                            size: 25.0, color: Colors.green),
                        onTap: () {
                          // Open a dialog, take the data and make a http post request with ID of candidate
                        },
                      ),
                    ),
                  );
                },
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
        ),
      ),
    );
  }
}
