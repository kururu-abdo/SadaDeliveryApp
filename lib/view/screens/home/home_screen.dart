import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/auth_controller.dart';
import 'package:sixvalley_delivery_boy/controller/location_controller.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/order_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/language/choose_language_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();


  Future<void> _loadData(BuildContext context) async {
    await Get.find<OrderController>().getAllOrders(context);
    await Get.find<LocationController>().getUserLocation();
  }


  @override
  Widget build(BuildContext context) {
    _loadData(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          leadingWidth: 0,
          actions: [

            Get.find<OrderController>().currentOrders.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.refresh, color: Theme.of(context).textTheme.bodyText1.color),
                      onPressed: () {Get.find<OrderController>().orderRefresh(context);}):const SizedBox.shrink(),

            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'language':
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) =>  const ChooseLanguageScreen(fromHomeScreen: true)));
                }
              },
              icon: Icon(
                Icons.more_vert_outlined,
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'language',
                  child: Row(
                    children: [
                      Icon(Icons.language, color: Theme.of(context).textTheme.bodyText1.color),
                      const SizedBox(width: Dimensions.paddingSizeLarge),
                      Text('change_language'.tr, style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
          leading: const SizedBox.shrink(),
          title: Get.find<AuthController>().profileModel != null
              ? Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage.assetNetwork(
                    imageErrorBuilder: (c,o,s) =>Image.asset(Images.placeholder),
                    placeholder: Images.placeholder,

                    fit: BoxFit.fill,
                    image: '${Get.find<SplashController>().baseUrls.reviewImageUrl}/delivery-man/${Get.find<AuthController>().profileModel.image}',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(Get.find<AuthController>().profileModel.fName != null
                    ? '${Get.find<AuthController>().profileModel.fName ?? ''} ${Get.find<AuthController>().profileModel.lName ?? ''}'
                    : "",
                style: Theme.of(context).textTheme.headline3.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyText1.color),
              )
            ],
          )
              : const SizedBox.shrink(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child:  GetBuilder<OrderController>(builder: (orderController) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('active_order'.tr, style: Theme.of(context).textTheme.headline3.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                const SizedBox(height: 10),
                Expanded(child: RefreshIndicator(
                  child: orderController.currentOrders != null ? orderController.currentOrders.isNotEmpty ? ListView.builder(
                    itemCount: orderController.currentOrders.length,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context, index) => OrderWidget(orderModel: orderController.currentOrders[index], index: index,),
                  ) : Center(child: Text('no_order_found'.tr, style: Theme.of(context).textTheme.headline3,),
                  ) : Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor),),
                  key: _refreshIndicatorKey,
                  displacement: 0,
                  color: ColorResources.colorWhite,
                  backgroundColor: Theme.of(context).primaryColor,
                  onRefresh: () {
                    return orderController.orderRefresh(context);
                  },
                ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
