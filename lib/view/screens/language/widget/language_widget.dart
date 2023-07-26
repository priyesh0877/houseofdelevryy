import 'package:houseofdelevryy/controller/localization_controller.dart';
import 'package:houseofdelevryy/data/model/response/language_model.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:houseofdelevryy/util/dimensions.dart';
import 'package:houseofdelevryy/util/styles.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  LanguageWidget({required this.languageModel, required this.localizationController, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(Locale(
          AppConstants.languages[index].languageCode,
          AppConstants.languages[index].countryCode,
        ));
        localizationController.setSelectIndex(index);
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 1)],
        ),
        child: Stack(children: [

          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 65, width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  border: Border.all(color: Theme.of(context).textTheme.bodyText1!.color, width: 1),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  languageModel.imageUrl, width: 36, height: 36,
                  color: languageModel.languageCode == 'en' || languageModel.languageCode == 'ar'
                      ? Theme.of(context).textTheme.bodyText1!.color : null,
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Text(languageModel.languageName, style: robotoRegular),
            ]),
          ),

          localizationController.selectedIndex == index ? Positioned(
            top: 0, right: 0,
            child: Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 25),
          ) : SizedBox(),

        ]),
      ),
    );
  }
}