import 'package:intl/intl.dart';

class FormatUtil {
  static String numberFormatter(int number) {
    var nf = NumberFormat('###,###,###,###');
    return nf.format(number);
  }
}