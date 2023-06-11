import 'package:timeago/timeago.dart';

class CustomEnMessage implements LookupMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'now';
  @override String aboutAMinute(int minutes) => '${minutes}m';
  @override String minutes(int minutes) => '${minutes}m';
  @override String aboutAnHour(int minutes) => '${minutes}m';
  @override String hours(int hours) => '${hours}h';
  @override String aDay(int hours) => '${hours}h';
  @override String days(int days) => '${days}d';
  @override String aboutAMonth(int days) => '${days}d';
  @override String months(int months) => '${months}mo';
  @override String aboutAYear(int year) => '${year}y';
  @override String years(int years) => '${years}y';
  @override String wordSeparator() => ' ';
}




class CustomArMessage implements LookupMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'الان';
  @override String aboutAMinute(int minutes) => '${minutes}د';
  @override String minutes(int minutes) => '${minutes}د';
  @override String aboutAnHour(int minutes) => '${minutes}د';
  @override String hours(int hours) => '${hours}س';
  @override String aDay(int hours) => '${hours}س';
  @override String days(int days) => '${days}ي';
  @override String aboutAMonth(int days) => '${days}ي';
  @override String months(int months) => '${months}ش';
  @override String aboutAYear(int year) => '${year}ع';
  @override String years(int years) => '${years}ع';
  @override String wordSeparator() => ' ';
}
