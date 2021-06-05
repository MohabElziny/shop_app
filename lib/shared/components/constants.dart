import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';

String token = '';

void LogOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) navigateAndFinish(context, LoginScreen());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}