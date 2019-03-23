import 'package:flutter/material.dart';
import 'package:giphy_searcher/constants/constants.dart';
import 'package:giphy_searcher/repository/gif_repository.dart';
import 'package:giphy_searcher/ui/gif_image.dart';

class MainInheritedWidget extends InheritedWidget {

  GifRepository gifRepository;
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
    final mainInheritedWidget = MainInheritedWidget.of(context);

    GifRepository.search(query).then((repository) {
      setState(() {
        mainInheritedWidget.gifRepository = repository;
        print('query: ${query}');
      });
    });


  }


  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
        final mainInheritedWidget = MainInheritedWidget.of(context);
        GifRepository.getTrending().then((repository) {
            setState(() {
                mainInheritedWidget.gifRepository = repository;
            });
        });
    });
    super.initState();
  }

  Widget _buildRow(BuildContext context, int index) {
    final mainInheritedWidget = MainInheritedWidget.of(context);
    //return Text('index: ${index} url: ${mainInheritedWidget.gifRepository.giphyCollection.data[index].images.original}');
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
            GifImage(mainInheritedWidget.gifRepository.giphyCollection.data[index].images.original.url,
            double.tryParse(mainInheritedWidget.gifRepository.giphyCollection.data[index].images.original.width),
            double.tryParse( mainInheritedWidget.gifRepository.giphyCollection.data[index].images.original.height))
        ]);
  }

  @override
  Widget build(BuildContext context) {
      final mainInheritedWidget = MainInheritedWidget.of(context);

      var itemCount = 0;
      if(mainInheritedWidget.gifRepository != null) {
        itemCount = mainInheritedWidget.gifRepository.giphyCollection.data.length;
      }

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
                              itemCount: itemCount,
                              itemBuilder: _buildRow
                          ),
                      )
                  ),
              ]
          ),
      );
  }
}