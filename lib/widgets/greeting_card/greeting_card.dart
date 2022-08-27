import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'greeting_card_controller.dart';
import 'greeting_card_list.dart';
import 'greeting_card_select.dart';

class GreetingCard extends StatefulWidget {
  /// [type] 类型, 0全部，1拜托专用，2非拜托卡
  final int type;
  final EdgeInsetsGeometry? margin;
  final Function(String cardId, String msg)? onChanged;

  const GreetingCard({
    Key? key,
    required this.type,
    this.margin,
    this.onChanged,
  }) : super(key: key);

  @override
  _GreetingCardState createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  final controller = Get.put(GreetingCardController());

  @override
  void initState() {
    controller.onChanged = widget.onChanged;
    controller.queryCards(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GreetingCardController>(
      id: 'GreetingCard',
      builder: (c) {
        if (c.currentCard == null) {
          return Container();
        }

        return Container(
          margin: widget.margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingCardSelect(),
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
              const GreetingCardList(),
            ],
          ),
        );
      },
    );
  }
}
