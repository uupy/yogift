import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputNumber extends StatefulWidget {
  final Function(int value)? onChanged;

  const InputNumber({Key? key, this.onChanged}) : super(key: key);

  @override
  _InputNumberState createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  final controller = TextEditingController(text: '1');

  String inputValue = '1';
  int nCount = 1;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 15.sp),
      inputFormatters: [
        CountInputFormatter(),
      ],
      decoration: InputDecoration(
        hintText: '',
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(
            color: Color(0xffe6e6e6),
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffe6e6e6),
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffe6e6e6),
            width: 1,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIconConstraints: const BoxConstraints(),
        suffixIconConstraints: const BoxConstraints(),
        prefixIcon: buildButton(
          icon: Icons.remove,
          onTap: () {
            nCount = nCount > 1 ? nCount - 1 : nCount;
            controller.text = nCount.toString();
            widget.onChanged?.call(nCount);
          },
        ),
        suffixIcon: buildButton(
          icon: Icons.add,
          isRight: true,
          onTap: () {
            nCount = nCount + 1;
            controller.text = nCount.toString();
            widget.onChanged?.call(nCount);
          },
        ),
      ),
      onChanged: (value) {
        inputValue = value;
        nCount = int.tryParse(value) ?? 1;
        if (value.isNotEmpty && nCount <= 0) {
          nCount = 1;
          controller.text = nCount.toString();
        }
        widget.onChanged?.call(nCount);
      },
    );
  }

  Widget buildButton({
    IconData? icon,
    bool isRight = false,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 30.w,
        decoration: BoxDecoration(
          border: Border(
            right: isRight
                ? BorderSide.none
                : const BorderSide(
                    width: 1,
                    color: Color(0xffe6e6e6),
                  ),
            left: !isRight
                ? BorderSide.none
                : const BorderSide(
                    width: 1,
                    color: Color(0xffe6e6e6),
                  ),
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 16.sp,
            color: const Color.fromRGBO(0, 0, 0, 0.9),
          ),
        ),
      ),
    );
  }
}

class CountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (value.contains(',') || value.contains('.')) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
