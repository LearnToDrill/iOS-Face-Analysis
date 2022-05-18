// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:convert';

class NetworkManager {
  final String? Message;

  NetworkManager({this.Message});

  factory NetworkManager.fromRawJson(String str) =>
      NetworkManager.fromJson(json.decode(str));

  factory NetworkManager.fromJson(Map<String, dynamic> json) =>
      NetworkManager(Message: json["Message"]);

  Map<String, dynamic> toJson() => {"Message": Message};
}
