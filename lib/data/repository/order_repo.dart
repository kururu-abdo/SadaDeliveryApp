import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OrderRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getAllOrders() async {
      Response _response = await apiClient.get(AppConstants.currentOrderUri,
        headers:  {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${sharedPreferences.get(AppConstants.token)}'
        },

      );
      return _response;

  }

  Future<Response> getOrderDetails({String orderID}) async {
      Response response = await apiClient.get('${AppConstants.orderDetailsUri}$orderID',
        headers:  {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${sharedPreferences.get(AppConstants.token)}'
        },
      );
      return response;
  }

  Future<Response> getAllOrderHistory() async {
      Response response = await apiClient.get(AppConstants.allOrderHistoryUri,
        headers:  {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${sharedPreferences.get(AppConstants.token)}'
        },

      );
      return response;

  }

  Future<Response> updateOrderStatus({int orderId, String status}) async {

      Response response = await apiClient.post(
        AppConstants.updateOrderStatusUri,
        {"order_id": orderId, "status": status, "_method": 'put'},
        headers:  {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${sharedPreferences.get(AppConstants.token)}'
        },
      );
      return response;

  }
  Future<Response> updatePaymentStatus({int orderId, String status}) async {

      Response response = await apiClient.post(
        AppConstants.updatePaymentStatusUri,
        {"order_id": orderId, "payment_status": status, "_method": 'put'},
        headers:  {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${sharedPreferences.get(AppConstants.token)}'
        },
      );
      return response;

  }
}
