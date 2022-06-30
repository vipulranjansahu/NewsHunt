import 'package:flutter/material.dart';

import '../helper/news.dart';
import '../model/articlemodel.dart';
import 'article.dart';

class Category extends StatefulWidget {
  late final String category;
  Category({required this.category});
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews news = CategoryNews();
    await news.getNews(widget.category);
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.green, //change your color here
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "News",
              style: TextStyle(color: Colors.amber),
            ),
            Text(
              "Hunt",
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: _loading
          ? Center(
              child: Container(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Blog(
                            imgurl: articles[index].urlToImage,
                            title: articles[index].title,
                            des: articles[index].description,
                            url: articles[index].url,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class Blog extends StatelessWidget {
  final imgurl, title, des, url;

  Blog(
      {@required this.imgurl,
      @required this.title,
      @required this.des,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Article(
                      imgUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgurl),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              des,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
