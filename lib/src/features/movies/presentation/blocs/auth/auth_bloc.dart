import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AbstractAuthRepository authService;

  AuthBloc({ required this.authService }) : super( const AuthState(authStatus: AuthStatus.unknown, user: null )) {
    on<AuthAddUser>( _onAuntAddUser );
  }

  FutureOr<void> _onAuntAddUser(AuthAddUser event, Emitter<AuthState> emit) {
    if( event.user != null ){
      emit(
        state.copyWith(
          authStatus: AuthStatus.logged,
          user: event.user
        )
      );
    }else{
      emit(
        state.copyWith(
          authStatus: AuthStatus.unknown,
          user: null
        )
      );
    }
  }

  Future<void> signIn() async {
    final data = await authService.signInWithGoogle();
    data.fold(
      (l) {
        add( const AuthAddUser( user: null ));
      }, 
      (r) {
        add( AuthAddUser( user: r?.user ));
      }
    );
  }

  Future<void> singOut() async {
    final response = await authService.signOut();
    response.fold(
      (l) {
        add( const AuthAddUser(user: null) );
      }, 
      (r) {
        add( const AuthAddUser(user: null) );
      }
    );
  }

  Future<User?> loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if( user != null ){
      add( AuthAddUser(user: user));
    }else{
      add( const AuthAddUser(user: null));
    }
    return user;
  }

}
