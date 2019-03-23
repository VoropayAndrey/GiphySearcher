import 'package:flutter/material.dart';
import 'package:giphy_searcher/constants/constants.dart';

class MainInheritedWidget extends InheritedWidget {
  TextEditingController searchController = new TextEditingController();
  ScrollController scrollController = new ScrollController();

  MainInheritedWidget(Widget child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static MainInheritedWidget of(BuildContext buildContext) {
    return buildContext.inheritFromWidgetOfExactType(MainInheritedWidget);
  }
}

class MainWidget extends StatefulWidget {

  @override
  State createState() => new MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {

  void searchSubmitted(String query) {
    print('query: ${query}');
  }

  Widget _buildRow(BuildContext context, int index) {
    return Text('index: ${index}');
  }

  @override
  Widget build(BuildContext context) {
      final mainInheritedWidget = MainInheritedWidget.of(context);
      return new Scaffold(
          appBar: AppBar(
              title: Text(Constants.APP_NAME)
          ),
          body: Column(
              children: [
                  Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextField(
                          onSubmitted: searchSubmitted,
                          controller: mainInheritedWidget.searchController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'SEARCH',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
                              alignLabelWithHint: true,
                          ),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                      )
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ListView.builder(
                              controller: mainInheritedWidget.scrollController,
                              padding: EdgeInsets.all(0.0),
                              itemCount: 100,
                              itemBuilder: _buildRow
                          ),
                      )
                  ),
              ]
          ),
      );
  }
}