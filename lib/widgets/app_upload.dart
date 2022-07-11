import 'dart:async';

import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/oss/oss.dart';
import 'package:yo_gift/widgets/bottom_sheet_actions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

export 'package:image_picker/image_picker.dart';

enum FileType {
  image,
  video,
  both,
}

class AppUpload extends StatefulWidget {
  final Widget? child;
  final int? max;
  final bool disabled;
  final FileType fileType;
  final ImageSource? source;
  final Function(String filePath, String uploadPath)? success;
  final Widget? action;
  final Widget Function(bool loading, String? value, Widget? action)? builder;

  const AppUpload({
    Key? key,
    this.child,
    this.max,
    this.disabled = false,
    this.fileType = FileType.image,
    this.source,
    this.success,
    this.action,
    this.builder,
  }) : super(key: key);

  @override
  _AppUpload createState() => _AppUpload();
}

class _AppUpload extends State<AppUpload> {
  bool loading = false;
  String filePath = '';

  @override
  void initState() {
    super.initState();
  }

  Future handleUpload(int index, [bool isVideo = false]) async {
    List<ImageSource> sources = [ImageSource.gallery, ImageSource.camera];
    ImageSource source = sources[index];
    ImagePicker picker = ImagePicker();
    XFile? file;

    final hasPermission = await app.checkCameraPermission();
    if (!hasPermission) return;

    if (isVideo) {
      file = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(seconds: 60),
      );
    } else {
      file = await picker.pickImage(
        source: source,
        imageQuality: 95,
        maxWidth: 1080,
      );
    }

    if (file?.path.isNotEmpty ?? false) {
      filePath = file!.path;
      final res = await oss.addTask(
        filePath,
        isVideo ? 'video' : 'image',
      );
      final ossHost = oss.data?.host ?? '';
      final path = res.uploadPath ?? '';

      if (ossHost.isNotEmpty && path.isNotEmpty) {
        widget.success?.call(res.filePath!, '$ossHost/$path');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder == null) {
      return Stack(
        children: [
          widget.child ?? Container(),
          Center(
            child: buildAction(),
          ),
        ],
      );
    }
    return widget.builder!(loading, filePath, buildAction());
  }

  Widget buildAction() {
    if (loading) {
      return const SizedBox(
        width: 30,
        height: 30,
        child: Padding(
          padding: EdgeInsets.all(3),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.grey,
          ),
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (loading || widget.disabled) return;
        if (widget.source != null) {
          final index = widget.source == ImageSource.gallery ? 0 : 1;
          if (widget.fileType != FileType.both) {
            handleUpload(index, widget.fileType == FileType.video);
            return;
          }
        }
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            final isBoth = widget.fileType == FileType.both;
            List<String> items = ['相册', '拍照'];

            if (isBoth) {
              items = ['拍照', '录像'];
            }

            return BottomSheetActions(
              items: items,
              onItemTap: (index) {
                if (isBoth) {
                  handleUpload(1, index == 1);
                } else {
                  handleUpload(index);
                }
              },
            );
          },
        );
      },
      child: widget.action,
    );
  }
}
