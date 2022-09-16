abstract class TourGuideStates {}

class TourGuideInitialState extends TourGuideStates {}

// ======================== SignUp States ========================
class SignUpLoadingState extends TourGuideStates {}

class SignUpSuccessState extends TourGuideStates {}

class SignUpErrorState extends TourGuideStates {
  final String error;

  SignUpErrorState(this.error);
}

// ======================== SignIn States ========================
class SignInLoadingState extends TourGuideStates {}

class SignInSuccessState extends TourGuideStates {}

class SignInErrorState extends TourGuideStates {
  final String error;

  SignInErrorState(this.error);
}

// ======================== SignIn States ========================
class SignOutLoadingState extends TourGuideStates {}

class SignOutSuccessState extends TourGuideStates {}

class SignOutErrorState extends TourGuideStates {
  final String error;

  SignOutErrorState(this.error);
}

// =================== Insert Tour Guide Data States ===================
class InsertTourGuideDataLoadingState extends TourGuideStates {}

class InsertTourGuideDataSuccessState extends TourGuideStates {}

class InsertTourGuideDataErrorState extends TourGuideStates {
  final String error;

  InsertTourGuideDataErrorState(this.error);
}

// =================== Get Tour Guide Data States ===================
class GetTourGuideDataLoadingState extends TourGuideStates {}

class GetTourGuideDataSuccessState extends TourGuideStates {}

class GetTourGuideDataErrorState extends TourGuideStates {
  final String error;

  GetTourGuideDataErrorState(this.error);
}

// =================== Picked Profile Image States ===================
class PickedProfileImageLoadingState extends TourGuideStates {}

class PickedProfileImageSuccessState extends TourGuideStates {}

class PickedProfileImageErrorState extends TourGuideStates {}

// =================== Upload Profile Image States ===================
class UploadProfileImageLoadingState extends TourGuideStates {}

class UploadProfileImageSuccessState extends TourGuideStates {}

class UploadProfileImageErrorState extends TourGuideStates {}

// =================== Set Profile Image States ===================
class SetProfileImageLoadingState extends TourGuideStates {}

class SetProfileImageSuccessState extends TourGuideStates {}

class SetProfileImageErrorState extends TourGuideStates {
  final String error;

  SetProfileImageErrorState(this.error);
}

// =================== Update Attend Tourist States ===================
class UpdateAttendTouristLoadingState extends TourGuideStates {}

class UpdateAttendTouristSuccessState extends TourGuideStates {}

class UpdateAttendTouristErrorState extends TourGuideStates {
  final String error;

  UpdateAttendTouristErrorState(this.error);
}

class ChangeCheckBoxState extends TourGuideStates {}
