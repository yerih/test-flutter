


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
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Form(
                child: Column(
                  children: [
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
}