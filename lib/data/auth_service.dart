

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword({ required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername({ required String username}) async {
    await currentUser!.updateDisplayName(username);
  }

  Future<void> resetPassFromCurrentPass({
    required String currentPass,
    required String newPass,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPass);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPass);
  }
}
