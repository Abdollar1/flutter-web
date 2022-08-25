import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innorikwebapp/homeScreen.dart';
import 'package:innorikwebapp/model/bookModel.dart';
import 'package:innorikwebapp/model/userModel.dart';
import 'package:innorikwebapp/screen/landingPage.dart';
import 'package:http/http.dart' as http;

class addBook extends StatefulWidget {
  const addBook({Key? key}) : super(key: key);

  @override
  _addBookState createState() => _addBookState();
}

class _addBookState extends State<addBook> {
  bool isPressed = true;


  TextEditingController bookName = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController descript = TextEditingController();



  Future<userModel> createBook(String bookName, String price, String description, String category) async {
    final response = await http.post(
      Uri.parse('https://localhost:44311/api/books'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'bookName': bookName,
        'category': category,
        'price': price,
        'descript': description
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
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              child: Column(children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 20),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: bookName,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                              label: const Text("Book Name"),
                              prefixIcon: const Icon(Icons.email_outlined),
                              prefixIconColor: Colors.red,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Book Name");
                              }
                            },
                            onSaved: (value) {
                              bookName.text = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 20),
                          child: TextFormField(
                            autofocus: false,
                            obscureText: false,
                            controller: category,
                            decoration: InputDecoration(
                              label: const Text("Book Category"),
                              prefixIcon: const Icon(Icons.grade),
                              prefixIconColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (category.text.isEmpty) {
                                return ("Enter book Category");
                              }

                            },
                            onSaved: (value) {
                              category.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 20),
                          child: TextFormField(
                            autofocus: false,
                            obscureText: false,
                            controller: price,
                            decoration: InputDecoration(
                              label: const Text("Book Price"),
                              prefixIcon: const Icon(Icons.money),
                              prefixIconColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (price.text.isEmpty) {
                                return ("Enter book Price");
                              }

                            },
                            onSaved: (value) {
                              price.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 20),
                          child: TextFormField(
                            autofocus: false,
                            obscureText: false,
                            controller: descript,
                            decoration: InputDecoration(
                              label: const Text("Book Description"),
                              prefixIcon: const Icon(Icons.description),
                              prefixIconColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (descript.text.isEmpty) {
                                return ("Enter book Category");
                              }

                            },
                            onSaved: (value) {
                              descript.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        //login button
                        const SizedBox(width: 10.0),
                        ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                createBook(bookName.text.trim(), category.text.trim(), price.text.trim(), descript.text.trim());
                                Fluttertoast.showToast(msg: "Book added successfully", timeInSecForIosWeb: 5, gravity: ToastGravity.TOP);
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homeScreen()));
                              }
                              else {
                                print("Enable to submit user");
                              }
                            },
                            child: const Text("Add Book",
                                style: TextStyle(fontSize: 20))),
                      ],
                    ),),
                  ),
                )],),
            ),
          ),
        ));
  }
}
