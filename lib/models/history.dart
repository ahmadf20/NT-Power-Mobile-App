// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

History historyFromJson(Map str) => History.fromJson((str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  String idHistory;
  String avgInput;
  String avgOutput;
  String kwhInput;
  String kwhOutput;
  String voltageInput;
  String voltageOutput;
  DateTime date;
  String codeDevice;
  String idDevice;
  String code;
  String deviceName;
  String address;
  String productName;
  String idUser;

  History({
    this.idHistory,
    this.avgInput,
    this.avgOutput,
    this.kwhInput,
    this.kwhOutput,
    this.voltageInput,
    this.voltageOutput,
    this.date,
    this.codeDevice,
    this.idDevice,
    this.code,
    this.deviceName,
    this.address,
    this.productName,
    this.idUser,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        idHistory: json["id_history"],
        avgInput: json["avg_input"],
        avgOutput: json["avg_output"],
        kwhInput: json["kwh_input"],
        kwhOutput: json["kwh_output"],
        voltageInput: json["voltage_input"],
        voltageOutput: json["voltage_output"],
        date: DateTime.parse(json["date"]),
        codeDevice: json["code_device"],
        idDevice: json["id_device"],
        code: json["code"],
        deviceName: json["device_name"],
        address: json["address"],
        productName: json["product_name"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_history": idHistory,
        "avg_input": avgInput,
        "avg_output": avgOutput,
        "kwh_input": kwhInput,
        "kwh_output": kwhOutput,
        "voltage_input": voltageInput,
        "voltage_output": voltageOutput,
        "date": date.toIso8601String(),
        "code_device": codeDevice,
        "id_device": idDevice,
        "code": code,
        "device_name": deviceName,
        "address": address,
        "product_name": productName,
        "id_user": idUser,
      };
}
