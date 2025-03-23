import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

  List<CommentModel> comments;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.created_by,
    this.comments = const [],
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
        // comments: (json['comments'] as List<CommentModel?>)
        //     .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
        //     .toList(),
        // comments: (json['comments'] as List<dynamic>).map((e) => CommentModel(
        //   user: e['user'] as String,
        //   text: e['text'] as String,
        // )).toList(),
      );

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "image": image,
      "created_by": created_by,
      // "comments": comments.map((e) => e.toJson()).toList(),
    };
  }

  factory NewsModel.fromSnapshot(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    final data = snapshot.data!.docs[index];
    // final comments = data['comments'].map((e) => CommentModel(
    //   user: e['user'] as String,
    //   text: e['text'] as String,
    // )).toList();
    final List<CommentModel> comments = (data['comments'] as List<dynamic>).map((e) => CommentModel.fromJson(e)).toList();

    // comments.forEach((e) => {debugPrint('coment.user = ${e.user}')});
    return NewsModel(
            title: data['title'] as String,
            id: data.id,
            description: data['description'] as String,
            date: data['date'] as String,
            image: data['image'] as String,
            created_by: data['created_by'] as String,
            comments: comments,
          );
  }
}

@JsonSerializable()
class CommentModel {
  String user;
  String text;

  CommentModel({required this.user, required this.text});

  CommentModel.fromJson(Map<String, dynamic> json)
    : this(user: json['user'] as String, text: json['text'] as String);

  Map<String, dynamic> toJson() {
    return {"user": user, "text": text};
  }

}
