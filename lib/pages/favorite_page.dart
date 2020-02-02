import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:community_material_icon/community_material_icon.dart';

import '../models/app_state.dart';
import '../screens/main_screen.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MainScreen(
        body: Center(
          child: Text("favorite"),
        ),
      ),
    );
  }
}
