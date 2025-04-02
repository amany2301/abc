abstract class AuthEvent {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}
