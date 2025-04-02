abstract class AuthState {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String token;
  Authenticated({required this.token});

  @override
  List<Object> get props => [token];
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

class Unauthenticated extends AuthState {}
