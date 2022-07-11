import 'package:flutter/material.dart';

class BottomSheetActions extends StatefulWidget {
  const BottomSheetActions({
    Key? key,
    required this.items,
    this.onItemTap,
  })  : assert(items != null),
        super(key: key);
  final List<String>? items;
  final OnItemTap? onItemTap;

  @override
  _BottomSheetActions createState() => _BottomSheetActions();
}

typedef OnItemTap = void Function(int index);

class _BottomSheetActions extends State<BottomSheetActions> {
  OnItemTap? onItemTap;
  int? itemCount;
  double itemHeight = 50;
  var borderColor = Colors.white;
  double circular = 10;
  var textColor = const Color(0xff007aff);

  @override
  void initState() {
    super.initState();
    onItemTap = widget.onItemTap;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size screenSize = MediaQuery.of(context).size;

    var deviceWidth = orientation == Orientation.portrait
        ? screenSize.width
        : screenSize.height;

    /// *2-1是为了加分割线
    itemCount = (widget.items!.length * 2 - 1);
    var height =
        ((widget.items!.length + 1) * (itemHeight + 1) + 10).toDouble();
    var cancelContainer = SafeArea(
      bottom: true,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: itemHeight,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white, // 底色
            borderRadius: BorderRadius.circular(circular),
          ),
          alignment: Alignment.center,
          child: Text(
            "取消",
            style: TextStyle(
              fontFamily: 'Robot',
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
    var listview = ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return getItemContainer(context, index);
      },
    );

    var totalContainer = SizedBox(
      height: height + 10,
      width: deviceWidth * 0.98,
      // color: Colors.red,
      child: Column(
        children: <Widget>[
          Expanded(child: listview),
          Container(
            child: cancelContainer,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
          )
        ],
      ),
    );

    var stack = Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Positioned(
          // bottom: 0,
          child: totalContainer,
        ),
      ],
    );
    return stack;
  }

  Widget getItemContainer(BuildContext context, int index) {
    if (widget.items == null) {
      return Container();
    }
    if (index.isOdd) {
      return Container(
        height: 1,
        margin: const EdgeInsets.only(left: 10, right: 10),
        color: const Color(0xffeeeeee),
      );
    }

    BorderRadius? borderRadius;
    EdgeInsets? margin;
    var isFirst = false;
    var isLast = false;

    /// 只有一个元素
    if (widget.items!.length == 1) {
      borderRadius = BorderRadius.circular(circular);
      margin = const EdgeInsets.only(bottom: 10, left: 10, right: 10);
    } else if (widget.items!.length > 1) {
      /// 第一个元素
      if (index == 0) {
        isFirst = true;
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(circular),
          topRight: Radius.circular(circular),
        );
        margin = const EdgeInsets.only(
          left: 10,
          right: 10,
        );
      } else if (index == itemCount! - 1) {
        isLast = true;

        /// 最后一个元素
        borderRadius = BorderRadius.only(
          bottomLeft: Radius.circular(circular),
          bottomRight: Radius.circular(circular),
        );
        margin = const EdgeInsets.only(left: 10, right: 10);
      } else {
        /// 其他位置元素
        margin = const EdgeInsets.only(left: 10, right: 10);
      }
    }
    var isFirstOrLast = isFirst || isLast;
    int listIndex = index ~/ 2;
    var text = widget.items![listIndex];
    var contentText = Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
        color: textColor,
        fontSize: 18,
      ),
    );

    Center? center;
    if (!isFirstOrLast) {
      center = Center(child: contentText);
    }
    var itemContainer = Container(
      height: itemHeight,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white, // 底色
        borderRadius: borderRadius,
        // border: border,
      ),
      child: center,
    );
    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[itemContainer, contentText],
    );
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onItemTap?.call(listIndex);
      },
      child: isFirstOrLast ? stack : itemContainer,
    );
  }
}
