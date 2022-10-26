library read_more_text;

import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
    this.text, {
    required this.numLines,
    required this.readMoreText,
    required this.readLessText,
    this.readMoreAlign = AlignmentDirectional.bottomEnd,
    this.readMoreIcon,
    this.readLessIcon,
    this.readMoreTextStyle,
    this.readMoreIconColor = Colors.blue,
    this.style,
    this.locale,
    this.onReadMoreClicked,
    Key? key,
  })  : assert(
          (readMoreIcon != null && readLessIcon != null) ||
              readMoreIcon == null && readLessIcon == null,
          'You need to specify both read more and read less icons ',
        ),
        super(key: key);

  /// The main text that needs to be shown.
  final String text;

  /// The number of lines before trim the text.
  final int numLines;

  /// The main text style.
  final TextStyle? style;

  /// The icon color next to read more/less text.
  final Color readMoreIconColor;

  /// The style of read more/less text.
  final TextStyle? readMoreTextStyle;

  /// The icon that needs to be shown when the text is collapsed.
  ///
  /// When you specify [readMoreIcon] you also need to specify [readLessIcon].
  final Widget? readMoreIcon;

  /// The icon that needs to be shown when the text is expanded.
  ///
  /// When you specify [readMoreIcon] you also need to specify [readLessIcon].
  final Widget? readLessIcon;

  /// The show more text.
  final String readMoreText;

  /// The show less text.
  final String readLessText;

  /// Called when clicked on read more.
  final VoidCallback? onReadMoreClicked;

  /// The alignment of the read more text and icon.
  /// default is [AlignmentDirectional.bottomEnd]
  final AlignmentGeometry readMoreAlign;

  /// The locale of the main text, that allows the widget calculate the
  /// number of lines accurately.
  ///
  /// It's optional and should be used when the passed text locale is different
  /// from the app locale.
  ///
  /// e.g: The app locale is `en` but you pass a german text.
  final Locale? locale;

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  final _defaultShowMoreStyle = const TextStyle(
    color: Color.fromRGBO(0, 122, 255, 1),
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );

  var _isTextExpanded = false;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final locale = widget.locale ?? Localizations.maybeLocaleOf(context);
          final span = TextSpan(text: widget.text);
          final tp = TextPainter(
            text: span,
            locale: locale,
            maxLines: widget.numLines,
            textDirection: Directionality.of(context),
          );
          tp.layout(maxWidth: constraints.maxWidth);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.text,
                  textAlign: TextAlign.left,
                  maxLines: _isTextExpanded ? null : widget.numLines,
                  style: widget.style,
                ),
              ),
              if (tp.didExceedMaxLines) const SizedBox(height: 8),
              if (tp.didExceedMaxLines)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: GestureDetector(
                    onTap: _onReadMoreClicked,
                    child: Align(
                      alignment: widget.readMoreAlign,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isTextExpanded
                                ? widget.readLessText
                                : widget.readMoreText,
                            style: widget.readMoreTextStyle ??
                                _defaultShowMoreStyle,
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      );

  void _onReadMoreClicked() {
    _isTextExpanded = !_isTextExpanded;
    setState(() {});
    widget.onReadMoreClicked?.call();
  }
}
