import 'dart:io';

import 'package:acaidajuh/models/section.dart';
import 'package:acaidajuh/models/section_item.dart';
import 'package:acaidajuh/screens/edit_product.dart/components/image_source_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTileWidget extends StatelessWidget {
  // const AddTileWidget(this.section);
  // final Section section;
  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();
    void onImageSelected(File file) {
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          if (Platform.isAndroid) {
            showModalBottomSheet(
              context: context,
              builder: (context) =>
                  ImageSourceSheet(onImageSelected: onImageSelected),
            );
          } else {
            showCupertinoModalPopup(
              context: context,
              builder: (context) =>
                  ImageSourceSheet(onImageSelected: onImageSelected),
            );
          }
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
