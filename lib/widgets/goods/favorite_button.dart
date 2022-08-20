import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/services/user_favorites.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class FavoriteButton extends StatefulWidget {
  final bool showText;
  final double? size;
  final int? favorite;
  final String? guid;
  final Function(int value)? onChanged;

  const FavoriteButton({
    Key? key,
    this.showText = true,
    this.size,
    this.favorite,
    this.guid,
    this.onChanged,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  int _favorite = 0;

  @override
  void initState() {
    setState(() {
      _favorite = widget.favorite ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: widget.size ?? 20.w,
      onTap: (isLike) async {
        if (widget.guid != null) {
          await UserFavoritesService.addOrDelete(widget.guid!);
          setState(() {
            _favorite = _favorite == 0 ? 1 : 0;
          });
          widget.onChanged?.call(_favorite);
          if (_favorite == 0) {
            app.showToast('已取消收藏');
          }
        }
        return _favorite == 1;
      },
      likeBuilder: (isLike) {
        return AppAssetImage(
          img: 'icon_heart_$_favorite.png',
          width: 20.w,
        );
      },
      likeCount: widget.showText ? 1 : null,
      countPostion: CountPostion.bottom,
      countBuilder: (count, isLiked, text) {
        return Text(
          '願望清單',
          style: TextStyle(
            fontSize: 11.sp,
            color: const Color.fromRGBO(0, 0, 0, 0.9),
          ),
        );
      },
    );
  }
}
