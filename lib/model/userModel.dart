import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? password;
  String? name;
  String? id;
  bool ? delete;
  //DateTime ? createrddate;

  UserModel({
    this.email,
    this.name,
    this.password,
    this.id,
    this.delete,
   // this.createrddate,
  } );
 UserModel.fromjson(Map<String,dynamic>json){
   email = json['email'];
      password= json['password'];
       name= json['name'];
      id=json['id'];
   // createrddate = json['createrddate']as DateTime;
    delete = json['delete'];
}
   Map<String,dynamic> tojson(){
   Map<String,dynamic> data ={};
   data['email']= email;
   data['password']= password;
   data['name']=name;
   data['id'] = id;
  // data['createrddate']= createrddate;
   data['delete'] = delete ?? false;
   return data;
}

UserModel copyWith({
  String? email,
  String? password,
  String? name,
  String? id,
  bool ? delete,
  DateTime ? createrddate,
}){
   return UserModel(
     email:email ?? this.email,
     password: password ?? this.password,
     id:  id ?? this.id,
     name: name ?? this.name,
     delete: delete ?? this.delete,
    // createrddate: createrddate ?? this.createrddate,
   );
}

// //<editor-fold desc="Data Methods">
//   UserModel(
//     this.email,
//     this.password,
//      this.name,
//      this.id,
//   );
//
//   UserModel copyWith({
//     String? email,
//     String? password,
//     String? name,
//     String? id,
//   }) {
//     return UserModel(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       name: name ?? this.name,
//       id: id ?? this.id,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'email': this.email,
//       'password': this.password,
//       'name': this.name,
//       'id': this.id,
//     };
//   }
//
//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       email: map['email'] as String,
//       password: map['password'] as String,
//       name: map['name'] as String,
//       id: map['id'] as String,
//     );
//   }
//
// //</editor-fold>
 }