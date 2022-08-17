import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/purchase/purchase_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import 'greeting_card_input.dart';
import 'greeting_card_top.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      id: 'GreetingCard',
      builder: (c) {
        final list = c.currentCard?.content1 ?? [];
        final textList = list.length > 3 ? list.sublist(0, 3) : list;

        if (c.currentCard == null) {
          return Container();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 200.w,
              radius: 20.w,
              url: c.currentCard?.bigImg,
              child: Column(
                children: [
                  GreetingCardTop(
                    isEdit: c.isEditMsg,
                    onPressed: () {
                      c.isEditMsg = !c.isEditMsg;
                      c.update(['GreetingCard']);
                    },
                  ),
                  GreetingCardInput(
                    controller: c.msgController,
                    isEdit: c.isEditMsg,
                    onChanged: (value) {
                      c.add4StepsForm.msgGive = value;
                    },
                  ),
                  ...textList.map((e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8.w),
                          height: 24.w,
                          child: AppButton(
                            text: e,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                            radius: 8.w,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.6),
                            borderColor: const Color.fromRGBO(0, 0, 0, 0),
                            onPressed: () {
                              c.add4StepsForm.msgGive = e;
                              c.msgController.text = e;
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20.w, 25.w, 20.w, 12.w),
              child: Text(
                '選擇卡片背景：',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
            ),
            SizedBox(
              height: 80.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: c.cards.length,
                itemBuilder: (context, index) {
                  final item = c.cards[index];
                  return AppImage(
                    onTap: () {
                      c.switchCard(item);
                    },
                    width: 80.w,
                    height: 80.w,
                    url: item.greetingCardImg,
                    radius: 16.r,
                    border: Border.all(
                      width: 0.5,
                      color: const Color(0xffe6e6e6),
                    ),
                    margin: index == 0
                        ? EdgeInsets.fromLTRB(20.w, 0, 7.w, 0)
                        : (index == c.cards.length - 1
                            ? EdgeInsets.fromLTRB(7.w, 0, 20.w, 0)
                            : EdgeInsets.symmetric(horizontal: 7.w)),
                    child: c.currentCard == item
                        ? Container(
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
                          )
                        : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
