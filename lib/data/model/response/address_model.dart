import 'package:houseofdelevryy/data/model/response/zone_response_model.dart';

class AddressModel {
  int id;
  String addressType;
  String contactPersonNumber;
  String address;
  String latitude;
  String longitude;
  int zoneId;
  List<int> zoneIds;
  String method;
  String contactPersonName;
  String road;
  String house;
  String floor;
  List<ZoneData> zoneData;

  AddressModel(
      {required this.id,
        required this.addressType,
        required this.contactPersonNumber,
        required this.address,
        required this.latitude,
        required this.longitude,
        required this.zoneId,
        required this.zoneIds,
        required this.method,
        required this.contactPersonName,
        required this.road,
        required this.house,
        required this.floor,
        required this.zoneData,
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressType = json['address_type'];
    contactPersonNumber = json['contact_person_number'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    zoneId = json['zone_id'];
    zoneIds = json['zone_ids'] != null ? json['zone_ids'].cast<int>() : null;
    method = json['_method'];
    contactPersonName = json['contact_person_name'];
    floor = json['floor'];
    road = json['road'];
    house = json['house'];
    if (json['zone_data'] != null) {
      zoneData = [];
      json['zone_data'].forEach((v) {
        zoneData.add(new ZoneData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_type'] = this.addressType;
    data['contact_person_number'] = this.contactPersonNumber;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['zone_id'] = this.zoneId;
    data['zone_ids'] = this.zoneIds;
    data['_method'] = this.method;
    data['contact_person_name'] = this.contactPersonName;
    data['road'] = this.road;
    data['house'] = this.house;
    data['floor'] = this.floor;
    if (this.zoneData != null) {
      data['zone_data'] = this.zoneData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}