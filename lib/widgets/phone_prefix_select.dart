import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class PhonePrefixSelect extends StatefulWidget {
  final String? value;
  final void Function(String?)? onChanged;

  const PhonePrefixSelect({
    Key? key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  _PhonePrefixSelectState createState() => _PhonePrefixSelectState();
}

class _PhonePrefixSelectState extends State<PhonePrefixSelect> {
  String? _value;

  @override
  void initState() {
    setState(() {
      _value = widget.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      id: 'phonePrefixSelect',
      builder: (c) {
        final list = c.config?.areacodelist ?? [];

        return DropdownButton<String>(
          value: _value,
          hint: const Text('請選擇'),
          underline: Container(),
          elevation: 1,
          icon: AppAssetImage(
            width: 12.w,
            margin: EdgeInsets.only(left: 14.w),
            img: 'icon_arrow_down.png',
          ),
          items: list.map((e) {
            return DropdownMenuItem(
              child: Text(e.code ?? ''),
              value: e.code,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
            widget.onChanged?.call(value);
          },
        );
      },
    );
  }
}
