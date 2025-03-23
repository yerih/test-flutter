



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/core/models/newsModel.dart';

ValueNotifier<NewsService> newsService = ValueNotifier(NewsService());

class NewsService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late final CollectionReference _news;

  NewsService(){
    db.settings = const Settings(persistenceEnabled: true);
    db.enableNetwork();
    _news = db.collection("news").withConverter<NewsModel>(
        fromFirestore: (snapshots, _) => NewsModel.fromJson(snapshots.data()!),
        // fromFirestore: (snapshots, _) => NewsModel.fromJson(snapshots.data()!),
        toFirestore: (newsModel, _) => newsModel.toJson()
    );
  }

  Stream<QuerySnapshot> getNews() {
    return _news.snapshots();
  }

  void addNew(NewsModel newObj) async {
    _news.add(newObj);
  }
}


