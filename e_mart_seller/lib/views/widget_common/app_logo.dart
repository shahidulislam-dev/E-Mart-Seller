import 'package:e_mart_seller/const/const.dart';

Widget  appLogoWidget(){
  return Image.asset(icLogo)
      .box.color(purpleColor).size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded.make();
}