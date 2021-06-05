import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/change_carts_model.dart';
import 'package:shop_app/model/change_favorites_model.dart';
import 'package:shop_app/model/favorites_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/shop_layout/shop_states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites.toString());

      homeModel.data.products.forEach((element) {
        cart.addAll({element.id: element.inCart});
      });
      print(cart.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('get home data error ${error.toString()}');
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print('get categories data error ${error.toString()}');
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int id) {
    favorites[id] = !favorites[id];
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
            url: CHANGE_FAVORITES, data: {'product_id': id}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel.status) {
        favorites[id] = !favorites[id];
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[id] = !favorites[id];
      print('favorites data error ${error.toString()}');
      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }

  // ChangeCartsModel changeCartsModel;
  // void changeCarts(int id) {
  //   cart[id] = !cart[id];
  //   emit(ShopChangeCartsState());
  //
  //   DioHelper.postData(url: CARTS, data: {'product_id': id}, token: token)
  //       .then((value) {
  //     changeCartsModel = ChangeCartsModel.fromJson(value.data);
  //     print(value.data);
  //
  //     if (!changeCartsModel.status) {
  //       cart[id] = !cart[id];
  //     }
  //
  //     emit(ShopSuccessChangeCartsState(changeCartsModel));
  //   }).catchError((error) {
  //     cart[id] = !cart[id];
  //     print('carts data error ${error.toString()}');
  //     emit(ShopErrorChangeCartsState(error.toString()));
  //   });
  // }

  FavoritesModel favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print('get favorites data error ${error.toString()}');
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }

  LoginModel userModel;
  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error) {
      print('get user data error ${error.toString()}');
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  void updateUserData({
  @required String name,
  @required String email,
  @required String phone,
}) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error) {
      print('get user data error ${error.toString()}');
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }
}
