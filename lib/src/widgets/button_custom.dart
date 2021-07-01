import 'package:flutter/material.dart';
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final Function(BuildContext context) onClicked;
  final Color fontColor;
  final Color backgroundColor;
  final Color onClickBackgroundColor;
  final double fontSize;
  final Icon? icon;
  final double padding;

  const ButtonCustom({
    Key? key,
    required this.text,
    required this.onClicked,
    this.fontColor = Colors.white,
    this.backgroundColor = Colors.deepPurpleAccent,
    this.onClickBackgroundColor = Colors.deepPurple,
    this.fontSize = Sizes.FONT_18,
    this.icon,
    this.padding = Sizes.MARGIN_12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: this.padding)),
      ),
      onPressed: () => this.onClicked(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this.icon == null ? Container() : this.icon!,
          this.icon == null ? Container() : SizedBox(width: Sizes.MARGIN_16),
          Text(this.text, style: TextStyle(color: this.fontColor, fontSize: this.fontSize)),
        ],
      )
    );
  }
}
