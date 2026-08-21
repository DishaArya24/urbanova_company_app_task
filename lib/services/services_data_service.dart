import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/service_model.dart';

class ServiceData {
  static Future<List<ServiceModel>> loadServices() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/services.json',
    );

    final Map<String, dynamic> jsonData =
        json.decode(jsonString);

    final List<dynamic> serviceList =
        jsonData['services'] as List<dynamic>;

    return serviceList
        .map(
          (service) => ServiceModel.fromJson(
            service as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}