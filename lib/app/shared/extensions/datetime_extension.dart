import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat.yMMMd().format(this);
  String get formattedTime => DateFormat.jm().format(this);
}
