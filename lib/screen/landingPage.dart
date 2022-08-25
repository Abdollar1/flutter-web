import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:innorikwebapp/homeScreen.dart';
import 'package:innorikwebapp/model/userModel.dart';

class landingPage extends StatefulWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<userModel> createUser(String userName, String userPassword) async {
    final response = await http.post(
      Uri.parse('https://localhost:44311/api/user' ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userName,
        'userPassword': userPassword
      }),
    );

    if (response.statusCode < 206) {
      print(response.body);
      return userModel.fromJson(jsonDecode(response.body));
    } else {
      print("unable");
      throw Exception(response.body);
    }
  }


  //get a user
  Future<userModel> getUser(String userName, String userPassword) async {
    final response = await http.get(
      Uri.parse('https://localhost:44311/api/user')
      );
    if (response.statusCode < 206) {
      print(response.body);
      return userModel.fromJson(jsonDecode(response.body));
    } else {
      print("unable");
      throw Exception(response.body);
    }
  }

  late Future<userModel> futureAlbum;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   futureAlbum = getUser( userName.text.trim(), userPassword.text.trim());
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 20, top: 20, right: 20, bottom: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
                        child: Text(
                          "Innorik Test WebApp",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 20),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: userName,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            label: const Text("UserName"),
                            prefixIcon: const Icon(Icons.email_outlined),
                            prefixIconColor: Colors.red,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your username");
                            }
                          },
                          onSaved: (value) {
                            userName.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 20),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: false,
                          controller: userPassword,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            prefixIcon: const Icon(Icons.password_outlined),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Password is Required");
                            }

                          },
                          onSaved: (value) {
                            userPassword.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      //login button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  getUser(userName.text.trim(), userPassword.text.trim());
                                  // FutureBuilder<userModel>(
                                  //   future: futureAlbum,
                                  //   builder: (context, snapshot) {
                                  //     if (snapshot.hasData) {
                                  //       snapshot.data!.userName = userName.text.trim();
                                  //       snapshot.data!.userPassword = userPassword.text.trim();
                                  //     getUser(snapshot.data!.userName = userName.text.trim(),snapshot.data!.userName = userPassword.text.trim());
                                  //     }
                                  //     else {
                                  //
                                  //     }
                                  //     // else if (snapshot.hasError) {
                                  //     //   return Text('${snapshot.error}');
                                  //     // }
                                  //
                                  //     // By default, show a loading spinner.
                                  //     //return ("");
                                  //   },
                                  // );
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const homeScreen()));
                                }
                               },
                              child: const Text("LOGIN",
                                  style: TextStyle(fontSize: 20))),
                          const SizedBox(width: 10.0),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const homeScreen()));
                                // if (formKey.currentState!.validate()) {
//                                   createUser(userName.text.trim(), userPassword.text.trim());
// Fluttertoast.showToast(msg: "Account added successfully", timeInSecForIosWeb: 5, gravity: ToastGravity.TOP);
// Navigator.push(context, MaterialPageRoute(builder: (context) => const homeScreen()));
//                                 }
//                                 else {
//                                   print("Enable to submit user");
//                                 }
                              },
                              child: const Text("SIGN UP",
                                  style: TextStyle(fontSize: 20))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
