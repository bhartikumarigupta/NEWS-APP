import 'package:flutter/material.dart';
import 'package:news/module/article_module.dart';

import '../helper/news.dart';
import 'article_news.dart';

// ignore: camel_case_types
class catagory extends StatefulWidget {
  final String cati;
  const catagory({super.key, required this.cati});
  @override
  State<catagory> createState() => _catagoryState();
}

// ignore: camel_case_types
class _catagoryState extends State<catagory> {
  List<article_model> articleModel = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getcatagory();
  }

  Future<void> getcatagory() async {
    CategoryNews news = CategoryNews();
    await news.getNews(widget.cati);
    articleModel = news.news.toList();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Flutter'),
            Text(
              'News',
              style: TextStyle(color: Colors.blue[400]),
            ),
          ],
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: ListView.builder(
                      itemCount: articleModel.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: articleModel[index].urltoimage,
                          title: articleModel[index].title,
                          desc: articleModel[index].description,
                          url: articleModel[index].url,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  const BlogTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => article(
              blogUrl: url,
              imageUrl: '',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.553)),
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
