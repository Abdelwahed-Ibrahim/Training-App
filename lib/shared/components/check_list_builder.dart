import 'package:flutter/material.dart';

import 'check_list_item.dart';
import 'expandable_item_name.dart';

class CheckListBuilder extends StatelessWidget {
  const CheckListBuilder({
    super.key,
    required this.listName,
    required this.list,
    required this.icon,
    required this.onPressed,
    required this.isExpanded,
  });

  final String listName;
  final List<String> list;
  final IconData icon;
  final void Function() onPressed;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableItemName(
          titleName: listName,
          icon: icon,
          onPressed: onPressed,
        ),
        if (isExpanded)
          for (var item in list) CheckListItem(item: item),
        if (isExpanded)
          const SizedBox(
            height: 20.0,
          ),
      ],
    );
  }
}
