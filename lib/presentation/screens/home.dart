import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/auth_service.dart';
import 'package:myapp/data/news_service.dart';

import '../../core/models/newsModel.dart';
import 'detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOut() async {
    try {
      await authService.value.signOut();
      debugPrint("Sign out success");
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      debugPrint("Sign out failed: ${e.message}");
    } catch (e) {
      debugPrint("last catch: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: signOut,
              child: Text(
                'Sign out',
                style: TextStyle(color: Colors.deepPurple, fontSize: 20),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[NewsList(),],
          ),
        ),
      ),
    );
  }

  Widget NewsList() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder<QuerySnapshot>(
        stream: newsService.value.getNews(),
        builder: (context, snapshot) {

          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          final news = snapshot.data!.docs;
          if (news.isEmpty) {
            return const Center(child: Text('There are not news'));
          }
          // news.forEach((news) => debugPrint('data firestore = ${news}'));
          debugPrint('data firestore = $news');
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              NewsModel new1 = NewsModel.fromSnapshot(snapshot, index);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 10),
                  child:
                  ListTile(
                    onTap: () { Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailScreen(new1: new1,))
                    ); },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        new1.image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                    ,
                    title: Text(new1.title),
                    subtitle: Text(new1.description),
                    // title: Text("${snapshot.data!.docs[index]["title"]}"),
                  ),
                )
              );
            },
          );
        },
      ),
    );
  }
}
