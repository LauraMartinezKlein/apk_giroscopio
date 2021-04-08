import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.nameDevice,
    this.eventDate,
    this.event,
  });

  String nameDevice;
  DateTime eventDate;
  String event;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nameDevice: json["nameDevice"],
        eventDate: DateTime.parse(json["eventDate"]),
        event: json["event"],
      );

  Map<String, dynamic> toJson() => {
        "nameDevice": nameDevice,
        "eventDate": eventDate.toIso8601String(),
        "event": event,
      };
}
