import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_demo/demo_insertdata.dart';
import 'package:sqflite/sql.dart';


class ApiCall1 extends StatefulWidget {
  const ApiCall1({Key? key}) : super(key: key);

  @override
  State<ApiCall1> createState() => _ApiCall1State();
}

class _ApiCall1State extends State<ApiCall1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Call Demo"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return InsertData(
                      map: null,
                    );
                  },
                ),
              ).then(
                    (value) {
                  setState(
                        () {},
                  );
                },
              );
            },
            child: Icon(Icons.add,size: 30),
          ),
        ],
      ),
      body: FutureBuilder<http.Response>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic jsonData = jsonDecode(snapshot.data!.body.toString(),);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: jsonData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return InsertData(map: jsonData[index])
                          ;
                        },
                      ),
                    ).then(
                          (value) {
                        setState(() {});
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10,right: 10,left: 10),

                    child: Column(
                      children: [  Container(child: Image(image: NetworkImage(jsonData[index]['avatar'],),),height: 150),
                        ListTile(
                          tileColor: Colors.grey,

                          title: Text(jsonData[index]['name'].toString(),),
                          subtitle:
                          Text(jsonData[index]['color'].toString(),),
                          trailing: InkWell(
                            onTap: () {

                              showAlertDialog(context, jsonData[index]['id'],);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                );
              },
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: getChairData(),
      ),
    );
  }

  Future<http.Response> getChairData() async {
    http.Response res = await http
        .get(Uri.parse('https://63f8f0f4deed51d7badb4f92.mockapi.io/furniture'),);
    print(res.body.toString(),);

    return res;
  }

  Future<void> deleteChair(id) async {
    http.Response res = await http.delete(
        Uri.parse('https://63f8f0f4deed51d7badb4f92.mockapi.io/furniture/$id'),);
  }

  showAlertDialog(BuildContext context, jsonData) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        deleteChair(jsonData).then(
              (value) {
            Navigator.of(context).pop();
            setState(
                  () {},
            );
          },
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are You Sure Want To Delete ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}