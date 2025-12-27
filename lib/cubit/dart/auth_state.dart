abstract class AuthenticationState {}

class EmailInitial extends AuthenticationState {}

class EmailSending extends AuthenticationState {}

class EmailVerified extends AuthenticationState {}

class EmailError extends AuthenticationState {
  final String message;
  EmailError(this.message);
}
