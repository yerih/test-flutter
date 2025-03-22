


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {

  final userController = TextEditingController();
  final passController = TextEditingController();
  String errorMsg = '';

  void signUp() async {
    try{
      await authService.value.createAccount(email: userController.text, password: passController.text);
      debugPrint("Sign up: user = ${userController.text}, password = ${passController.text}");
      debugPrint("Sign up success");
      setState(() {errorMsg = '';});
    } on FirebaseAuthException catch (e){
      debugPrint("Sign up failed: ${e.message}. user = ${userController.text}, password = ${passController.text}");
      setState(() {errorMsg = e.message ?? 'There is an error';});
    }catch (e){
      debugPrint("last catch: $e");
    }
  }

  void signIn() async {
    try{
      await authService.value.signIn(email: userController.text, password: passController.text);
      debugPrint("Sign in: user = ${userController.text}, password = ${passController.text}");
      debugPrint("Sign in success");
      setState(() {errorMsg = '';});
      authService.value.signOut();
    } on FirebaseAuthException catch (e){
      debugPrint("Sign in failed: ${e.message}. user = ${userController.text}, password = ${passController.text}");
      setState(() {errorMsg = e.message ?? 'There is an error';});
    } catch (e){
      debugPrint("last catch: $e");
    }
  }

  @override
  void dispose() {
    passController.dispose();
    userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Login', style: TextStyle(fontSize: 40),),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: userController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onChanged: (String value) {},
                      validator: (value) { return value!.isEmpty ? 'Please enter email' : null;},
                    ),
                    SizedBox(height: 20,),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter password',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))
                      ),
                      onChanged: (String value) {},
                      validator: (value) { return value!.isEmpty ? 'Please enter password' : null;},
                    ),
                    SizedBox(height: 40,),
                    MaterialButton(
                      onPressed: signIn,
                      minWidth: double.infinity,
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      child: Text('Login'),
                    ),

                    MaterialButton(
                      onPressed: signUp,
                      minWidth: double.infinity,
                      color: Color.fromARGB(1, 103, 58, 183),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      child: Text('Sign up'),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      errorMsg,
                      style: TextStyle(color: Colors.redAccent),
                    )

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

