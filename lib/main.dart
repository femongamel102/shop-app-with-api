import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app_with_api/layout/shop_app/shop_layout.dart';
import 'package:shop_app_with_api/modules/login/shop_login_screen.dart';
import 'package:shop_app_with_api/shared/bloc_observer.dart';
import 'package:shop_app_with_api/shared/components/constants.dart';
import 'package:shop_app_with_api/shared/network/local/chache_helper.dart';
import 'package:shop_app_with_api/shared/network/remote/dio_helper.dart';
import 'package:shop_app_with_api/shared/styles/themes.dart';

import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token').toString();
  print(token);
  if (onBoarding != null) {
    if (token != 'false') {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
