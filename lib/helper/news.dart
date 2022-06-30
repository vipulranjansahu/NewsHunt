import 'dart:convert';
import 'package:newshunt/secret.dart';
import 'package:newshunt/model/articlemodel.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=australian-financial-review&apiKey=$apiKey");
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources?category=$category&apiKey=$apiKey");
    var response = await http.get(url);
    print(response);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
