// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
//
// retrieveInventorySales(context)async{
//   List data = [];
//   http.Response response = await http.post(
//     Uri.parse('https://localhost:44311/api/user')
//   );
//
//   if(response.statusCode < 206){
//     print(response.body);
//     data = json.decode(response.body);
//   }
//   else{
//     throw Exception(response.body);
//   }
//   return data;
// }