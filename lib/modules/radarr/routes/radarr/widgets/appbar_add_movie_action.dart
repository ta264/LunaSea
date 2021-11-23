import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAppBarAddMoviesAction extends StatelessWidget {
  const RadarrAppBarAddMoviesAction({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.add,
      onPressed: () async => RadarrAddMovieRouter().navigateTo(
        context,
        query: '',
      ),
    );
  }
}
