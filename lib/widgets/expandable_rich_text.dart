import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableRichText extends StatefulWidget {
  final String? content;

  const ExpandableRichText({Key? key, this.content}) : super(key: key);

  @override
  _ExpandableRichTextState createState() => _ExpandableRichTextState();
}

class _ExpandableRichTextState extends State<ExpandableRichText> {
  bool expendDetail = false;

  @override
  Widget build(BuildContext context) {
    final _content = widget.content ?? '';

    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
            ),
            maxLines: expendDetail ? null : 2,
            child: Html(
              data: _content.replaceAll(
                  '<br/>', '<div style="height: 17px"> </div>'),
              style: {
                'body': Style(
                  margin: EdgeInsets.zero,
                  lineHeight: LineHeight.number(1.3),
                  fontSize: FontSize.medium,
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  expendDetail = !expendDetail;
                });
              },
              child: Text(
                expendDetail ? '收回' : '查看更多',
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
}
