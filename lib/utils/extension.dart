extension MoneyFormat on String {
  String formatAsMoney({String currency = ""}) {
    String reversed = split('').reversed.join();
    String spaced = reversed.replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ");
    return spaced.split('').reversed.join().trim() + currency;
  }
}

extension MoneyFormatForInt on num {
  String toMoneyFormat({String currency = ""}) {
    return toInt().toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
    ) + currency;
  }
}
