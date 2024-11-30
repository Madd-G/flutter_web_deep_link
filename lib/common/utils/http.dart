import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_getx_deep_link/common/utils/server.dart';
import 'package:get/get.dart' hide FormData;

import 'loading.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: SERVER_API_URL,

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      connectTimeout: const Duration(seconds: 30000),

      receiveTimeout: const Duration(seconds: 20000),

      headers: {},

      contentType: 'application/json; charset=utf-8',

      responseType: ResponseType.json,
    );

    dio = Dio(options);

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    // or
    // dio.httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () {
    //     // Don't trust any certificate just because their root cert is trusted.
    //     final HttpClient client =
    //     HttpClient(context: SecurityContext(withTrustedRoots: false));
    //     // You can test the intermediate / root cert here. We just ignore it.
    //     client.badCertificateCallback =
    //     ((X509Certificate cert, String host, int port) => true);
    //     return client;
    //   },
    // );

    // CookieJar cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          // Do something with response error
          Loading.dismiss();
          ErrorEntity eInfo = createErrorEntity(e);
          onError(eInfo);
          return handler.next(e); //continue
        },
      ),
    );
  }

  void onError(ErrorEntity eInfo) {
    debugPrint(
        'error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
    switch (eInfo.code) {
      case 401:
        // UserStore.to.onLogout();
        EasyLoading.showError(eInfo.message);
        break;
      default:
        // EasyLoading.showError('');
        break;
    }
  }

  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "request to cancel");
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -1, message: "Connection timed out");
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -1, message: "Request timed out");
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -1, message: "response timeout");
      case DioExceptionType.badResponse:
        {
          try {
            int errCode =
                error.response != null ? error.response!.statusCode! : -1;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                return ErrorEntity(
                    code: errCode, message: "request syntax error");
              case 401:
                return ErrorEntity(code: errCode, message: "permission denied");
              case 403:
                return ErrorEntity(
                    code: errCode, message: "The server refuses to execute");
              case 404:
                return ErrorEntity(
                    code: errCode, message: "can not connect to the server");
              case 405:
                return ErrorEntity(
                    code: errCode, message: "request method is forbidden");
              case 500:
                return ErrorEntity(
                    code: errCode, message: "internal server error");
              case 502:
                return ErrorEntity(code: errCode, message: "invalid request");
              case 503:
                return ErrorEntity(code: errCode, message: "server down");
              case 505:
                return ErrorEntity(
                    code: errCode,
                    message: "Does not support HTTP protocol requests");
              default:
                {
                  return ErrorEntity(
                    code: errCode,
                    message: error.response != null
                        ? error.response!.statusMessage!
                        : "",
                  );
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "unknown mistake");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message!);
        }
    }
  }

  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  var bearerToken =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImVkODA2ZjE4NDJiNTg4MDU0YjE4YjY2OWRkMWEwOWE0ZjM2N2FmYzQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAwNDgwNTE2NTI2NTAwNTg5ODk3IiwiZW1haWwiOiJtYWRkZ2VyYWxkQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiWVl5emhvcTFJOW5tVmhtRGNHOGhidyIsIm5iZiI6MTcwNzkyMDI3NCwiaWF0IjoxNzA3OTIwNTc0LCJleHAiOjE3MDc5MjQxNzQsImp0aSI6IjdlM2U0ZmZkZDhmYzBhMGMzMGIzMjYzNjIyYTMxMjExNWY1M2YxZDEifQ.Jd2v2NJv9qgBtE1gvFPJrdVkdMnctcuTZsLFtVveWLRyn_10KBOGSVn8tB4Cc8TyNELUAqfq4dPHgjOfhNwOdL7b4aMnN32QA9zLq00vtRFn0azOz3P0aB4MhDKfiTzc2yUsYfwff32cGDsscGmkw-cs5KqxsF1DHT6npK167UGNxDZNHpBRSfgYQxmU3cA8GlF5qo9j53PfKdXoKsB1MnYPqNNPgIQfZ284WG-CrAhs1TfbV4mJTp2MNU3XEKkqSItd4zMjQSQRdIoCbx6YvmPK2JZevGGEf3AXaDwyPIXSif-TJr_h2mKBNwqkWuxb4sqCQ7-rz0ItHVI5fXIikA";

  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    print('bearer token: $bearerToken');
    // if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
    headers['Authorization'] = 'Bearer $bearerToken';
    // }
    return headers;
  }

  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = true,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    if (requestOptions.extra == null) {
      requestOptions.extra = Map();
    }
    requestOptions.extra!.addAll({
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );

    return response.data;
  }

  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future postForm(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
