import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appBarWidget(title) {
  return AppBar(

    automaticallyImplyLeading: false,
    title: boldText(text: title, color: darkGrey, size: 16.0),
    actions: [
      normalText(
          text: intl.DateFormat('EEE, MMM, d, ' 'yy').format(DateTime.now()),
          color: purpleColor,
          size: 16.0),
      10.widthBox
    ],
  );
}
