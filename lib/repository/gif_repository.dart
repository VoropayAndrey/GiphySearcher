import 'package:giphy_searcher/constants/constants.dart';
import 'package:giphy_client/giphy_client.dart';

class GifRepository {
  GiphyCollection giphyCollection;
  GiphyClient client;
  static Exception lastException;

  GifRepository() {
    try {
      client = new GiphyClient(apiKey: Constants.GIPHY_API_KEY);
    } catch(e) {
      print(e);
    }
  }

  static Future<GifRepository> search(String query) async {
    final repository = new GifRepository();
    try {
      repository.giphyCollection = await repository.client.search(query);
    } catch(e) {
      _handleException(e);
    }
    return repository;
  }

  static Future<GifRepository> getTrending() async {
    final repository = new GifRepository();
    try {
      repository.giphyCollection = await repository.client.trending();
      lastException = null;
    } catch (e) {
      _handleException(e);
    }
    return repository;
  }

  static _handleException(Exception e) {
    lastException = e;
    print(e);
  }
}