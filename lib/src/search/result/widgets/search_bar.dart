import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_input.dart';

import '../result_controller.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchResultController>(
      id: 'SearchBar',
      builder: (c) {
        return SizedBox(
          height: 36.w,
          child: AppInput(
            controller: c.inputController,
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
                  onPressed: () {
                    c.listController.onReload();
                  },
                ),
              ),
            ],
            onChanged: (value) {
              c.giftname = value ?? '';
            },
            onSubmitted: (value) {
              c.listController.onReload();
            },
          ),
        );
      },
    );
  }
}
