import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/services/user.dart';
import 'package:yo_gift/widgets/gender_select.dart';

import 'menu_row.dart';

class GenderMenuRow extends StatelessWidget {
  final int? value;
  final Function(int value)? onChanged;

  const GenderMenuRow({
    Key? key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String gender = '';

    if (value == 1) {
      gender = '男';
    } else if (value == 2) {
      gender = '女';
    }

    return AccountSettingMenuRow(
      label: '性別',
      content: gender,
      onTap: () {
        app.showBottomModal(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 150.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(20.w),
                    child: const Text(
                      "修改性別：",
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
                    child: GenderSelect(
                      value: value ?? 1,
                      onChanged: (value) async {
                        await UserService.updateGender(value);
                        Navigator.pop(context);
                        onChanged?.call(value);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
