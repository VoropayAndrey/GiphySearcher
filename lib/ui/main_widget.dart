import 'package:flutter/material.dart';

class MainInheritedWidget extends InheritedWidget {
  TextEditingController searchController = new TextEditingController();
  ScrollController scrollController = new ScrollController();

  MainInheritedWidget(Widget child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {

  }

  static MainInheritedWidget of(BuildContext buildContext) {
    return buildContext.inheritFromWidgetOfExactType(MainInheritedWidget);
  }
}