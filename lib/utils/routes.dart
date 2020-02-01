import 'package:flutter/widgets.dart';

import '../screens/details_screen.dart';
import '../screens/home_screen.dart';
import 'routes_path.dart';

final routes = <String, WidgetBuilder>{
  RoutesPach.home: (BuildContext context) => HomeScreen(),
  RoutesPach.details: (BuildContext context) => DetailsScreen(),
};
