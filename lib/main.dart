import 'package:flutter/material.dart';
import 'package:flutter_template/HR/AddCandidate.dart';
import 'package:flutter_template/HR/ScheduleInterview.dart';
import 'package:flutter_template/InterviewerPage/LandingPage.dart';
import 'package:flutter_template/STAFFING/LandingPage.dart';

import './HR/LandingPage.dart';
import './routes.dart';

import './AuthPage/AuthPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Troublemakers',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(1, 63, 80, 1.0),
            elevation: 5.0,
            iconTheme:
                IconThemeData(color: Colors.white, size: 8.0, opacity: 1.0),
          ),
          backgroundColor: Colors.white,
          dialogBackgroundColor: Colors.black45,
          bottomAppBarColor: Colors.black,
          buttonColor: Color.fromRGBO(1, 63, 80, 1.0),
          buttonTheme: ButtonThemeData(
            buttonColor: Color.fromRGBO(1, 63, 80, 1.0),
            disabledColor: Colors.grey,
            layoutBehavior: ButtonBarLayoutBehavior.constrained,
            textTheme: ButtonTextTheme.primary,
          ),
          disabledColor: Colors.grey,
          errorColor: Colors.red,
          iconTheme: IconThemeData(
            color: Colors.blue,
            size: 8.0,
          ),
          primaryColor: Color.fromRGBO(1, 63, 80, 1.0),
          textTheme: TextTheme(
            display1: TextStyle(
              color: Color.fromRGBO(196, 171, 133, 1.0),
              decoration: TextDecoration.none,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Nunito',
            ), // Secondary Normal
            display2: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontFamily: 'Nunito',
            ),       // Black Bold
            body1: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Nunito Bold',
            ), // Black normal
            body2: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Nunito',
            ), // Black Normal
            button: TextStyle(color: Colors.white, fontFamily: 'Nunito Bold'),
          ),
          inputDecorationTheme: InputDecorationTheme(
              focusColor: Color.fromRGBO(1, 63, 80, 1.0),
              contentPadding: EdgeInsets.all(10.0)),
        ),
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
        onGenerateRoute: (settings) {
          final Map<String, dynamic> arguments = settings.arguments;
          switch (settings.name) {
            case Routes.HR_LANDING_PAGE:
              return MaterialPageRoute(builder: (context) => HRLandingPage(arguments['user']));
            case Routes.HR_SCHEDULE_INTERVIEW_PAGE:
              return MaterialPageRoute(builder: (context) => ScheduleInterview(arguments['user']));
            case Routes.HR_ADD_CANDIDATE_PAGE:
              return MaterialPageRoute(builder: (context) => AddCandidate(arguments['user']));
            case Routes.STAFFING_LANDING_PAGE:
              return MaterialPageRoute(builder: (context) => StaffingLandingPage(arguments['user']));
            case Routes.INTERVIEWER_LANDING_PAGE:
              return MaterialPageRoute(builder: (context) => InterviewCandidate(arguments['user']));
            default:
              return MaterialPageRoute(builder: (context) => AuthPage());
          }
        }
        );
  }
}
