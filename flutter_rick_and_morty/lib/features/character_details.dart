import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/core/constants/color_constants.dart';
import 'package:flutter_rick_and_morty/core/constants/string_constants.dart';
import 'package:flutter_rick_and_morty/core/utils/api_utils.dart';
import 'package:flutter_rick_and_morty/core/widgets/loading_indicator.dart';
import 'package:sizer/sizer.dart';

import '../core/models/all_characters_response_model.dart';

class CharacterDetails extends StatefulWidget {
  final String id;
  final String name;
  const CharacterDetails({super.key, required this.id, required this.name});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  AllCharactersResponseModel? allCharactersData;

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
            )));
  }

  Future getCharacterDetails() async {
    Response? response;

    loadingIndicator.show(context);
    response =
        await ApiUtils().httpGetCall(UrlConstants.getCharacterDetailsUrl + widget.id, context);
    if (response.statusCode == 200) {
      allCharactersData = AllCharactersResponseModel.fromJson(response.data);
      setState(() {});
    } else {
      //Need to show error to user here
    }

    loadingIndicator.hide();
  }
}
