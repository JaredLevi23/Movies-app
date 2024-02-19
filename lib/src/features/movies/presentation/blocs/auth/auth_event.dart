part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAddUser extends AuthEvent{
  final User? user;
  
  const AuthAddUser({required this.user});
}

class LoadCurrentUser extends AuthEvent{}
