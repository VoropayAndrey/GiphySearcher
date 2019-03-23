import 'package:giphy_searcher/constants/constants.dart';
import 'package:giphy_client/giphy_client.dart';

class GifRepository {
  GiphyCollection giphyCollection;
  GiphyClient client;

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
      print(e);
    }
    return repository;
  }
}