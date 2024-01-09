import 'package:blood_point/core/const/constants.dart';
import 'package:blood_point/core/providers/providers.dart';
import 'package:blood_point/features/home/screen/add%20People.dart';
import 'package:blood_point/model/detailsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final addReppositoryProvider =Provider((ref) => addReppository(firestore: ref.read(firebaseProvider)));
class addReppository{
final FirebaseFirestore _firestore;
addReppository({
  required FirebaseFirestore firestore,
}):
_firestore =firestore;
addDetails(DetailsModel detailsModel){
 _firestore.collection(FirebaseConst.firbaseCollection).add(detailsModel.toMap())
     .then((value) => value.update({"id":value.id}));
}
Stream<List<DetailsModel>>getDetails({required String? group}){
  print(group);
  print(bloodgroups);
  return
  _firestore.collection(FirebaseConst.firbaseCollection)
         .where('bloodGroup',isEqualTo: group)
      .snapshots()
      .map((event) => event.docs.map((e) => DetailsModel.fromMap(e.data())).toList());
}
}