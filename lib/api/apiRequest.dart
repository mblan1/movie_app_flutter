import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

final dio = Dio();
late String keyword;

// get api key from service.json
Future getAPIKey() async {
  try {
    final String response = await rootBundle.loadString('service.json');
    final data = await json.decode(response);
    final String apiKey = data['api_key'];
    return apiKey;
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

Future getVideoListByKeyword(String keyword, {int maxResults = 5}) async {
  try {
    final apiKey = await getAPIKey();
    final response = await dio.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=$maxResults&q=$keyword&key=$apiKey",
    );
    if (response.statusCode == 200) {
      // Dio already parses the JSON, so no need to call jsonDecode
      final Map<String, dynamic> data = response.data;
      return data;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

Future getVideoDataById(String id) async {
  try {
    final apiKey = await getAPIKey();
    final response = await dio.get(
      "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=$id&key=$apiKey",
    );
    if (response.statusCode == 200) {
      // Dio already parses the JSON, so no need to call jsonDecode
      final Map<String, dynamic> data = response.data;
      return data;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
