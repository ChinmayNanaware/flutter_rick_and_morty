import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rick_and_morty/core/constants/color_constants.dart';
import 'package:flutter_rick_and_morty/core/constants/string_constants.dart';
import 'package:flutter_rick_and_morty/core/models/character_details_response_model.dart';
import 'package:flutter_rick_and_morty/core/utils/api_utils.dart';
import 'package:flutter_rick_and_morty/core/widgets/loading_indicator.dart';
import 'package:sizer/sizer.dart';

class CharacterDetails extends StatefulWidget {
  final String id;
  final String name;
  const CharacterDetails({super.key, required this.id, required this.name});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  CharacterDetailsResponseModel? characterData;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCharacterDetails();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: TColors.mediumGrey.withOpacity(0.3),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: TColors.mediumGrey.withOpacity(0),
            title: Text(widget.name,
                style: TextStyle(
                    color: TColors.white, fontSize: 15.0.sp, fontWeight: FontWeight.w400)),
          ),
          body: characterData != null
              ? Padding(
                  padding: EdgeInsets.all(1.0.h),
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20.0.h,
                            width: 20.0.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                image: NetworkImage(characterData!.image!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.0.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(characterData!.name!,
                                  style: TextStyle(
                                      color: TColors.white,
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w500)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 1.2.h,
                                    color: characterData!.status == "Alive"
                                        ? TColors.successGreen
                                        : characterData!.status == "unknown"
                                            ? TColors.errorYellow
                                            : TColors.errorRed,
                                  ),
                                  SizedBox(width: 0.6.h),
                                  Text(characterData!.status!,
                                      style: TextStyle(
                                          color: TColors.white,
                                          fontSize: 11.0.sp,
                                          fontWeight: FontWeight.w500)),
                                  Text(" - " + characterData!.species!,
                                      style: TextStyle(
                                          color: TColors.white,
                                          fontSize: 11.0.sp,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 1.0.h),
                              Text("Last known location:",
                                  style: TextStyle(
                                      color: TColors.borderGrey,
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.normal)),
                              Text(characterData!.location!.name!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: TColors.white,
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 1.0.h),
                              Text("Gender:",
                                  style: TextStyle(
                                      color: TColors.borderGrey,
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.normal)),
                              Text(characterData!.gender!,
                                  style: TextStyle(
                                      color: TColors.white,
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0.h),
                      Text("Episodes",
                          style: TextStyle(
                              color: TColors.white,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500)),
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: characterData != null
                            ? characterData!.episode!.map((episode) {
                                return Card(
                                  color: TColors.mediumGrey.withOpacity(0.5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.movie,
                                        color: TColors.white,
                                        size: 8.0.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1.0.h),
                                        child: Text(
                                          episode,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: TColors.borderGrey,
                                              fontSize: 11.0.sp,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()
                            : [],
                      ),
                    ],
                  ),
                )
              : Container()),
    );
  }

  Future getCharacterDetails() async {
    Response? response;

    loadingIndicator.show(context);
    response =
        await ApiUtils().httpGetCall(UrlConstants.getCharacterDetailsUrl + widget.id, context);
    if (response.statusCode == 200) {
      characterData = CharacterDetailsResponseModel.fromJson(response.data);
      setState(() {});
    } else {
      //Need to show error to user here
    }

    loadingIndicator.hide();
  }
}
