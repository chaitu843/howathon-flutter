import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_template/routes.dart';
import 'package:http/http.dart' as http;

import '../appbar.dart';
import './drawer.dart';

class InterviewCandidate extends StatefulWidget {
  final Map<String, dynamic> user;

  const InterviewCandidate(this.user);

  @override
  State<StatefulWidget> createState() {
    return InterviewCandidateState();
  }
}

Future fetchCandidates() async {
  final response = await http.get(URLs.GET_CANDIDATES_FOR_INTERVIEWER_URL);
  return json.decode(response.body);
}

class InterviewCandidateState extends State<InterviewCandidate> {
  bool isLoading = false;
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
        child: isLoading
            ? Container(
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              )
            : FutureBuilder(
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
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text('Select the candidate'),
                                        backgroundColor: Colors.white,
                                        contentPadding: EdgeInsets.only(
                                            top: 20.0, left: 20.0, right: 20.0),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'SELECT',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .color),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              http
                                                  .post(
                                                      URLs
                                                          .POST_STATUS_FOR_CANDIDATE_URL,
                                                      headers: {
                                                        "Content-type":
                                                            "application/json"
                                                      },
                                                      body: json.encode({
                                                        'candidateId': snapshot
                                                            .data[index]['_id'],
                                                        'status': 'bench'
                                                      }))
                                                  .then((onValue) {
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        Routes
                                                            .INTERVIEWER_LANDING_PAGE,
                                                        (Route route) =>
                                                            route == null, arguments: {'user':this.widget.user});
                                              });
                                            },
                                          ),
                                          FlatButton(
                                              child: Text(
                                                'REJECT',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .display1
                                                        .color),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                http
                                                    .post(
                                                        URLs
                                                            .POST_STATUS_FOR_CANDIDATE_URL,
                                                        headers: {
                                                          "Content-type":
                                                              "application/json"
                                                        },
                                                        body: json.encode({
                                                          'candidateId':
                                                              snapshot.data[
                                                                  index]['_id'],
                                                          'status': 'rejected'
                                                        }))
                                                    .then((onValue) {
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          Routes
                                                              .INTERVIEWER_LANDING_PAGE,
                                                          (Route route) =>
                                                              route == null, arguments: {'user' : this.widget.user});
                                                },);
                                              }),
                                        ],
                                      );
                                    });
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
