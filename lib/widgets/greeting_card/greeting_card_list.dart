import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import 'greeting_card_controller.dart';

class GreetingCardList extends StatelessWidget {
  const GreetingCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GreetingCardController>(
      id: 'GreetingCardList',
      builder: (c) {
        return SizedBox(
          height: 80.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: c.cards.length,
            itemBuilder: (context, index) {
              final item = c.cards[index];
              EdgeInsetsGeometry? margin;
              Widget? child;

              if (index == 0) {
                margin = EdgeInsets.fromLTRB(20.w, 0, 7.w, 0);
              } else if (index == c.cards.length - 1) {
                margin = EdgeInsets.fromLTRB(7.w, 0, 20.w, 0);
              } else {
                margin = EdgeInsets.symmetric(horizontal: 7.w);
              }

              if (c.currentCard == item) {
                child = Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.r),
                    ),
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                  ),
                  child: Center(
                    child: AppAssetImage(
                      width: 24.w,
                      img: 'icon_checked.png',
                    ),
                  ),
                );
              }

              return AppImage(
                onTap: () {
                  c.switchCard(item);
                },
                width: 80.w,
                height: 80.w,
                cropWidth: 120,
                cropHeight: 120,
                url: item.greetingCardImg,
                radius: 16.r,
                border: Border.all(
                  width: 0.5,
                  color: const Color(0xffe6e6e6),
                ),
                margin: margin,
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
