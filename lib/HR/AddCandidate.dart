import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../appbar.dart';
import '../routes.dart';
import './drawer.dart';

class AddCandidate extends StatefulWidget {
  final Map<String,dynamic> user;

  const AddCandidate(this.user);

  @override
  State<StatefulWidget> createState() {
    return AddCandidateState();
  }
}

class AddCandidateState extends State<AddCandidate> {
  String _skill, _level, _name, _experience, errMsg;
  bool showAuthMessage =false;
    bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }
  @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        drawer: getDrawer(context, this.widget.user),
        body: Material(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (String value) {
                              if (value.isEmpty)
                                return "Name is required";
                              else
                                return null;
                            },
                            onSaved: (String name) {
                               setState(() {
                                 _name = name; 
                               });
                            },
                           keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                icon: Icon(Icons.account_circle),
                                labelText: 'Name'
                                ),
                          ),
                          TextFormField(
                            validator: (String value) {
                              if (value.isEmpty)
                                return "Experience is required";
                              else
                                return null;
                            },
                            onSaved: (String experience) {
                              setState(() {
                               _experience = experience; 
                              });
                            },
                            style: TextStyle(fontWeight: FontWeight.w300),
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                                icon: Icon(Icons.star),
                                labelText: 'Experience (in years)'),
                          ),
                          SizedBox(height: 10.0),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              validator: (String value) {
                                if (value == null)
                                return "Skill is required";
                              else
                                return null;
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.computer),
                              ),
                              hint: Text("Select Primary Skill"),
                              value: _skill,
                              onChanged: (String skill) {
                                setState(() {
                                  _skill = skill;
                                });
                              },
                              items: [
                                DropdownMenuItem(child: Text('AEM'),value: 'AEM',),
                                DropdownMenuItem(child: Text('DEVOPS'),value: 'DEVOPS',),
                                DropdownMenuItem(child: Text('XT'),value: 'XT',),
                                DropdownMenuItem(child: Text('MARKETING'),value: 'MARKETING',),
                                ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              validator: (String value) {
                                if (value == null)
                                return "Level is required";
                              else
                                return null;
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.computer),
                              ),
                              hint: Text("Select Level of Designation"),
                              value: _level,
                              onChanged: (String level) {
                                setState(() {
                                  _level = level;
                                });
                              },
                              items: [
                                DropdownMenuItem(child: Text('ASSOCIATE L1'),value: 'ASSOCIATE L1',),
                                DropdownMenuItem(child: Text('ASSOCIATE L2'),value: 'ASSOCIATE L2',),
                                DropdownMenuItem(child: Text('SENIOR ASSOCIATE L1'),value: 'SENIOR ASSOCIATE L1',),
                                DropdownMenuItem(child: Text('SENIOR ASSOCIATE L2'),value: 'SENIOR ASSOCIATE L2',),
                                DropdownMenuItem(child: Text('MANAGER'),value: 'MANAGER',),
                                DropdownMenuItem(child: Text('SENIOR MANAGER'),value: 'SENIOR MANAGER',),
                                ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 10.0),
                              child: showAuthMessage
                                  ? Text(
                                       errMsg,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: "Nunito"),
                                          textAlign: TextAlign.center,
                                    )
                                  : SizedBox()),
                          Container(
                              width: MediaQuery.of(context).size.width / 4,
                              margin: EdgeInsets.only(
                                top: 40.0,
                              ),
                              child: FlatButton(
                                color: Theme.of(context).buttonColor,
                                child: Text(
                                  "POST",
                                  style: Theme.of(context).textTheme.button,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0)),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                   _formKey.currentState.save();
                                   setState(() {
                                      isLoading = true;
                                    });
                                  //   Make the http request and onSuccess, Navigate -- onError, setState
                                  http.post(URLs.POST_CANDIDATES_URL,headers: {"Content-type": "application/json"}, body: json.encode( {
                                      "name":_name,
                                      "exp" : _experience,
                                      "level": _level,
                                      "skillSet": [_skill]
                                  })).then((onValue) => {
                                    Navigator.of(context).pushNamedAndRemoveUntil(Routes.HR_LANDING_PAGE, (Route route) => route.settings.name == Routes.HR_LANDING_PAGE, arguments: {'user' : this.widget.user})
                                  }).catchError((onError) => {
                                    setState(() {
                                          isLoading = false;
                                          showAuthMessage = true;
                                          errMsg = onError.toString();
                                        })
                                  });
                                  }
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              isLoading
                  ? Container(
                      color: Colors.black45,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
