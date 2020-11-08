import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:library_frontend/models/chart.dart';
import 'package:library_frontend/services/utils.dart';

class ChartApi extends Utils {
  int userId;

  Future<List<Chart>> getAllKindUserRead(Future<int> id) async {
    userId = await id;
    var response = await http.get('$urlServer/grafici/getGeneriUtente/$userId',
        headers: header);

    return List.of(jsonDecode(response.body)['data'][0])
        .map((e) => Chart.kindChart(e))
        .toList();
  }

  Future<List<Chart>> getAllMonthUserRead() async {
    userId = await getUserId();
    var response = await http
        .get('$urlServer/grafici/getNumberLibriMese/$userId', headers: header);

    return List.of(jsonDecode(response.body)['data'][0])
        .map((e) => Chart.monthChart(e['NumeroLibri'], getMonth(e['Mese'])))
        .toList();
  }

  int getMonth(String month) {
    switch (month) {
      case 'January':
        return DateTime.january;

      case 'February':
        return DateTime.february;

      case 'March':
        return DateTime.march;

      case 'April':
        return DateTime.april;

      case 'May':
        return DateTime.may;

      case 'June':
        return DateTime.june;

      case 'July':
        return DateTime.july;

      case 'August':
        return DateTime.august;

      case 'September':
        return DateTime.september;

      case 'October':
        return DateTime.october;

      case 'November':
        return DateTime.november;

      default:
        return DateTime.december;
    }
  }
}
