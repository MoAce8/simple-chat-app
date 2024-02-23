String? mobileValidator(String value) {
  if (value.trim().isEmpty) {
    return 'Phone number required';
  } else if (value.length != 11) {
    return 'Enter a valid number';
  } else if (!value.startsWith('0')) {
    return 'Enter a valid number';
  }
  return null;
}

String? passwordValidator(String value) {
  RegExp limitRegex = RegExp(r'.{8,}$');

  if (value.trim().isEmpty) {
    return 'Password can\'t be empty';
  } else if (!limitRegex.hasMatch(value)) {
    return 'Password has to be at least 8 characters';
  }
  return null;
}

String? strongPasswordValidator(String value) {
  RegExp capRegex = RegExp(r'^(?=.*?[A-Z])');
  RegExp smallRegex = RegExp(r'(?=.*?[a-z])');
  RegExp numRegex = RegExp(r'(?=.*?[0-9])');
  RegExp scRegex = RegExp(r'(?=.*?[!@#$&*~])');
  RegExp limitRegex = RegExp(r'.{8,}$');

  if (value.trim().isEmpty) {
    return 'Password can\'t be empty';
  } else if (!limitRegex.hasMatch(value)) {
    return 'Password has to be at least 8 characters';
  } else {
    if (!capRegex.hasMatch(value)) {
      return 'Password must contain a capital letter';
    } else if (!smallRegex.hasMatch(value)) {
      return 'Password must contain a small letter';
    } else if (!numRegex.hasMatch(value)) {
      return 'Password must contain a number';
    } else if (!scRegex.hasMatch(value)) {
      return 'Password must contain a special character';
    }
    return null;
  }
}

String? nameValidator(String value) {
  if (value.trim().isEmpty) {
    return 'Name required';
  }
  return null;
}
String? otpValidator(String value) {
  if (value.trim().isEmpty) {
    return 'otp required';
  }
  return null;
}

String? emailValidator(String value) {
  RegExp regex = RegExp(r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

  if (value.trim().isEmpty) {
    return 'Email required';
  }

  if (!regex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? loginMailValidator(String value) {
  if (value.trim().isEmpty) {
    return 'Email required';
  }
  return null;
}

String? loginPasswordValidator(String value) {
  if (value.trim().isEmpty) {
    return 'Password required';
  }
  return null;
}

