import 'dart:convert';

BloodGroupsModel itemModelFromJson(String str) => BloodGroupsModel.fromJson(json.decode(str));

String itemModelToJson(BloodGroupsModel data) => json.encode(data.toJson());

class BloodGroupsModel {

  List? groups;



  BloodGroupsModel({

    required this.groups,


  });

  BloodGroupsModel copyWith({
    List? groups,

  }) =>
      BloodGroupsModel(

        groups: groups ?? this.groups,
      );

  factory BloodGroupsModel.fromJson(Map<String, dynamic> json) => BloodGroupsModel(

    groups: json["groups"],


  );

  Map<String, dynamic> toJson() => {

    "groups":groups,

  };
}