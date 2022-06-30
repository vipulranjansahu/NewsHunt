import 'package:flutter/material.dart';
import 'package:newshunt/helper/data.dart';
import 'package:newshunt/model/articlemodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../helper/news.dart';
import '../model/categorymodel.dart';
import 'article.dart';
import 'category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> myCategories = <CategorieModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCategories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    //categories
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: myCategories.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            imgurl: myCategories[index].imageAssetUrl,
                            categoryName: myCategories[index].categorieName,
                          );
                        },
                      ),
                    ),
                    //Articles
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

class Card extends StatelessWidget {
  final imgurl, categoryName;
  Card({this.imgurl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Category(category: categoryName.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.all(2),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                width: 120,
                height: 60,
                fit: BoxFit.cover,
                imageUrl: imgurl,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black12,
              ),
              width: 120,
              height: 60,
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
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
