import 'package:flutter/material.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';

class ProgressBar extends StatelessWidget {
  final String text;
  final Color color;

  const ProgressBar({
    Key? key,
    required this.text,
    this.color = Colors.black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(Sizes.MARGIN_16 * 2),
          padding: EdgeInsets.all(Sizes.MARGIN_16 + Sizes.MARGIN_8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizes.BORDER_RADIUS),
          ),
          child: Row(
            children: [
              CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(this.color)),
              SizedBox(width: Sizes.MARGIN_16 + Sizes.MARGIN_8),
              Expanded(child: Text(this.text, style: TextStyle(fontSize: Sizes.FONT_16, color: Colors.black, fontWeight: FontWeight.normal))),
            ],
          )
        ),
      ),
    );
  }
}