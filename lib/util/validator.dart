String? validateAmount(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a amount';
  }

  // Check if the input contains alphabets
  if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
    return 'Please enter a amount';
  }

  // Check if the input contains special characters
  if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Input should not contain special characters';
  }

  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a name';
  }

  // Check if the input contains special characters or numbers
  if (RegExp(r'[!@#\$%^&*(),.?":{}|<>0-9]').hasMatch(value)) {
    return 'Input should not contain special characters or numbers';
  }

  return null;
}
