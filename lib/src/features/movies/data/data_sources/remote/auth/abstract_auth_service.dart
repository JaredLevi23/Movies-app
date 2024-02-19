
import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractAuthService{

  Future<UserCredential?>signInWithGoogle();
  Future<void>signOut();

}