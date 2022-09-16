abstract class ManagerStates {}

class ManagerInitialState extends ManagerStates {}

class ManagerBottomNavChangeState extends ManagerStates {}

// ============= insert Trip States =================
class InsertTripLoadingState extends ManagerStates {}

class InsertTripSuccessState extends ManagerStates {}

class InsertTripErrorState extends ManagerStates {
  final String error;

  InsertTripErrorState(this.error);
}

// ============= Get Trip States =================
class GetTripLoadingState extends ManagerStates {}

class GetTripSuccessState extends ManagerStates {}

class GetTripErrorState extends ManagerStates {
  final String error;

  GetTripErrorState(this.error);
}

// ============= Update Trip States =================
class UpdateTripLoadingState extends ManagerStates {}

class UpdateTripSuccessState extends ManagerStates {}

class UpdateTripErrorState extends ManagerStates {
  final String error;

  UpdateTripErrorState(this.error);
}

// ============= Delete Trip States =================
class DeleteTripLoadingState extends ManagerStates {}

class DeleteTripSuccessState extends ManagerStates {}

class DeleteTripErrorState extends ManagerStates {
  final String error;

  DeleteTripErrorState(this.error);
}

// =================== Picked Trip Image States ===================
class PickedTripImageLoadingState extends ManagerStates {}

class PickedTripImageSuccessState extends ManagerStates {}

class PickedTripImageErrorState extends ManagerStates {}

// =================== Upload Trip Image States ===================
class UploadTripImageLoadingState extends ManagerStates {}

class UploadTripImageSuccessState extends ManagerStates {}

class UploadTripImageErrorState extends ManagerStates {}

// =================== Set Trip Image States ===================
class SetTripImageLoadingState extends ManagerStates {}

class SetTripImageSuccessState extends ManagerStates {}

class SetTripImageErrorState extends ManagerStates {
  final String error;

  SetTripImageErrorState(this.error);
}

class CloseImageState extends ManagerStates {}

class SelectDriverNameState extends ManagerStates {}

class SelectTourGuideNameState extends ManagerStates {}

class SelectCityChangeState extends ManagerStates {}
