
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/auth/abstract_auth_service.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_auth_repository.dart';

class AuthRepository extends AbstractAuthRepository{

  final AbstractAuthService api;

  AuthRepository({required this.api});

  @override
  Future<Either<GeneralFailure,UserCredential?>> signInWithGoogle() async {
    try {
      final response = await api.signInWithGoogle();
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
    
  }

  @override
  Future<Either<GeneralFailure,String>> signOut() async {
    try {
      await api.signOut();
      return const Right('');
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
    
  }

}