import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertData extends StatefulWidget {
  InsertData({Key? key , this.map}) : super(key: key);

  Map? map;

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {

  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool isloading = false;

  @override
  void initState() {

    nameController.text = widget.map == null?'':widget.map!["name"];
    modelController.text = widget.map == null?'':widget.map!["color"];
    imageController.text = widget.map == null?'':widget.map!["avatar"];


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Chair"),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [

              SizedBox(height: 20,width: 20),
              TextFormField(decoration: InputDecoration(labelText: "Enter Name"),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Name";
                    }
                  }
              ),

              SizedBox(
                height: 20,
              ),
              TextFormField(decoration: InputDecoration(labelText: "Enter Colour"),
                controller: modelController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter color";
                  }
                },
              ),
              SizedBox(
                  height: 20,width: 20
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(decoration: InputDecoration(labelText: "Enter Img URL"),
                  controller: imageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Image";
                    }
                  },
                ),
              ),

              InkWell(
                onTap: () {
                  setState(() {
                    isloading = true;
                  });
                  if(formKey.currentState!.validate()){
                    if(widget.map == null){
                      inserUser().then((value) {
                        Navigator.of(context).pop(true);
                      },);
                    }
                    else{
                      updateUser(widget.map!['id']).then((value) {
                        Navigator.of(context).pop(true);
                      },);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 180,
                    height: 50,
                    padding: EdgeInsets.only(top: 10 , right: 50 , bottom: 10 , left: 50),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: isloading?CircularProgressIndicator():
                      Text('Submit', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> inserUser() async {

    Map map= {};
    map["name"] = nameController.text.toString();
    map['color'] = modelController.text.toString();
    map['avatar'] = imageController.text.toString();

    http.Response res = await http.post(Uri.parse('https://63f8f0f4deed51d7badb4f92.mockapi.io/furniture'),body: map);
    print(res.body);
  }

  Future<void> updateUser(id) async {

    Map map= {};
    map["name"] = nameController.text.toString();
    map['color'] = modelController.text.toString();
    map['avatar'] = imageController.text.toString();

    http.Response res = await http.put(Uri.parse('https://63f8f0f4deed51d7badb4f92.mockapi.io/furniture/$id'),body: map);
    print(res.body);
  }

}