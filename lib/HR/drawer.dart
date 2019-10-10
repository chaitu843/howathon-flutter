import 'package:flutter/material.dart';
import '../routes.dart';

void drawerCallback(context, value, user) {
    switch (value) {
      case 'scheduleInterview':
        Navigator.of(context).pop();
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.HR_SCHEDULE_INTERVIEW_PAGE, (Route route) => route.settings.name == Routes.HR_SCHEDULE_INTERVIEW_PAGE, arguments: {'user' : user});
        break;
      case 'addCandidate':
        Navigator.of(context).pop();
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.HR_ADD_CANDIDATE_PAGE, (Route route) => route.settings.name == Routes.HR_SCHEDULE_INTERVIEW_PAGE, arguments: {'user' : user});
        break;
      case 'Sign Out':
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Are you sure you want to Sign Out?'),
                backgroundColor: Colors.white,
                contentPadding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                actions: <Widget>[
                  FlatButton(
                    child: Text('SIGN OUT', style: TextStyle(color: Theme.of(context).textTheme.display1.color),),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.AUTH_PAGE, (Route route) {
                        if (route == null) return true;
                        return false;
                      });
                    },
                  ),
                  FlatButton(
                    child: Text('GO BACK', style: TextStyle(color: Theme.of(context).textTheme.display1.color),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
        break;
      default:
        Navigator.of(context).pop();
    }
  }

Drawer getDrawer(context, user) {
  return Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(
                user['role'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.0,
                ),
              ),
              accountName: Text(
                user['name'],
                style: TextStyle(
                  fontFamily: 'Nunito Bold',
                  fontSize: 18.0,
                ),
              ),
              // currentAccountPicture: CircleAvatar(child: Image.asset('assets/logo/256x256.jpg'),),
              onDetailsPressed: null,
            ),
            ListTile(
              enabled: true,
              title: Text('Schedule Interview', style: Theme.of(context).textTheme.display2),
              onTap: () {
                drawerCallback(context, 'scheduleInterview', user);
              },
            ),
            ListTile(
              enabled: true,
              title: Text('New Candidate', style: Theme.of(context).textTheme.display2),
              onTap: () {
                drawerCallback(context, 'addCandidate', user);
              },
            ),
            ListTile(
              enabled: true,
              title: Text('Sign Out', style: Theme.of(context).textTheme.display2),
              onTap: () {
                drawerCallback(context, 'Sign Out', user);
              },
            )
          ],
        ),
      );
}