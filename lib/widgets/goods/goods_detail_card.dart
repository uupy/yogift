import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';
import 'package:yo_gift/widgets/goods/goods_sending_tag.dart';

class GoodsDetailCard extends StatefulWidget {
  final GiftDetailVo? data;
  final int quantity;

  const GoodsDetailCard({
    Key? key,
    this.data,
    this.quantity = 1,
  }) : super(key: key);

  @override
  _GoodsDetailCardState createState() => _GoodsDetailCardState();
}

class _GoodsDetailCardState extends State<GoodsDetailCard> {
  bool expendDetail = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.data;
    final shopName = item?.bussinessName ?? '';
    final buyPrice = item?.buyPrice ?? 0;
    final originalPrice = item?.originalPrice;
    final buy1Get1Free = item?.buy1Get1FREE ?? 0;

    return AppCard(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSimpleRow(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            prefix: buildImg(item?.cCoverImg, item?.sendingMethod),
            suffix: Container(
              margin: EdgeInsets.only(left: 8.w),
              child: Text(
                'X${widget.quantity}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
            ),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.giftName ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.w, bottom: 6.w),
                  child: Text(
                    '由$shopName售出',
                    style: TextStyle(
                      color: const Color(0xffff8d00),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.w),
                Row(
                  children: [
                    Text(
                      '\$$buyPrice',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (buy1Get1Free == 1)
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          '買一送一',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xffff3b30),
                          ),
                        ),
                      ),
                    if (buy1Get1Free == 0 &&
                        (originalPrice?.isNotEmpty ?? false))
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          '\$$originalPrice',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color.fromRGBO(0, 0, 0, 0.26),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 24.w),
          Text(
            '兌換條款及細則',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
            ),
          ),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
            ),
            maxLines: expendDetail ? null : 2,
            child: Html(
              data: item?.exchangeTerms ?? '',
              style: {
                'p': Style(
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              },
            ),
          ),
          if (!expendDetail)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    expendDetail = true;
                  });
                },
                child: Text(
                  '查看更多',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xff007aff),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildImg(String? url, num? sendingMethod) {
    return Stack(
      children: [
        AppImage(
          width: 90.w,
          height: 90.w,
          radius: 12.r,
          margin: EdgeInsets.only(right: 8.w),
          url: url,
          color: Colors.white,
          border: Border.all(
            width: 0.5,
            color: const Color(0xfff5f5f5),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 8.w,
          child: GoodsSendingTag(
            method: (sendingMethod ?? 1).toInt(),
          ),
        ),
      ],
    );
  }
}
