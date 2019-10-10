import 'dart:convert';

import 'package:flutter/material.dart';
import '../routes.dart';
import 'package:http/http.dart' as http;

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  String _ntId, _password, errMsg;
  bool showAuthMessage = false;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/logo/logo_256.jpg'),
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
                            return "NT Id is required";
                          else
                            return null;
                        },
                        onSaved: (String ntId) {
                          setState(() {
                            _ntId = ntId;
                          });
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle),
                            labelText: 'Oracle Id'),
                      ),
                      TextFormField(
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Password is required";
                          else if (value.length < 8)
                            return "Password should contain minimum 8 characters";
                          else
                            return null;
                        },
                        onSaved: (String password) {
                          setState(() {
                            _password = password;
                          });
                        },
                        style: TextStyle(fontWeight: FontWeight.w300),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.security), labelText: 'Password'),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: showAuthMessage
                              ? Text(
                                  errMsg,
                                  style: TextStyle(
                                      color: Colors.red, fontFamily: "Nunito"),
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
                              "Login",
                              style: Theme.of(context).textTheme.button,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0)),
                            onPressed: () {
                              // Navigator.of(context).pushNamedAndRemoveUntil(
                              //     Routes.HR_LANDING_PAGE,
                              //     (Route route) {
                              //   if (route == null) return true;
                              //   return false;
                              // }, arguments: {
                              //   'user': {'name': 'Chaitu', 'role': 'STAFFING'}
                              // });
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  // Make the http request and onSuccess, Navigate -- onError, setState
                                  http
                                      .post(URLs.LOGIN_URL,
                                          headers: {
                                            "Content-type": "application/json"
                                          },
                                          body: json.encode({
                                            "ntId": _ntId,
                                            "password": _password
                                          }))
                                      .then((onValue) {
                                    Map<String, dynamic> response =
                                        json.decode(onValue.body);
                                    if (response['login']){
                                      if(response['role'] == 'HR') {
                                        Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              Routes.HR_LANDING_PAGE,
                                              (Route route) {
                                        if (route == null) return true;
                                        return false;
                                      }, arguments: {'user': response});
                                      } else if (response['role'] == 'Staffing') {
                                        Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              Routes.STAFFING_LANDING_PAGE,
                                              (Route route) {
                                        if (route == null) return true;
                                        return false;
                                      }, arguments: {'user': response});
                                      } else if (response['role'] == 'Interviewer') {
                                        Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              Routes.INTERVIEWER_LANDING_PAGE,
                                              (Route route) {
                                        if (route == null) return true;
                                        return false;
                                      }, arguments: {'user': response});
                                      } else
                                      setState(() {
                                        isLoading = false;
                                        showAuthMessage = true;
                                        errMsg = 'Invalid Credentails';
                                      });
                                    }
                                    else
                                      setState(() {
                                        isLoading = false;
                                        showAuthMessage = true;
                                        errMsg = 'Invalid Credentails';
                                      });
                                  }).catchError((onError) {
                                    setState(() {
                                      isLoading = false;
                                      showAuthMessage = true;
                                      errMsg = onError.toString();
                                    });
                                  });
                                }
                            },
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              )
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
    );
  }
}

/*
 * State is being set on click of login button, provided form is validated. Then call to database should be happened with the state variables, and set isLoading to true.
 * showAuthMessage for the error from database
 * 
 * 
 * 
 * Stack of a column and the loader, column of Image and form, form inturn containing a column of 2 form fields and 2 buttons
*/
