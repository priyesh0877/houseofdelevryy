import 'package:houseofdelevryy/controller/cart_controller.dart';
import 'package:houseofdelevryy/controller/coupon_controller.dart';
import 'package:houseofdelevryy/helper/price_converter.dart';
import 'package:houseofdelevryy/helper/responsive_helper.dart';
import 'package:houseofdelevryy/helper/route_helper.dart';
import 'package:houseofdelevryy/util/dimensions.dart';
import 'package:houseofdelevryy/util/styles.dart';
import 'package:houseofdelevryy/view/base/custom_app_bar.dart';
import 'package:houseofdelevryy/view/base/custom_button.dart';
import 'package:houseofdelevryy/view/base/custom_snackbar.dart';
import 'package:houseofdelevryy/view/base/no_data_screen.dart';
import 'package:houseofdelevryy/view/screens/cart/widget/cart_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  final fromNav;
  CartScreen({@required this.fromNav});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();

    Get.find<CartController>().calculationCart();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'my_cart'.tr, isBackButtonExist: (ResponsiveHelper.isDesktop(context) || !widget.fromNav), onBackPressed: (){},),
      body: GetBuilder<CartController>(builder: (cartController) {

        return cartController.cartList.length > 0 ? Column(
          children: [

            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL), physics: BouncingScrollPhysics(),
                  child: Center(
                    child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        // Product
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartController.cartList.length,
                          itemBuilder: (context, index) {
                            return CartProductWidget(cart: cartController.cartList[index], cartIndex: index, addOns: cartController.addOnsList[index] , isAvailable: cartController.availableList[index]);
                          },
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                        // Total
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('item_price'.tr, style: robotoRegular),
                          Text(PriceConverter.convertPrice(cartController.itemPrice, discount: 0,discountType: 'k'), style: robotoRegular),
                        ]),
                        SizedBox(height: 10),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('addons'.tr, style: robotoRegular),
                          Text('(+) ${PriceConverter.convertPrice(cartController.addOns, discount: 0,discountType: 'k')}', style: robotoRegular),
                        ]),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('subtotal'.tr, style: robotoMedium),
                          Text(PriceConverter.convertPrice(cartController.subTotal, discount: 0,discountType: 'k'), style: robotoMedium),
                        ]),


                      ]),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              width: Dimensions.WEB_MAX_WIDTH,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: CustomButton(buttonText: 'proceed_to_checkout'.tr, onPressed: () {
                if(!cartController.cartList.first.product.scheduleOrder && cartController.availableList.contains(false)) {
                  showCustomSnackBar('one_or_more_product_unavailable'.tr);
                } else {
                  Get.find<CouponController>().removeCouponData(false);
                  Get.toNamed(RouteHelper.getCheckoutRoute('cart'));
                }
              }),
            ),

          ],
        ) : NoDataScreen(isCart: true, text: '');
      },
      ),
    );
  }
}