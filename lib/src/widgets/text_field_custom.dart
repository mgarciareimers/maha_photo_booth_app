import 'package:flutter/material.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/custom_colors.dart';
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';
import 'package:maha_photo_booth_app/src/commons/constants/strings.dart';

class TextFieldCustom extends StatefulWidget {
  final String hint;
  final Function(String value) onValueChanged;

  final bool obscureText;
  final String initialText;
  final double? width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final double borderSize;
  final Color backgroundColor;
  final Color hintColor;
  final Color textColor;
  final double fontSize;
  final double horizontalPadding;
  final bool enabled;
  final bool hasTopLeftBorderRadius;
  final bool hasTopRightBorderRadius;
  final bool hasBottomLeftBorderRadius;
  final bool hasBottomRightBorderRadius;
  final bool clearText;

  final TextEditingController? controller;

  const TextFieldCustom({
    Key? key,
    required this.hint,
    required this.onValueChanged,
    this.obscureText = false,
    this.initialText = Strings.EMPTY_STRING,
    this.width,
    this.height = Sizes.INPUT_HEIGHT,
    this.borderRadius = Sizes.BORDER_RADIUS,
    this.borderColor = CustomColors.GRAY_MEDIUM,
    this.borderSize = Sizes.INPUT_BORDER_SIZE,
    this.backgroundColor = CustomColors.GRAY_LIGHTEST,
    this.hintColor = CustomColors.GRAY,
    this.textColor = Colors.black,
    this.fontSize = Sizes.FONT_16,
    this.horizontalPadding = Sizes.MARGIN_8,
    this.enabled = true,
    this.hasTopLeftBorderRadius = true,
    this.hasTopRightBorderRadius = true,
    this.hasBottomLeftBorderRadius = true,
    this.hasBottomRightBorderRadius = true,
    this.clearText = false,
    this.controller,
  }) : super(key: key);

  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  TextEditingController? controller;

  @override
  void initState() {
    this.controller = widget.controller == null ? new TextEditingController(text: widget.initialText) : widget.controller;
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      this.controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width == null || widget.width! <= 0 ? double.infinity : widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.hasTopLeftBorderRadius ? widget.borderRadius : 0),
          topRight: Radius.circular(widget.hasTopRightBorderRadius ? widget.borderRadius : 0),
          bottomLeft: Radius.circular(widget.hasBottomLeftBorderRadius ? widget.borderRadius : 0),
          bottomRight: Radius.circular(widget.hasBottomRightBorderRadius ? widget.borderRadius : 0),
        ),
        border: Border.all(color: widget.borderColor, width: widget.borderSize),
        color: widget.backgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(color: widget.hintColor, fontSize: widget.fontSize),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: widget.height / 5, left: widget.horizontalPadding, right: widget.horizontalPadding),
              ),
              style: TextStyle(color: widget.textColor, fontSize: widget.fontSize),
              obscureText: widget.obscureText,
              onChanged: widget.onValueChanged,
              enabled: widget.enabled,
              controller: this.controller,
            ),
          ),
          widget.clearText ?
          Container(
              padding: EdgeInsets.only(right: widget.horizontalPadding),
              child: InkWell(
                  onTap: () => this._onClearButtonPressed(),
                  child: Icon(Icons.close, color: widget.borderColor)
              )
          )
              :
          Container(),
        ],
      ),
    );
  }

  // Method that is called when the user clicks the clear button.
  void _onClearButtonPressed() {
    this.controller!.clear();
    widget.onValueChanged(Strings.EMPTY_STRING);
  }
}