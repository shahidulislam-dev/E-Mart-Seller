import 'package:e_mart_seller/const/const.dart';

Widget loadingIndicator({Color color = red, double size = 50.0}) {
  return Center(
    child: SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 4.0,
      ),
    ),
  );
}