import 'package:flutter/material.dart';
import 'package:giphy_searcher/constants/Constants.dart';
import 'package:giphy_searcher/repository/GifRepository.dart';
import 'package:giphy_searcher/ui/GifImage.dart';
import 'dart:math';
import 'package:share/share.dart';
import 'package:giphy_searcher/utils/ColorUtils.dart';

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
    Future.delayed(Duration(seconds: 4), () {
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
    return  GestureDetector(
        onTap: () {
            // Tap to share gif
            Share.plainText(
                title: "From GiphySearche Appr",
                text: mainInheritedWidget.gifRepository.giphyCollection.data[index].images.original.url).share();
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: ColorUtils.getRandomColor(alpha: 0x0F),

            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                    GifImage(mainInheritedWidget.gifRepository.giphyCollection.data[index].images.original.url,
                    double.tryParse(mainInheritedWidget.gifRepository.giphyCollection.data[index].images.original.width),
                    double.tryParse( mainInheritedWidget.gifRepository.giphyCollection.data[index].images.original.height))
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
      final mainInheritedWidget = MainInheritedWidget.of(context);

      String errorMessage = "";
      var itemCount = 0;

      if(mainInheritedWidget.gifRepository != null && mainInheritedWidget.gifRepository.giphyCollection != null) {
        itemCount = mainInheritedWidget.gifRepository.giphyCollection.data.length;
        if(itemCount == 0) {
          if(mainInheritedWidget.gifRepository.giphyCollection.meta.status != 200) {
            errorMessage = mainInheritedWidget.gifRepository.giphyCollection.meta.status.toString() +
                " " +
                mainInheritedWidget.gifRepository.giphyCollection.meta.msg;
          } else {
            errorMessage = "Nothing found";
          }
        }
      } else if(GifRepository.lastException != null) {
        errorMessage = GifRepository.lastException.toString();
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
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)
                              ),
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
                  Visibility(
                    child: Text(errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    visible: errorMessage.length > 0,
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ListView.builder(
                              key: new Key(Random().nextInt(0xFFFFFFFF).toString()),
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