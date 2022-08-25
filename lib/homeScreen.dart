import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innorikwebapp/model/bookModel.dart';
import 'package:innorikwebapp/screen/addBook.dart';
import 'package:innorikwebapp/screen/landingPage.dart';


import 'model/userModel.dart';
import 'package:http/http.dart' as http;

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool isPressed = true;

  TextEditingController bookName = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController descript = TextEditingController();

  // Future<userModel> createBook(String bookName, String price,
  //     String description, String category) async {
  //   final response = await http.post(
  //     Uri.parse('https://localhost:44311/api/books'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'bookName': bookName,
  //       'category': category,
  //       'price': price,
  //       'descript': description
  //     }),
  //   );
  //
  //   if (response.statusCode < 206) {
  //     print(response.body);
  //     return userModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     print("unable");
  //     throw Exception(response.body);
  //   }
  // }

  //fecting all books
  Future<List<bookModel>> fetchBooks() async {
    final response =
        await http.get(Uri.parse('https://localhost:44311/api/books'));

    if (response.statusCode == 200) {
      //print(response.body);
      // return bookModel.fromMap(jsonDecode(response.body)[0]) as List;
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((data) => bookModel.fromJson(data)).toList();

    } else {
      throw Exception('Failed to load album');
    }
  }

  final formKey = GlobalKey<FormState>();

  // late Future<bookModel> futureAlbum;
  // @override
  // void initState() {
  //   super.initState();
  //   fetchBooks();
  // }

  late Future <List<bookModel>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchBooks();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const landingPage()));
                    },
                    child: const Text("LOGOUT")),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.red,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const addBook()));
                    },
                    child: const Text("Add Book")),
              ),

              // list of available books
              Text("ALL BOOKS"),
              // FutureBuilder(
              //   future: fetchBooks(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Column(
              //         children: [
              //           Text(snapshot.hasData["ret"].toString())
              //         ],
              //       );
              //     } else if (snapshot.hasError) {
              //       return Text('${snapshot.error}');
              //     }
              //
              //     // By default, show a loading spinner.
              //     return const CircularProgressIndicator();
              //   },
              // )
              FutureBuilder<List<bookModel>>(
                future: fetchBooks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<bookModel>? data = snapshot.data;
                    return ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 75,
                            color: Colors.white,
                            child: Center(
                              child: Text(data[index].bookName),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
