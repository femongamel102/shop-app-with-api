import 'package:flutter/material.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/models/categories_model.dart';
import 'package:shop_app_with_api/models/home_model.dart';
import 'package:shop_app_with_api/modules/categories/categories_screen.dart';
import 'package:shop_app_with_api/modules/favorites/favorites_screen.dart';
import 'package:shop_app_with_api/modules/products/products_screen.dart';
import 'package:shop_app_with_api/modules/settings/settings_screen.dart';
import 'package:shop_app_with_api/shared/components/components.dart';
import 'package:shop_app_with_api/shared/components/constants.dart';
import 'package:shop_app_with_api/shared/network/end_points.dart';
import 'package:shop_app_with_api/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index){
    currentIndex =index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token:token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data!.banners![0].image!);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });

  }

  CategoriesModel? categoriesModel;
  void getCategories(){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      printFullText(homeModel!.data!.banners![0].image!);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });

  }

}