import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/models/address_list.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class AreaSelect extends StatefulWidget {
  final int? value;
  final List<AreaVo> items;
  final void Function(int?)? onChanged;

  const AreaSelect({
    Key? key,
    this.value,
    this.items = const [],
    this.onChanged,
  }) : super(key: key);

  @override
  _AreaSelectState createState() => _AreaSelectState();
}

class _AreaSelectState extends State<AreaSelect> {
  int? _value;

  @override
  void initState() {
    setState(() {
      _value = widget.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _value,
      hint: const Text('請選擇'),
      isExpanded: true,
      underline: Container(),
      elevation: 1,
      icon: AppAssetImage(
        width: 12.w,
        margin: EdgeInsets.only(left: 14.w),
        img: 'icon_arrow_down.png',
      ),
      items: widget.items.map((e) {
        return DropdownMenuItem(
          child: Text(e.title ?? ''),
          value: e.id,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _value = value;
        });
        widget.onChanged?.call(value);
      },
    );
  }
}
