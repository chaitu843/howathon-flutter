import 'package:flutter/material.dart';

AppBar getAppBar() {
  return AppBar(
        title: InkWell(
            child: Text(
              'Troublemakers',
              style: TextStyle(
                  fontFamily: 'Nunito Bold', fontStyle: FontStyle.italic),
            ),
            // onTap: () {
            //   Navigator.of(context).pushNamedAndRemoveUntil(Routes.HOME_PAGE,
            //       (Route route) => route.settings.name == Routes.HOME_PAGE);
            // }
            ),
      );
}