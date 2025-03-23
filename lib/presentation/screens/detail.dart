


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/models/newsModel.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.new1});

  final NewsModel new1;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {



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
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      widget.new1.created_by,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      widget.new1.date,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'Comments:',
                      style: TextStyle(fontSize: 25),
                    ),
                    CommentsList(widget.new1.comments),

                    // TextFormField(
                    //   keyboardType: TextInputType.emailAddress,
                    //   controller: passController,
                    //   textInputAction: TextInputAction.next,
                    //   decoration: InputDecoration(
                    //       labelText: 'Password',
                    //       hintText: 'Enter password',
                    //       prefixIcon: Icon(Icons.password),
                    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))
                    //   ),
                    //   onChanged: (String value) {},
                    //   validator: (value) { return value!.isEmpty ? 'Please enter password' : null;},
                    // ),

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
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        width: MediaQuery.sizeOf(context).width,
        child: ListView.builder(
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
        )
    );
  }


}

