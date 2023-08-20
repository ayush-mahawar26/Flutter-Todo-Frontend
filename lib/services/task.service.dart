import 'dart:convert';
import 'package:todo_frontend/const/global.var.dart';
import 'package:http/http.dart' as http;
import 'package:todo_frontend/cubit/authCubit/auth.cub.dart';

class TaskService {
  String baseUrl = GlobalVars.baseUrl;
  getAllTask() async {
    print(AuthCubit.user.uid);
    String link = "$baseUrl/gettask/${AuthCubit.user.uid}";
    print(link);
    Uri url = Uri.parse(link);
    print(link);

    http.Response taskRes = await http.get(url);
    Map<dynamic, dynamic> res = await jsonDecode(taskRes.body);
    print(res);

    return res;
  }

  addTask(String title, String descp) async {
    Uri uri = Uri.parse("$baseUrl/posttask");
    http.Response taskRes = await http.post(uri,
        body: jsonEncode({
          "id": AuthCubit.user.uid,
          "title": title,
          "description": descp,
          "isDone": false
        }),
        headers: GlobalVars.headers);
    Map res = await jsonDecode(taskRes.body);
    print(res);
    return res;
  }

  Future<Map> deletetask(String taskid) async {
    print(taskid);
    Uri uri = Uri.parse("$baseUrl/deletetask/$taskid");
    http.Response taskRes =
        await http.post(uri, body: jsonEncode({}), headers: GlobalVars.headers);
    print(taskRes.body);
    Map res = await json.decode(taskRes.body);
    print(res);
    return res;
  }

  Future<Map> updateTask(String taskId, String ntitle, String ndescp) async {
    Uri uri = Uri.parse("$baseUrl/update/$taskId");
    http.Response taskRes = await http.post(uri,
        body: jsonEncode({"title": ntitle, "description": ndescp}),
        headers: GlobalVars.headers);
    Map res = await json.decode(taskRes.body);
    print(res);
    return res;
  }
}
