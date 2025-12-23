import 'package:http/http.dart' as http;

class CallRequest {

  static callData(String method, String query, data) async {
    final url = Uri.parse('http://172.16.250.187:8000/todolist/${query}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todolist.toJson()), // body is data (-d)
      );
      final jsonData = json.decode(utf8.decode(response.bodyBytes));

  }

}