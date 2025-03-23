


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/models/extensions.dart';
import 'package:myapp/core/models/newsModel.dart';
import 'package:myapp/data/news_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.new1});

  final NewsModel new1;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {



  void sendComment(CommentModel comment) async {
    try{
      // debugPrint("SendComment: user = ${comment.user}, comment = ${comment.text}");
      widget.new1.comments.add(comment);
      newsService.value.updateNews(widget.new1);
      debugPrint("SendComment: success");
    } on FirebaseAuthException catch (e){
      debugPrint("SendComment: ${e.message}");
    }catch (e){
      debugPrint("SendComment: last catch: $e");
    }
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.new1.title),
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.new1.image,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      widget.new1.description,
                      style: TextStyle(fontSize: 35),
                    ),
                    Text(
                      'published by: ${widget.new1.created_by}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget.new1.date.formatDateTime(),
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Comments:',
                      style: TextStyle(fontSize: 20),
                    ),
                    CommentsList(widget.new1.comments),
                    CommentForm(sendComment),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CommentsList(List<CommentModel> comments) {
    return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            debugPrint(comment.user);
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 10),
                  child:
                  ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CircleAvatar()
                    )
                    ,
                    title: Text(comment.user),
                    subtitle: Text(comment.text),
                    // title: Text("${snapshot.data!.docs[index]["title"]}"),
                  ),
                )
            );
          },
        );
  }

  Widget CommentForm(void Function(CommentModel) onSendComment) {
    final userController = TextEditingController();
    final commentController = TextEditingController();

    return Form(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
                'Add comment:',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: userController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'your name',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: commentController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: 'Comment',
                    hintText: 'your comment',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))
                ),
              ),


            MaterialButton(
              onPressed: () => onSendComment(CommentModel(user: userController.text, text: commentController.text)),
              minWidth: double.infinity,
              color: Colors.deepPurple,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

}

