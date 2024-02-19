
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/auth/abstract_auth_service.dart';

class AuthServiceImpl extends AbstractAuthService{

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  Future<UserCredential?> signInWithGoogle() async{
    try{
      
      //Open signin dialog
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleAuth = await account?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }catch( e ){
      return null;
    }
  }


  User? getUser(){
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<void> signOut()async{
    FirebaseAuth.instance.signOut();
    _googleSignIn.signOut();
  }

}