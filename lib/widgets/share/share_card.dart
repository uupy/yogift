import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_button.dart';
final GlobalKey<State<StatefulWidget>> shareCardKey = GlobalKey();

class ShareCard extends StatelessWidget {
   final String cardMsg;
   final String goodsImageUrl;
   final String cardImageUrl;
   final String goodsName;
   final String buttonText;   

  const ShareCard({
    Key? key, 
     required this.cardMsg, 
     required this.goodsImageUrl, 
     required this.cardImageUrl, 
     required this.goodsName, 
     required this.buttonText
    }
  ) : super(key: key);   

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: shareCardKey,
      child: Container(
        height: 260.w,
        width: double.infinity,
        /// 卡片背景色
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.w)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(cardImageUrl),
            )),
        child: Column(children: [
          /// cardMsg 卡片祝福语
          Container(
            margin: EdgeInsets.only(top: 8.w),
            height: 30.w,
            width: 250.w,
            child: AppButton(
              text: cardMsg,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
              radius: 8.w,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.6),
              borderColor: const Color.fromRGBO(0, 0, 0, 0),
            ),
          ),

          // goodImage 商品图片
          Container(
            margin: EdgeInsets.only(top: 10.w),
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                image: DecorationImage(
                    fit: BoxFit.fitWidth, image: NetworkImage(goodsImageUrl))),
          ),

          /// 商品名稱
          Container(
            margin: EdgeInsets.only(top: 10.w),
            child: Text(
              goodsName,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ),

          /// 按鈕文案
          Container(
              width: 160.w,
              margin: EdgeInsets.only(top: 10.w),
              child: AppButton(
                shadow: true,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.9),
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
