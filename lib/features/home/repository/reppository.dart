
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/const/constants.dart';
import '../../../core/providers/providers.dart';
import '../../../model/detailsModel.dart';
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
  return
  _firestore.collection(FirebaseConst.firbaseCollection)
         .where('bloodGroup',isEqualTo: group)
      .snapshots()
      .map((event) => event.docs.map((e) => DetailsModel.fromMap(e.data())).toList());
}
Stream<DocumentSnapshot>getcustomer(){
  return _firestore.collection('customer').doc('contact').snapshots();

}
}