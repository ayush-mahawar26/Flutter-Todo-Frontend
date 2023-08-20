import 'dart:convert';

import 'package:todo_frontend/const/global.var.dart';
import 'package:todo_frontend/models/user.model.dart';
import 'package:http/http.dart' as http;
import 'package:todo_frontend/services/jwtservice.dart';

class AuthService {
  String baseUrl = GlobalVars.baseUrl;

  Future<Map<dynamic, dynamic>> signUpService(
      String username, String email, String pass) async {
    http.Response res = await http.post(Uri.parse(baseUrl + "/signup"),
        body: jsonEncode(
            {"username": username, "email": email, "password": pass}),
        headers: GlobalVars.headers);
    Map<dynamic, dynamic> response = jsonDecode(res.body);
    return response;
  }

  Future<Map<dynamic, dynamic>> signInService(String email, String pass) async {
    http.Response res = await http.post(Uri.parse(baseUrl + "/signin"),
        body: jsonEncode({"email": email, "password": pass}),
        headers: GlobalVars.headers);
    Map<dynamic, dynamic> response = jsonDecode(res.body);
    return response;
  }

  Future<Map<dynamic, dynamic>> getUser() async {
    String? key = await JwtServices().getJwt("token");
    if (key == null) {
      return {"auth": false, "mssg": "No Jwt Found"};
    }

    print("key $key");

    Uri uri = Uri.parse('$baseUrl/verifyuser');
    http.Response userRes = await http.post(uri,
        body: jsonEncode({"key": key}), headers: GlobalVars.headers);
    Map<dynamic, dynamic> res = await jsonDecode(userRes.body);
    print(res);
    res["token"] = key;
    return res;
  }

  Future<Map> getUserById(String uid) async {
    Uri uri = Uri.parse("$baseUrl/getuserbyid");
    http.Response userres = await http.post(uri,
        body: jsonEncode({"uid": uid}), headers: GlobalVars.headers);
    Map<dynamic, dynamic> res = await jsonDecode(userres.body);
    return res;
  }
}
