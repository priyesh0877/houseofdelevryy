import 'dart:async';
import 'dart:io';
import 'package:houseofdelevryy/controller/auth_controller.dart';
import 'package:houseofdelevryy/controller/cart_controller.dart';
import 'package:houseofdelevryy/controller/localization_controller.dart';
import 'package:houseofdelevryy/controller/location_controller.dart';
import 'package:houseofdelevryy/controller/splash_controller.dart';
import 'package:houseofdelevryy/controller/theme_controller.dart';
import 'package:houseofdelevryy/controller/wishlist_controller.dart';
import 'package:houseofdelevryy/helper/notification_helper.dart';
import 'package:houseofdelevryy/helper/responsive_helper.dart';
import 'package:houseofdelevryy/helper/route_helper.dart';
import 'package:houseofdelevryy/theme/dark_theme.dart';
import 'package:houseofdelevryy/theme/light_theme.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:houseofdelevryy/util/messages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if(ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = new MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  if(GetPlatform.isWeb) {
    await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: 'AIzaSyCeaw_gVN0iQwFHyuF8pQ6PbVDmSVQw8AY',
      appId: '1:1049699819506:web:a4b5e3bedc729aab89956b',
      messagingSenderId: '1049699819506',
      projectId: 'houseofdelivery-bd3ee',
    ));
  }else {
    await Firebase.initializeApp();
  }

  Map<String, Map<String, String>> _languages = await di.init();

  var orderID = _orderID.toInt() ?? 0;
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        orderID = (remoteMessage.notification!.titleLocKey != null ? int.parse(remoteMessage.notification!.titleLocKey.toString()) : null);
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }catch(e) {}

  // if (ResponsiveHelper.isWeb()) {
  //   FacebookAuth.i.webInitialize(
  //     appId: "452131619626499",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v9.0",
  //   );
  // }
  runApp(MyApp(languages: _languages, orderID: orderID));
}

class _orderID {
  static toInt() {}
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final int orderID;
  MyApp({required this.languages, required this.orderID});

  void _route() {
    Get.find<SplashController>().getConfigData().then((bool isSuccess) async {
      if (isSuccess) {
        if (Get.find<AuthController>().isLoggedIn()) {
          Get.find<AuthController>().updateToken();
          await Get.find<WishListController>().getWishList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(GetPlatform.isWeb) {
      Get.find<SplashController>().initSharedData();
      if(Get.find<LocationController>().getUserAddress() != null && (Get.find<LocationController>().getUserAddress().zoneIds == null
          || Get.find<LocationController>().getUserAddress().zoneData == null)) {
        Get.find<AuthController>().clearSharedAddress();
      }
      Get.find<CartController>().getCartData();
      _route();
    }

    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return (GetPlatform.isWeb && splashController.configModel == null) ? SizedBox() : GetMaterialApp(
            title: AppConstants.APP_NAME,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            scrollBehavior: MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            ),
            theme: themeController.darkTheme ? dark : light,
            locale: localizeController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
            initialRoute: GetPlatform.isWeb ? RouteHelper.getInitialRoute() : RouteHelper.getSplashRoute(orderID),
            getPages: RouteHelper.routes,
            defaultTransition: Transition.topLevel,
            transitionDuration: Duration(milliseconds: 500),
          );
        });
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}