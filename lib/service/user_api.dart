import 'package:blocexample2/model/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class UserRepository {
  Future<List<Users>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("http://fakestoreapi.com/users",),);

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List tempList = [];
      for (var v in data) {
        tempList.add(v);
      }
      return Users.usersFromJson(tempList);
    } else {
      throw Exception('user not register');
    }
  }
}
