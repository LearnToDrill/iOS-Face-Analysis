import 'dart:convert';
import 'package:face_analysis/Resources/constants.dart';
import 'package:http/http.dart' as http;
import '../Resources/commonClass.dart';

class ScanResultsClient {
  static const String _baseUrl = Constants.baseUrl;

  final http.Client _client;

  ScanResultsClient(this._client);

  Future<http.Response> request(
      {required RequestType requestType,
      required String path,
      dynamic parameter}) async {
    switch (requestType) {
      case RequestType.GET:
        return _client.get(Uri.parse("$_baseUrl$path"));
      case RequestType.POST:
        var b = json.encode(parameter);
        print("Body$b");
        return _client.post(Uri.parse("$_baseUrl$path"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: json.encode(parameter));
      case RequestType.DELETE:
        return _client.delete(Uri.parse("$_baseUrl$path"));
      default:
        return throw Exception("The HTTP request method is not found");
    }
  }
}

enum RequestType {
  GET,
  POST,
  DELETE,
}

enum Path {
  getTags,
  getTagsAsync,
  getTagResults,
}
