// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

Device deviceFromJson(Map str) => Device.fromJson(str);

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  String idDevice;
  String code;
  String deviceName;
  String address;
  String productName;
  String idUser;

  Device({
    this.idDevice,
    this.code,
    this.deviceName,
    this.address,
    this.productName,
    this.idUser,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        idDevice: json["id_device"],
        code: json["code"],
        deviceName: json["device_name"],
        address: json["address"],
        productName: json["product_name"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_device": idDevice,
        "code": code,
        "device_name": deviceName,
        "address": address,
        "product_name": productName,
        "id_user": idUser,
      };
}
