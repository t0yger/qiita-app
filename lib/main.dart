import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: '記事一覧'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [];

  Future<void> getArticles() async {
    var url =
        Uri.https('qiita.com', 'api/v2/items', {'page': '1', 'per_page': '20'});
    var response = await http.get(url);

    setState(() {
      items = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        items[index]['user']['profile_image_url'])),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            items[index]['title'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            items[index]['tags']
                                .map((tag) => tag['name'])
                                .join(','),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.grey),
                          )),
                      const SizedBox(height: 8),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            items[index]['body'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
    );
  }
}
