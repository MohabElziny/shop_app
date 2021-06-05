import 'package:shop_app/model/change_carts_model.dart';
import 'package:shop_app/model/change_favorites_model.dart';
import 'package:shop_app/model/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{
  final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}

// class ShopChangeCartsState extends ShopStates{}
// class ShopSuccessChangeCartsState extends ShopStates{
//   final ChangeCartsModel model;
//   ShopSuccessChangeCartsState(this.model);
// }
// class ShopErrorChangeCartsState extends ShopStates{
//   final String error;
//   ShopErrorChangeCartsState(this.error);
// }

class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{
  final String error;
  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingGetUserDataState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates{
  final LoginModel loginModel;
  ShopSuccessGetUserDataState(this.loginModel);
}
class ShopErrorGetUserDataState extends ShopStates{
  final String error;
  ShopErrorGetUserDataState(this.error);
}

class ShopLoadingUpdateUserDataState extends ShopStates{}
class ShopSuccessUpdateUserDataState extends ShopStates{
  final LoginModel loginModel;
  ShopSuccessUpdateUserDataState(this.loginModel);
}
class ShopErrorUpdateUserDataState extends ShopStates{
  final String error;
  ShopErrorUpdateUserDataState(this.error);
}