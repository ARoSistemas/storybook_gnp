/// *************************************************************************
///
/// A utility class that provides various validation and utility functions.
///
/// The `ARoFunc` class includes methods for validating email addresses,
/// passwords, phone numbers, and other inputs. It also provides methods for
/// obtaining the current date and time in specific formats, retrieving IP
/// addresses on Android and iOS devices,
/// and mapping identifiers and color codes to icon paths.
class ARoFunc {
  /// *************************************************************************
  /// Checks if the provided email is valid.
  ///
  /// A valid email must comply with the general format of email addresses.
  ///
  /// [email] The email to check.
  /// Returns `true` if the email is valid, otherwise `false`.
  static bool isValidEmail(String email) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  /// Checks if the provided password is valid.
  ///
  /// A valid password must contain at least 8 characters, including an
  /// uppercase letter, a lowercase letter, and a number.
  ///
  /// [password] The password to check.
  /// Returns `true` if the password is valid, otherwise `false`.
  static bool isValidPassword(String password) => RegExp(
    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$',
  ).hasMatch(password);

  // return RegExp(
  // //         r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,15}$')
  // //     .hasMatch(password);

  /// Checks if the provided phone number is valid.
  ///
  /// A valid phone number must contain exactly 10 digits.
  ///
  /// [phone] The phone number to check.
  /// Returns `true` if the phone number is valid, otherwise `false`.
  bool isValidPhone({required String phone}) =>
      RegExp(r'^[0-9]{10}$').hasMatch(phone);

  /// Checks if the provided value is valid.
  ///
  /// A valid value must contain only alphanumeric characters.
  ///
  /// [value] The value to check.
  /// Returns `true` if the value is valid, otherwise `false`.
  bool isValid({required String value}) =>
      RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);

  /// Gets the current date in the format 'dd/MM/yy'.
  ///
  /// The date is obtained from the system and formatted into a string
  /// without non-alphanumeric characters.
  ///
  /// Returns a string with the current date in the format 'dd/MM/yy'.
  String getStringFecha() {
    final DateTime thisMoment = DateTime.now();
    final String hoy = thisMoment.toString().replaceAll(RegExp('([:. -])'), '');

    return '${hoy.substring(6, 8)}/${hoy.substring(4, 6)}/${hoy.substring(2, 4)}';
  }

  /// Gets the current time in the format 'HH:mm'.
  ///
  /// The time is obtained from the system and formatted into a string
  /// without non-alphanumeric characters.
  ///
  /// Returns a string with the current time in the format 'HH:mm'.
  String getStringHora() {
    final String ret = DateTime.now().toString().substring(11, 16);
    return ret;
  }

  /// Gets the current year and month in the format 'yyyyMM'.
  ///
  /// The year and month are obtained from the system and formatted into a
  /// string without non-alphanumeric characters.
  ///
  /// Returns a string with the current year and month in the format 'yyyyMM'.
  String getYearMonth() {
    final DateTime thisMoment = DateTime.now();
    final String hoy = thisMoment.toString().replaceAll(RegExp('([:. -])'), '');
    return hoy.substring(0, 6);
  }

  ///
}
