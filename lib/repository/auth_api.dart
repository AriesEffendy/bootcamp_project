import 'dart:io';

import 'package:bootcamp_project/constants/api_url.dart';
import 'package:bootcamp_project/helpers/user_email.dart';
import 'package:bootcamp_project/models/network_response.dart';
import 'package:dio/dio.dart';

class AuthApi {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: {
        "x-api-key": ApiUrl.apiKey,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      responseType: ResponseType.json,
    );

    final dio = Dio(options);
    return dio;
  }

  Future<NetworkResponse> _getRequest({endpoint, param}) async {
    try {
      final dio = dioApi();
      final result = await dio.get(endpoint, queryParameters: param);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.Error(data: null, message: "request timeout");
      }
      return NetworkResponse.Error(data: null, message: "request Error Dio");
    } catch (e) {
      return NetworkResponse.Error(data: null, message: "other Error");
    }
  }

  Future<NetworkResponse> _postRequest({endpoint, body}) async {
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint, queryParameters: body);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.Error(data: null, message: "request timeout");
      }
      return NetworkResponse.Error(data: null, message: "request Error Dio");
    } catch (e) {
      return NetworkResponse.Error(data: null, message: "other Error");
    }
  }

  Future<NetworkResponse> getUserEmail() async {
    final result = await _getRequest(
      endpoint: ApiUrl.users,
      param: {
        "email": UserEmail.getUserEmail(),
      },
    );
    return result;
  }

  Future<NetworkResponse> postRegister(body) async {
    final result = await _postRequest(
      endpoint: ApiUrl.userRegistrasi,
      body: body,
    );
    return result;
  }
}
