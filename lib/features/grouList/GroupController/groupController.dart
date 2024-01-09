
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/groupModel.dart';
import '../grouprRepository/groupRepository.dart';
final GroupControllerProvider =NotifierProvider<GroupController,bool>(() {
  return GroupController();
} );
final getGroupProvider = StreamProvider((ref) {
  return ref.watch(GroupRepositoryProvider).getGroups();
});
class GroupController extends Notifier<bool>{
 GroupController();
 @override
  bool build() {
    return false;
  }
  Stream<BloodGroupsModel>getGroups(){
 var groupList = ref.watch(GroupRepositoryProvider);
 return groupList.getGroups();
  }
}