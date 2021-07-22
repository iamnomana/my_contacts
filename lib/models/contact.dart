import 'package:flutter/cupertino.dart';

class Contact {
  int id;
  String name;
  String phone;
  var createdAt;

  Contact({this.id, @required this.name, @required this.phone, this.createdAt});

  Contact.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phoneNumber'];
    createdAt = map['createdAt'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phoneNumber'] = this.phone;
    data['createdAt'] = this.createdAt;
    // if (this.createdAt != null) {}
    return data;
  }
}
