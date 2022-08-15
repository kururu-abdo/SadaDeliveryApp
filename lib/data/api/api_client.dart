
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:joseeder_delivery_boy/data/model/response/error_response.dart';
import 'package:joseeder_delivery_boy/utill/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;

  String token;
  Map<String, String> mainHeaders;

  ApiClient({@required this.appBaseUrl, @required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.token);
    mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic> query, String contentType,
    Map<String, String> headers, Function(dynamic) decoder,
  }) async {
    try {
      if(foundation.kDebugMode) {
      }
      Response response = await get(
        uri,
        contentType: contentType,
        query: query,
        headers: headers ?? mainHeaders,
        decoder: decoder,
      );
      response = handleResponse(response);
      if(foundation.kDebugMode) {
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, dynamic> query, String contentType,
    Map<String, String> headers, Function(dynamic) decoder, Function(double) uploadProgress,
  }) async {
    try {
      if(foundation.kDebugMode) {
      }
      Response response = await post(
        uri, body,
        query: query,
        contentType: contentType,
        headers: headers ?? mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      response = handleResponse(response);
      if(foundation.kDebugMode) {
      }
      return response;
    }catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, dynamic> query, String contentType,
    Map<String, String> headers, Function(dynamic) decoder, Function(double) uploadProgress,
  }) async {
    try {
      if(foundation.kDebugMode) {
      }
      Response response = await put(
        uri, body,
        query: query,
        contentType: contentType,
        headers: headers ?? mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      response = handleResponse(response);
      if(foundation.kDebugMode) {
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri, {Map<String, dynamic> query, String contentType,
    Map<String, String> headers, Function(dynamic) decoder,
  }) async {
    try {
      if(foundation.kDebugMode) {
      }
      Response response = await delete(
        uri,
        headers: headers ?? mainHeaders,
        contentType: contentType,
        query: query,
        decoder: decoder,
      );
      response = handleResponse(response);
      if(foundation.kDebugMode) {
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Response response) {
    Response _response = response;
    if(_response.hasError && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.hasError && _response.body == null) {
      _response = const Response(statusCode: 0, statusText: 'Connection to API server failed due to internet connection');
    }
    return _response;
  }
}