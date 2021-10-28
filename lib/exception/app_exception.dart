import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String? message;
  final String prefix;

  const AppException(this.message, this.prefix);

  @override
  String toString() {
    return "$prefix${message ?? '發生未預期的錯誤，請稍後重試'}";
  }

  String get errorMessage {
    if (message != null) return toString();
    return message ?? prefix + '發生未預期的錯誤，請稍後重試';
  }

  @override
  List<Object> get props => [];
}

class BadDataException extends AppException {
  const BadDataException(
    String? message,
  ) : super(
          message,
          'BadDataException: ',
        );
}
