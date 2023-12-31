import 'package:houseofdelevryy/controller/auth_controller.dart';
import 'package:houseofdelevryy/controller/order_controller.dart';
import 'package:houseofdelevryy/helper/responsive_helper.dart';
import 'package:houseofdelevryy/util/dimensions.dart';
import 'package:houseofdelevryy/util/styles.dart';
import 'package:houseofdelevryy/view/base/custom_app_bar.dart';
import 'package:houseofdelevryy/view/base/not_logged_in_screen.dart';
import 'package:houseofdelevryy/view/screens/order/widget/order_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn) {
      _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
      Get.find<OrderController>().getRunningOrders(1, notify: false);
      Get.find<OrderController>().getHistoryOrders(1, notify: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'my_orders'.tr, isBackButtonExist: ResponsiveHelper.isDesktop(context), onBackPressed: (){},),
      body: _isLoggedIn ? GetBuilder<OrderController>(
        builder: (orderController) {
          return Column(children: [

            Center(
              child: Container(
                width: Dimensions.WEB_MAX_WIDTH,
                color: Theme.of(context).cardColor,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                  labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                  tabs: [
                    Tab(text: 'running'.tr),
                    Tab(text: 'history'.tr),
                    Tab(text: 'Subscription'.tr),
                  ],
                ),
              ),
            ),

            Expanded(child: TabBarView(
              controller: _tabController,
              children: [
                OrderView(isRunning: true),
                OrderView(isRunning: false),
                order(),

              ],
            )),

          ]);
        },
      ) : NotLoggedInScreen(),
    );
  }
}