import 'package:flutter/material.dart';
import 'package:giphy_searcher/constants/constants.dart';

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

class MainWidget extends StatefulWidget {

  @override
  State createState() => new MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
          appBar: AppBar(
              title: Text(Constants.APP_NAME)
          ),
          body: Text('Hey'),
      );
  }
}