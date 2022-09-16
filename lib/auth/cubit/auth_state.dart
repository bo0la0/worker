abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

// ======================== SignIn States ========================
class SignInLoadingState extends AuthStates {}

class SignInSuccessState extends AuthStates {}

class SignInErrorState extends AuthStates {
  final String error;

  SignInErrorState(this.error);
}
