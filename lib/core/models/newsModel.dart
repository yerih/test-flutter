import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:json_annotation/json_annotation.dart';
// part '';//''newsModel.g.dart';

@JsonSerializable()
class NewsModel {
  String id;
  String title;
  String description;
  String date;
  String image;

  String created_by;

  // CommentModel comments;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.created_by,
    // required this.comments
  });

  NewsModel.fromJson(Map<String, Object?> json)
    : this(
        title: json['title'] as String,
        id: json['id'] as String,
        description: json['description'] as String,
        date: json['date'] as String,
        image: json['image'] as String,
        created_by: json['created_by'] as String,
      );

  factory NewsModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NewsModel(
      title: data?['title'] as String,
      id: data?['id'] as String,
      description: data?['description'] as String,
      date: data?['date'] as String,
      image: data?['image'] as String,
      created_by: data?['created_by'] as String,
    );
  }

  factory NewsModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc){
    final data = doc.data()!;
    return NewsModel(
      title: data['title'] as String,
      id: "",
      description: data['description'] as String,
      date: data['date'] as String,
      image: data['image'] as String,
      created_by: data['created_by'] as String,
    );
  }

  // factory NewsModel.fromSnapshot(QuerySnapshot<Map<String, dynamic>> doc, int index){
  //   final data = doc.docs[index].data();
  //   return NewsModel(
  //     title: data['title'] as String,
  //     id: "",
  //     description: data['description'] as String,
  //     date: data['date'] as String,
  //     image: data['image'] as String,
  //     created_by: data['created_by'] as String,
  //   );
  // }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "image": image,
      "created_by": created_by,
    };
  }

  factory NewsModel.fromSnapshot(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    final data = snapshot.data!.docs[index];
    return NewsModel(
            title: data['title'] as String,
            id: "",
            description: data['description'] as String,
            date: data['date'] as String,
            image: data['image'] as String,
            created_by: data['created_by'] as String,
          );
  }
}

@JsonSerializable()
class CommentModel {
  String user;
  String text;

  CommentModel({required this.user, required this.text});

  CommentModel.fromJson(Map<String, Object?> json)
    : this(user: json['user'] as String, text: json['text'] as String);

  Map<String, Object?> toJson() {
    return {"user": user, "text": text};
  }
}
