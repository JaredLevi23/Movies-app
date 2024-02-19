part of 'auth_bloc.dart';

enum AuthStatus { 
  logged,
  unknown,
  loading
}

class AuthState extends Equatable {

  final AuthStatus authStatus;
  final User? user;

  const AuthState({
    required this.authStatus,
    required this.user
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus, 
    user: user
  );
  
  @override
  List<Object?> get props => [
    authStatus,
    user
  ];
}
