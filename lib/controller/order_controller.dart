import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/data/api/api_checker.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_details.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/data/repository/order_repo.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({@required this.orderRepo});

  // get all current order
  List<OrderModel> _currentOrders = [];
  List<OrderModel> _currentOrdersReverse = [];

  List<OrderModel> get currentOrders => _currentOrders;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future getAllOrders(BuildContext context) async {
    _isLoading = true;
    Response response = await orderRepo.getAllOrders();
    if (response.body != null && response.body != {} && response.statusCode == 200) {
      _currentOrders = [];
      _currentOrdersReverse = [];
      response.body.forEach((order) {_currentOrdersReverse.add(OrderModel.fromJson(order));});
      _currentOrders = List.from(_currentOrdersReverse.reversed);
      _isLoading = false;

    } else {
      ApiChecker.checkApi(response);
      _isLoading = false;
    }
    update();
  }

  // get order details
  final OrderDetailsModel _orderDetailsModel = OrderDetailsModel();

  OrderDetailsModel get orderDetailsModel => _orderDetailsModel;
  List<OrderDetailsModel> _orderDetails;

  List<OrderDetailsModel> get orderDetails => _orderDetails;

  Future<List<OrderDetailsModel>> getOrderDetails(String orderID, BuildContext context) async {
    _orderDetails = null;
    _isLoading = true;
    Response response = await orderRepo.getOrderDetails(orderID: orderID);
    if (response.body != null && response.statusCode == 200) {
      _orderDetails = [];
      response.body.forEach((orderDetail) => _orderDetails.add(OrderDetailsModel.fromJson(orderDetail)));
      _isLoading = false;
    } else {
      ApiChecker.checkApi( response);
      _isLoading = false;
    }
    update();
    return _orderDetails;
  }

  // get all order history
  List<OrderModel> _allOrderHistory;
  List<OrderModel> _allOrderReverse;

  List<OrderModel> get allOrderHistory => _allOrderHistory;

  Future getAllOrderHistory(BuildContext context) async {

    Response response = await orderRepo.getAllOrderHistory();
    if (response.body != null && response.statusCode == 200) {
      _allOrderHistory = [];
      _allOrderReverse = [];
      response.body.forEach((order) {
        _allOrderReverse.add(OrderModel.fromJson(order));
      });
      _allOrderHistory = List.from(_allOrderReverse.reversed);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  // Future<List<OrderModel>> getOrderHistory(BuildContext context) async {
  //   Response response = await orderRepo.getAllOrderHistory();
  //   print('====Controller=====>${response.body}');
  //   if (response.statusCode == 200) {
  //     _allOrderHistory = [];
  //     _allOrderReverse = [];
  //     response.body.forEach((orderDetail) => _allOrderReverse.add(OrderModel.fromJson(orderDetail)));
  //     _allOrderHistory = List.from(_allOrderReverse.reversed);
  //     print('=======>Order History ======>${_allOrderHistory.length}');
  //     _allOrderHistory.removeWhere((order) => (order.orderStatus) != 'delivered');
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return _allOrderHistory;
  // }

  // update Order Status

  String _feedbackMessage;

  String get feedbackMessage => _feedbackMessage;

  Future<bool> updateOrderStatus({int orderId, String status,BuildContext context}) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.updateOrderStatus(orderId: orderId, status: status);
    Get.back();
    bool _isSuccess;
    if(response.body != null && response.statusCode == 200) {
      // _currentOrders[index].orderStatus = status;
      showCustomSnackBar(response.body['message'], isError: false);
      _isSuccess = true;
      getAllOrders(context);
    }else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    _isLoading = false;
    getAllOrders(context);
    update();
    return _isSuccess;
  }

  Future updatePaymentStatus({int orderId, String status}) async {
    Response apiResponse = await orderRepo.updatePaymentStatus(orderId: orderId, status: status);

    if (apiResponse.statusCode == 200) {

    } else {
     ApiChecker.checkApi(apiResponse);
    }
    update();
  }

  Future orderRefresh(BuildContext context) async{
    getAllOrders(context);
    return getAllOrders(context);
  }
}
