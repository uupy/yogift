import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import 'greeting_card_controller.dart';
import 'greeting_card_input.dart';
import 'greeting_card_top.dart';

class GreetingCardSelect extends StatelessWidget {
  const GreetingCardSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GreetingCardController>(
      id: 'GreetingCardSelect',
      builder: (c) {
        final list = c.currentCard?.content1 ?? [];
        final textList = list.length > 3 ? list.sublist(0, 3) : list;

        return AppImage(
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
                  c.update(['GreetingCardSelect']);
                },
              ),
              GreetingCardInput(
                controller: c.msgController,
                isEdit: c.isEditMsg,
                onChanged: (value) {
                  c.cardMsg = value ?? '';
                  c.onCardChanged();
                },
              ),
              ...textList.map((text) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.w),
                      height: 24.w,
                      child: AppButton(
                        text: text,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        radius: 8.w,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.6),
                        borderColor: const Color.fromRGBO(0, 0, 0, 0),
                        onPressed: () {
                          c.msgController.text = text;
                          c.cardMsg = text;
                          c.onCardChanged();
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
