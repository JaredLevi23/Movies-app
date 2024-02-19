
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pagination/src/core/network/errors/failure.dart';

abstract class AbstractAuthRepository{

  Future<Either<GeneralFailure,UserCredential?>>signInWithGoogle();
  Future<Either<GeneralFailure,String>>signOut();

}