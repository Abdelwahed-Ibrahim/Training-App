import 'package:flutter/material.dart';

import '../../modules/search_screen/search_screen.dart';
import '../styles/styles.dart';
import 'components.dart';

class HashTagWidget extends StatelessWidget {
  const HashTagWidget({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            SearchScreen(searchedText: tag),
          );
        },
        child: Text(
          '#$tag',
          style: kStyleRedAccentNormal14,
        ),
      ),
    );
  }
}
