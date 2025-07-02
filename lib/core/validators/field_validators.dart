class FieldValidators {
  static bool isValidCPF(String cpf) {
    final cleaned = cpf.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length != 11) return false;
    if (RegExp(r'^(\d)\1{10}$').hasMatch(cleaned)) return false;

    int calcDigit(String str, int multiplier) {
      int sum = 0;
      for (int i = 0; i < str.length; i++) {
        sum += int.parse(str[i]) * (multiplier - i);
      }
      int mod = sum % 11;
      return mod < 2 ? 0 : 11 - mod;
    }

    final d1 = calcDigit(cleaned.substring(0, 9), 10);
    final d2 = calcDigit(cleaned.substring(0, 9) + d1.toString(), 11);

    return cleaned.endsWith('$d1$d2');
  }
}
