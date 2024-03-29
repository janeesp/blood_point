import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:blood_point/features/auth/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/global/global.dart';
import '../../../model/detailsModel.dart';
import '../../grouList/GroupController/groupController.dart';
import '../controller/addController.dart';
import 'home_page.dart';


class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
 ConsumerState createState() => _AddPageState();
}
List<String>bloodgroups=["b","c"];
class _AddPageState extends ConsumerState<AddPage> {

  RegExp phoe_validator =RegExp(r"[0-9]{10,}$");
  TextEditingController name =TextEditingController();
  TextEditingController number =TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController blood = TextEditingController();

  addDetails(){
    ref.watch(addControllerProvider).addDetails(DetailsModel(
        name: name.text.trim(),
        number: int.tryParse(number.text.trim())??0,
        place: place.text.trim(),
        bloodGroup: blood.text.trim(),
        date: DateTime.now(),
        id: ""));
  }
  List<String> BloodList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              SizedBox(
                height: scrHeight*0.02,
              ),
              TextFormField(
                controller: number,
               maxLength: 10,
               keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  labelText: "numbr",
                  prefixText: '+91:',counterStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if(!phoe_validator.hasMatch(value!)){
                    return "Enter Mobile Number";
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(
                height: scrHeight*0.02,
              ),
              TextFormField(
                controller: place,
                decoration: InputDecoration(
                    hintText: "place",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),  SizedBox(
                height: scrHeight*0.02,
              ),
              Container(
                height: scrHeight*0.14,
                width: scrWidth*1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black
                  )
                ),child:Consumer(
                builder: (context, ref, child) {
                  var items = ref.watch(getGroupProvider);
                  return items.when(data: (data) {
                    BloodList = data.groups!.map((e) => e.toString()).toList();
                    return  Container(
                      child: CustomDropdown(
                        items:BloodList,
                        hintText: "bloodgroup",
                        controller:blood ,
                      ),
                    );
                  },
                      error: (error, stackTrace) {
                        return Text(error.toString());
                      },
                      loading:  () => Center(child: CircularProgressIndicator()),);
                },

                ) ,
              ),
              SizedBox(
                height: scrHeight*0.1,
              ),
              InkWell(
                onTap: () {
                  if(name.text.isNotEmpty&&number.text.isNotEmpty&&place.text.isNotEmpty&&blood.text.isNotEmpty){
                    addDetails();
                    showUploadMessage(context, "successfully", Colors.white);
                    Navigator.pop(context);
                  }else{
                    name.text.isEmpty?
                    showErorMessage(context,"enter name"):
                       number.text.isEmpty?
                       showErorMessage(context,'enter mobile number'):
                       place.text.isEmpty?
                       showErorMessage(context,"enter place"):
                       showErorMessage(context,"enter blood group");
                  }

                },
                child: Container(
                  height: scrHeight*0.1,
                  width: scrWidth*0.2,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Add your Details"),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
