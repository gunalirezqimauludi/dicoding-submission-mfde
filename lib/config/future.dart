import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/config/api.dart';

import 'package:flutter_app/model/meals_model.dart';
import 'package:flutter_app/model/meals_detail_model.dart';

Future<Meals> getAllMeals(filter) async {
  final response = await http.get('${API_URL}filter.php?c=$filter');

  if (response.statusCode == 200) {
    return compute(mealsFromJson, response.body);
  } else {
    throw Exception('failed to load response data');
  }
}

Future<MealsDetail> getDetail(id) async {
  final response = await http.get('${API_URL}lookup.php?i=$id');

  if (response.statusCode == 200) {
    return compute(mealsDetailFromJson, response.body);
  } else {
    throw Exception('failed to load response data');
  }
}
