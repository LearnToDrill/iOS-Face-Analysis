import 'dart:convert';

class ScanResults {
  final String? Message;
  final String? ImageId;
  final String? TimeStamp;
  final List<Tag?>? Tags;

  ScanResults({this.Message, this.ImageId, this.TimeStamp, this.Tags});

  factory ScanResults.fromRawJson(String str) =>
      ScanResults.fromJson(json.decode(str));

  factory ScanResults.fromJson(Map<String, dynamic> json) => ScanResults(
      Message: json["Message"],
      ImageId: json["ImageId"],
      TimeStamp: json["TimeStamp"],
      Tags: List<Tag>.from(json["Tags"].map((x) => Tag.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "Message": Message,
        "ImageId": ImageId,
        "TimeStamp": TimeStamp,
        "Tags": List<dynamic>.from((Tags ?? []).map((x) => x?.toJson()))
      };
}

class Tag {
  final String? TagName;
  final String? TagImage;
  final bool? Status;
  final String? Message;
  final int? StatusCode;
  final List<TagValue?>? TagValues;

  Tag({
    this.StatusCode,
    this.TagName,
    this.TagImage,
    this.Status,
    this.Message,
    this.TagValues,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
      TagName: json["TagName"],
      TagImage: json["TagImage"],
      Status: json["Status"],
      Message: json["Message"],
      StatusCode: json["StatusCode"],
      TagValues: List<TagValue>.from(
          json["TagValues"].map((x) => TagValue.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "TagName": TagName,
        "TagImage": TagImage,
        "Status": Status,
        "Message": Message,
        "StatusCode": StatusCode,
        "TagValues":
            List<dynamic>.from((TagValues ?? []).map((x) => x?.toJson()))
      };
}

class TagValue {
  final String? Value;
  final String? ValueName;
  final String? Units;
  final String? Confidence;

  TagValue({this.Value, this.ValueName, this.Units, this.Confidence});

  factory TagValue.fromJson(Map<String, dynamic> json) => TagValue(
      Value: json["Value"],
      ValueName: json["ValueName"],
      Units: json["Units"],
      Confidence: json["Confidence"]);

  Map<String, dynamic> toJson() => {
        "Value": Value,
        "ValueName": ValueName,
        "Units": Units,
        "Confidence": Confidence
      };
}
