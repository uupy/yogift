import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(20.w),
            child: const Text(
              "您可通過以下方式聯繫：",
            ),
          ),
          Expanded(
            child: GridView.extent(
              padding: EdgeInsets.all(4.w),
              maxCrossAxisExtent: 125.w,
              childAspectRatio: 1.3,
              mainAxisSpacing: 4.w,
              crossAxisSpacing: 4.w,
              children: [
                buildItem(
                  img: 'icon_email.png',
                  name: '郵件',
                ),
                buildItem(
                  img: 'icon_online.png',
                  name: '在線客服',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required String img,
    required String name,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssetImage(
            width: 40.w,
            height: 40.w,
            margin: EdgeInsets.only(bottom: 8.w),
            img: img,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color.fromRGBO(0, 0, 0, 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
