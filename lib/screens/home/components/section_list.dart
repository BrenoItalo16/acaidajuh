import 'package:acaidajuh/models/home_manager.dart';
import 'package:acaidajuh/models/section.dart';
import 'package:acaidajuh/screens/home/components/add_tile_widget.dart';
import 'package:acaidajuh/screens/home/components/item_tile.dart';
import 'package:acaidajuh/screens/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);
  final Section section;
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                if (index < section.items.length)
                  return ItemTile(section.items[index]);
                else
                  return AddTileWidget();
              },
              separatorBuilder: (_, __) => const SizedBox(
                width: 4,
              ),
              itemCount: homeManager.editing
                  ? section.items.length + 1
                  : section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
