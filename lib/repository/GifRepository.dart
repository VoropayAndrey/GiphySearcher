import 'package:giphy_searcher/constants/Constants.dart';
import 'package:giphy_client/giphy_client.dart';
import 'package:http/http.dart';
import 'dart:typed_data';

class GifRepository {
  GiphyCollection giphyCollection;
  GiphyClient client;
  static Exception lastException;
  static Map<String, Uint8List> cache = new Map();

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
      lastException = null;
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

  static Future<Uint8List> loadImage(String url) async {
    if(cache.containsKey(url)) {
        return cache[url];
    } else {
        try {
            final response = await get(url, headers: {'accept': 'image/*'});
            if (response.statusCode == 200) {
                cache.putIfAbsent(url, () => response.bodyBytes);
                return response.bodyBytes;
            } else {

            }
        } catch (e) {
          print(e);
        }
    }
    return null;
  }

  static _handleException(Exception e) {
    lastException = e;
    print(e);
  }
}