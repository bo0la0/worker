abstract class ServiceProviderStates {}

class ServiceProviderInitialState extends ServiceProviderStates {}

class ServiceProviderBottomNavBar extends ServiceProviderStates {}

// ======================== SignUp States ========================
class SignUpLoadingState extends ServiceProviderStates {}

class SignUpSuccessState extends ServiceProviderStates {}

class SignUpErrorState extends ServiceProviderStates {
  final String error;

  SignUpErrorState(this.error);
}

// ======================== SignIn States ========================
class SignInLoadingState extends ServiceProviderStates {}

class SignInSuccessState extends ServiceProviderStates {}

class SignInErrorState extends ServiceProviderStates {
  final String error;

  SignInErrorState(this.error);
}

// ======================== SignIn States ========================
class SignOutLoadingState extends ServiceProviderStates {}

class SignOutSuccessState extends ServiceProviderStates {}

class SignOutErrorState extends ServiceProviderStates {
  final String error;

  SignOutErrorState(this.error);
}

// =================== Insert Service Provider Data States ===================
class InsertServiceProviderDataLoadingState extends ServiceProviderStates {}

class InsertServiceProviderDataSuccessState extends ServiceProviderStates {}

class InsertServiceProviderDataErrorState extends ServiceProviderStates {
  final String error;

  InsertServiceProviderDataErrorState(this.error);
}

// =================== Get Service Provider Data States ===================
class GetServiceProviderDataLoadingState extends ServiceProviderStates {}

class GetServiceProviderDataSuccessState extends ServiceProviderStates {}

class GetServiceProviderDataErrorState extends ServiceProviderStates {
  final String error;

  GetServiceProviderDataErrorState(this.error);
}

// =================== Picked Profile Image States ===================
class PickedProfileImageLoadingState extends ServiceProviderStates {}

class PickedProfileImageSuccessState extends ServiceProviderStates {}

class PickedProfileImageErrorState extends ServiceProviderStates {}

// =================== Upload Profile Image States ===================
class UploadProfileImageLoadingState extends ServiceProviderStates {}

class UploadProfileImageSuccessState extends ServiceProviderStates {}

class UploadProfileImageErrorState extends ServiceProviderStates {}

// =================== Set Profile Image States ===================
class SetProfileImageLoadingState extends ServiceProviderStates {}

class SetProfileImageSuccessState extends ServiceProviderStates {}

class SetProfileImageErrorState extends ServiceProviderStates {
  final String error;

  SetProfileImageErrorState(this.error);
}

// ============= insert Product States =================
class InsertProductLoadingState extends ServiceProviderStates {}

class InsertProductSuccessState extends ServiceProviderStates {}

class InsertProductErrorState extends ServiceProviderStates {
  final String error;

  InsertProductErrorState(this.error);
}

// ============= Get Product States =================
class GetAllProductsLoadingState extends ServiceProviderStates {}

class GetAllProductsSuccessState extends ServiceProviderStates {}

class GetAllProductsErrorState extends ServiceProviderStates {
  final String error;

  GetAllProductsErrorState(this.error);
}

// ============= Update Product States =================
class UpdateProductLoadingState extends ServiceProviderStates {}

class UpdateProductSuccessState extends ServiceProviderStates {}

class UpdateProductErrorState extends ServiceProviderStates {
  final String error;

  UpdateProductErrorState(this.error);
}

// ============= Delete Product States =================
class DeleteProductLoadingState extends ServiceProviderStates {}

class DeleteProductSuccessState extends ServiceProviderStates {}

class DeleteProductErrorState extends ServiceProviderStates {
  final String error;

  DeleteProductErrorState(this.error);
}

// =================== Picked Product Image States ===================
class PickedProductImageLoadingState extends ServiceProviderStates {}

class PickedProductImageSuccessState extends ServiceProviderStates {}

class PickedProductImageErrorState extends ServiceProviderStates {}

// =================== Upload Product Image States ===================
class UploadProductImageLoadingState extends ServiceProviderStates {}

class UploadProductImageSuccessState extends ServiceProviderStates {}

class UploadProductImageErrorState extends ServiceProviderStates {}

// =================== Set Product Image States ===================
class SetProductImageLoadingState extends ServiceProviderStates {}

class SetProductImageSuccessState extends ServiceProviderStates {}

class SetProductImageErrorState extends ServiceProviderStates {
  final String error;

  SetProductImageErrorState(this.error);
}

class CloseImageSelectState extends ServiceProviderStates {}

class SelectCategoryChangeState extends ServiceProviderStates {}

class SelectProductChangeState extends ServiceProviderStates {}

// =================== Add Cart States ===================
class AddToCartLoadingState extends ServiceProviderStates {}

class AddToCartSuccessState extends ServiceProviderStates {}

class AddToCartErrorState extends ServiceProviderStates {
  final String error;

  AddToCartErrorState(this.error);
}

// =================== Add Order States ===================
class AddOrderLoadingState extends ServiceProviderStates {}

class AddOrderSuccessState extends ServiceProviderStates {}

class AddOrderErrorState extends ServiceProviderStates {
  final String error;

  AddOrderErrorState(this.error);
}

class CheckBoxChangeState extends ServiceProviderStates {}
