// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Helpers {
  BuildContext context;
  DateTime? currentBackPressTime;

  Helpers.of(this.context);

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime != null &&
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Pulse otra vez para salir");
      return Future.value(false);
    }
    return Future.value(true);
  }

  // Future<void> sessionExpired() async {
  //   RepositoryProvider.of<PreferencesRepository>(context).remove("token");
  //   RepositoryProvider.of<PreferencesRepository>(context).remove("logged");
  //   Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  // }

  String dateFormat(String date) {
    try {
      List<String> listDate = date.split("-");
      return "${listDate[2]}/${listDate[1]}/${listDate[0]}";
    } catch (e) {
      return "formato de fecha incorrecto";
    }
  }

  String numberFormat(double mount) {
    var f = NumberFormat("###,###,##0.00", "en_US");
    return f.format(mount);
  }
}
