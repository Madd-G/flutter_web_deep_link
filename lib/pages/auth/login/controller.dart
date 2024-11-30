import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_getx_deep_link/common/utils/http.dart';
import 'package:flutter_web_getx_deep_link/pages/auth/login/index.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final SignInState state = SignInState();
  TextEditingController? emailEditingController = TextEditingController();
  TextEditingController? passwordEditingController = TextEditingController();
  TextEditingController? schoolIdEditingController = TextEditingController();

  handleLogin() async {
    String emailAddress = state.email.value;
    String password = state.password.value;
    String schoolId = state.schoolId.value;

    Map<String, dynamic> body = {
      "username": emailAddress,
      "password": password,
      "schoolId": schoolId,
    };

    print('body: $body \n');

    // URL endpoint
    // String url = 'https://us-central1-sikela-app.cloudfunctions.net/auth/login';

    // Buat instance Dio
    // Dio dio = Dio();

    // var bearerToken =
    //     "eyJhbGciOiJSUzI1NiIsImtpZCI6ImVkODA2ZjE4NDJiNTg4MDU0YjE4YjY2OWRkMWEwOWE0ZjM2N2FmYzQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAwNDgwNTE2NTI2NTAwNTg5ODk3IiwiZW1haWwiOiJtYWRkZ2VyYWxkQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiWVl5emhvcTFJOW5tVmhtRGNHOGhidyIsIm5iZiI6MTcwNzkyMDI3NCwiaWF0IjoxNzA3OTIwNTc0LCJleHAiOjE3MDc5MjQxNzQsImp0aSI6IjdlM2U0ZmZkZDhmYzBhMGMzMGIzMjYzNjIyYTMxMjExNWY1M2YxZDEifQ.Jd2v2NJv9qgBtE1gvFPJrdVkdMnctcuTZsLFtVveWLRyn_10KBOGSVn8tB4Cc8TyNELUAqfq4dPHgjOfhNwOdL7b4aMnN32QA9zLq00vtRFn0azOz3P0aB4MhDKfiTzc2yUsYfwff32cGDsscGmkw-cs5KqxsF1DHT6npK167UGNxDZNHpBRSfgYQxmU3cA8GlF5qo9j53PfKdXoKsB1MnYPqNNPgIQfZ284WG-CrAhs1TfbV4mJTp2MNU3XEKkqSItd4zMjQSQRdIoCbx6YvmPK2JZevGGEf3AXaDwyPIXSif-TJr_h2mKBNwqkWuxb4sqCQ7-rz0ItHVI5fXIikA";
    // Set header untuk autorisasi bearer
    // dio.options.headers['Authorization'] = 'Bearer $bearerToken';
    // dio.options.headers['Access-Control-Allow-Origin'] = '*';

    try {
      // Kirim permintaan POST
      print('try');
      // var response = await dio.post(
      //   url,
      //   data: body,
      //   options: Options(headers: {
      //     'Authorization': 'Bearer $bearerToken',
      //     'Accept': 'application/json',
      //     'Access-Control-Allow-Origin' : '*',
      //   }),
      // );
      var response = await HttpUtil().post(
        'auth/login',
        data: body,
      );
      print('try finished');

      // Cek kode status HTTP
      // if (response == 200) {
      // Permintaan berhasil
      print('Login successful');
      print('Response: ${response}');
      // } else {
      //   // Permintaan gagal
      //   print('Login failed');
      //   print('Status code: ${response.statusCode}');
      //   print('Response: ${response.data}');
      // }
    } catch (error) {
      // Tangani kesalahan
      print('Error: $error');
    }
  }
}
