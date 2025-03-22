
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {


  void signOut() async {
    try{
      await authService.value.signOut();
      debugPrint("Sign out success");
      Navigator.pop(context,);
    } on FirebaseAuthException catch (e){
      debugPrint("Sign out failed: ${e.message}");
    } catch (e){
      debugPrint("last catch: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            title: Text(widget.title),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                MaterialButton(
                  onPressed: signOut,
                  minWidth: double.infinity,
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  child: Text('Login'),
                ),


              ],
            ),
          ),
        )
    );

  }
}


