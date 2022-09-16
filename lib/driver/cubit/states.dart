abstract class DriverStates {}

class DriverInitialState extends DriverStates {}

// ======================== SignUp States ========================
class SignUpLoadingState extends DriverStates {}

class SignUpSuccessState extends DriverStates {}

class SignUpErrorState extends DriverStates {
  final String error;

  SignUpErrorState(this.error);
}

// ======================== SignIn States ========================
class SignInLoadingState extends DriverStates {}

class SignInSuccessState extends DriverStates {}

class SignInErrorState extends DriverStates {
  final String error;

  SignInErrorState(this.error);
}

// ======================== SignIn States ========================
class SignOutLoadingState extends DriverStates {}

class SignOutSuccessState extends DriverStates {}

class SignOutErrorState extends DriverStates {
  final String error;

  SignOutErrorState(this.error);
}

// =================== Insert User Data States ===================
class InsertDriverDataLoadingState extends DriverStates {}

class InsertDriverDataSuccessState extends DriverStates {}

class InsertDriverDataErrorState extends DriverStates {
  final String error;

  InsertDriverDataErrorState(this.error);
}

// =================== Get Driver Data States ===================
class GetDriverDataLoadingState extends DriverStates {}

class GetDriverDataSuccessState extends DriverStates {}

class GetDriverDataErrorState extends DriverStates {
  final String error;

  GetDriverDataErrorState(this.error);
}

// =================== Picked Profile Image States ===================
class PickedProfileImageLoadingState extends DriverStates {}

class PickedProfileImageSuccessState extends DriverStates {}

class PickedProfileImageErrorState extends DriverStates {}

// =================== Upload Profile Image States ===================
class UploadProfileImageLoadingState extends DriverStates {}

class UploadProfileImageSuccessState extends DriverStates {}

class UploadProfileImageErrorState extends DriverStates {}

// =================== Set Profile Image States ===================
class SetProfileImageLoadingState extends DriverStates {}

class SetProfileImageSuccessState extends DriverStates {}

class SetProfileImageErrorState extends DriverStates {
  final String error;

  SetProfileImageErrorState(this.error);
}

class ChangeCheckBoxState extends DriverStates {}
