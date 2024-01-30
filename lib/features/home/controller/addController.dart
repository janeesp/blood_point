

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../model/detailsModel.dart';
import '../repository/reppository.dart';
final addControllerProvider =Provider((ref) => addController(reppository: ref.read(addReppositoryProvider)));
final getDetailsControllerProvider =StreamProvider.family.autoDispose((ref,String? group){
 final _home=
 addReppository(firestore: ref.read(firebaseProvider));
 return _home.getDetails(group: group);
});
final getcontacts = StreamProvider.autoDispose((ref) => ref.watch(addControllerProvider).getcustomer());
class addController{
  final addReppository _reppository;
  addController({
   required addReppository reppository
}):
_reppository=reppository;
  addDetails(DetailsModel detailsModel){
    _reppository.addDetails(detailsModel);
  }
  Stream<List<DetailsModel>>getDetails(String group){
    return _reppository.getDetails(group: 'group');
  }
  Stream getcustomer(){
    return _reppository.getcustomer();
  }
}