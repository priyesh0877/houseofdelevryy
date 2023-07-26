import 'package:houseofdelevryy/util/dimensions.dart';
import 'package:houseofdelevryy/util/styles.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String data;
  ProfileCard({required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 1)],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(data, style: robotoMedium.copyWith(
          fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor,
        )),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        Text(title, style: robotoRegular.copyWith(
          fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor,
        )),
      ]),
    ));
  }
}