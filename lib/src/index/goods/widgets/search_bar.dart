import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_input.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String? keywords;

  void goSearchPage() {
    if (keywords?.isNotEmpty ?? false) {
      Get.toNamed(
        '/pages/search/result/index',
        parameters: {'keyword': keywords!},
      );
    } else {
      app.showToast('請輸入搜索內容');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.w,
      child: AppInput(
        padding: EdgeInsets.only(left: 10.w),
        hintText: '搜尋禮品、商戶名',
        radius: Radius.circular(36.w),
        backgroundColor: Colors.white,
        textInputAction: TextInputAction.search,
        prefix: [
          AppAssetImage(
            width: 16.w,
            margin: EdgeInsets.only(left: 6.w, right: 6.w),
            img: 'icon_search.png',
          ),
        ],
        actions: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: AppButton(
              fixedSize: Size(60.w, 32.w),
              text: '搜尋',
              onPressed: goSearchPage,
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            keywords = value;
          });
        },
        onSubmitted: (value) {
          goSearchPage();
        },
      ),
    );
  }
}
