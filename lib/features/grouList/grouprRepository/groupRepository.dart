import 'package:blood_point/core/const/constants.dart';
import 'package:blood_point/core/providers/providers.dart';
import 'package:blood_point/model/groupModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final GroupRepositoryProvider = Provider((ref) => BloodListRepository(firestore: ref.read(firebaseProvider)));
class BloodListRepository{
FirebaseFirestore _firestore;
BloodListRepository({
  required FirebaseFirestore firestore
}):
    _firestore=firestore;

Stream<BloodGroupsModel>getGroups(){
  return _groups.doc('bloodGroups').snapshots().map((event) =>
      BloodGroupsModel.fromJson(event.data()as Map<String,dynamic>));
}
CollectionReference get _groups =>
    _firestore.collection(FirebaseConst.bloodGroupCollection);
}