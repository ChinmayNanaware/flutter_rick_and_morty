import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/core/constants/color_constants.dart';
import 'package:flutter_rick_and_morty/core/constants/string_constants.dart';
import 'package:flutter_rick_and_morty/core/models/all_characters_response_model.dart';
import 'package:flutter_rick_and_morty/core/utils/api_utils.dart';
import 'package:flutter_rick_and_morty/core/utils/navigator_utils.dart';
import 'package:flutter_rick_and_morty/core/widgets/loading_indicator.dart';
import 'package:flutter_rick_and_morty/features/character_details.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllCharactersResponseModel? allCharactersData;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCharacters();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.mediumGrey.withOpacity(0.3),
        appBar: AppBar(
          backgroundColor: TColors.mediumGrey.withOpacity(0),
          title: Text("Rick & Morty characters",
              style:
                  TextStyle(color: TColors.white, fontSize: 15.0.sp, fontWeight: FontWeight.w400)),
        ),
        body: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: allCharactersData != null ? allCharactersData!.results!.length : 0,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    FadeRoute(
                        page: CharacterDetails(
                      id: allCharactersData!.results![index].id.toString(),
                      name: allCharactersData!.results![index].name!,
                    ) // Replace with your next screen
                        ));
              },
              child: Card(
                color: TColors.mediumGrey.withOpacity(0.5),
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0.h),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      allCharactersData!.results![index].image!,
                      height: 16.0.h,
                    ),
                    SizedBox(
                      width: 1.0.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(allCharactersData!.results![index].name!,
                            style: TextStyle(
                                color: TColors.white,
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 1.2.h,
                              color: allCharactersData!.results![index].status == "Alive"
                                  ? TColors.successGreen
                                  : allCharactersData!.results![index].status == "unknown"
                                      ? TColors.errorYellow
                                      : TColors.errorRed,
                            ),
                            SizedBox(width: 0.6.h),
                            Text(allCharactersData!.results![index].status!,
                                style: TextStyle(
                                    color: TColors.white,
                                    fontSize: 9.0.sp,
                                    fontWeight: FontWeight.w500)),
                            Text(" - " + allCharactersData!.results![index].species!,
                                style: TextStyle(
                                    color: TColors.white,
                                    fontSize: 9.0.sp,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(height: 1.0.h),
                        Text("Last known location:",
                            style: TextStyle(
                                color: TColors.borderGrey,
                                fontSize: 9.0.sp,
                                fontWeight: FontWeight.normal)),
                        Text(allCharactersData!.results![index].location!.name!,
                            style: TextStyle(
                                color: TColors.white,
                                fontSize: 9.0.sp,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 1.0.h),
                        Text("First seen in:",
                            style: TextStyle(
                                color: TColors.borderGrey,
                                fontSize: 9.0.sp,
                                fontWeight: FontWeight.normal)),
                        Text(
                            allCharactersData!.results![index].episode!.first
                                .replaceAll(UrlConstants.apiBaseUrl, "")
                                .replaceAll("/", " ")
                                .toUpperCase(),
                            style: TextStyle(
                                color: TColors.white,
                                fontSize: 9.0.sp,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 2.0.h,
            );
          },
        ),
      ),
    );
  }

  Future getCharacters() async {
    Response? response;

    loadingIndicator.show(context);
    response = await ApiUtils().httpGetCall(UrlConstants.getAllCharactersUrl, context);
    if (response.statusCode == 200) {
      allCharactersData = AllCharactersResponseModel.fromJson(response.data);
      setState(() {});
    } else {
      //Need to show error to user here
    }

    loadingIndicator.hide();
  }
}
