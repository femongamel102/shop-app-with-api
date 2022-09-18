import 'package:shop_app_with_api/modules/login/shop_login_screen.dart';
import 'package:shop_app_with_api/shared/components/components.dart';
import 'package:shop_app_with_api/shared/network/local/chache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String? token ;