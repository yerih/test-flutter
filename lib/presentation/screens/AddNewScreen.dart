import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/models/newsModel.dart';
import 'package:myapp/data/news_service.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  final titleCtrl = TextEditingController();
  final userCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  void sendNew() {
    final NewsModel new1 = NewsModel(
      title: titleCtrl.text,
      id: '',
      description: descCtrl.text,
      date: DateTime.now().toString(),
      image: 'https://i.pinimg.com/1200x/9e/98/7e/9e987e303b9701fd75cee6dc8183e8da.jpg',
      created_by: userCtrl.text,
    );
    newsService.value.addNew(new1);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Add new'),
      ),
      body: SingleChildScrollView(
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
                    Text('Add a new:', style: TextStyle(fontSize: 15)),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: userCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'your name',
                        prefixIcon: Icon(Icons.text_snippet),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: titleCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Title of the news',
                        hintText: 'title here',
                        prefixIcon: Icon(Icons.text_snippet),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: descCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(50),
                        labelText: 'Description',
                        hintText: 'Tell us',
                        prefixIcon: Icon(Icons.text_snippet),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: sendNew,
                      minWidth: double.infinity,
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text('Send'),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
