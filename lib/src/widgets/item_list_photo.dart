import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Utils.
import 'package:maha_photo_booth_app/src/commons/utils/utils.dart';

// Commons.
import 'package:maha_photo_booth_app/src/commons/constants/custom_colors.dart';
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';

// Models.
import 'package:maha_photo_booth_app/src/models/photo_model.dart';

class ItemListPhoto extends StatelessWidget {
  final int index;
  final PhotoModel photo;
  final bool isLast;
  final Function(PhotoModel photo) onItemClicked;
  final Function(int index, int id) onDeleteItemButtonClicked;

  const ItemListPhoto({
    Key? key,
    required this.index,
    required this.photo,
    required this.isLast,
    required this.onItemClicked,
    required this.onDeleteItemButtonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        Padding(
          padding: EdgeInsets.only(right: Sizes.MARGIN_16),
          child: IconSlideAction(
            closeOnTap: true,
            caption: null,
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => this.onDeleteItemButtonClicked(this.index, this.photo.id!),
          ),
        )
      ],
      child: InkWell(
        onTap: () => this.onItemClicked(this.photo),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: Sizes.MARGIN_12),
                child: Row(
                  children: [
                    this._createPhoto(context),
                    SizedBox(width: Sizes.MARGIN_16),

                    this._createContent(context),
                  ],
                )
              ),
              Container(height: 1, color: CustomColors.GRAY.withOpacity(0.2)),
            ],
          ),
        ),
      ),
    );
  }

  // Method that creates the photo.
  Widget _createPhoto(BuildContext context) {
    final double size = MediaQuery.of(context).size.width / 6;

    return Container(
      width: size,
      height: size,
      color: CustomColors.GRAY_LIGHTEST,
      child: Stack(
        children: [
          Image.memory(
            this.photo.photo!,
            height: size,
            width: size,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  // Method that creates the content.
  Widget _createContent(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.width / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.photo.name!, style: TextStyle(fontSize: Sizes.FONT_16, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
            SizedBox(height: Sizes.MARGIN_8),

            Text('${ Utils.getDateTimeString(this.photo.date!) }', style: TextStyle(fontSize: Sizes.FONT_12, color: Theme.of(context).primaryColor)),
          ],
        ),
      ),
    );
  }
}
