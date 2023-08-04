  String removetrailingZeros(String price) {
    //simple examples:
    // double num = 12.50; // 12.5
    // double num2 = 12.0; // 12
    // double num3 = 1000; // 1000

    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    price = price.replaceAll(regex, '');
    return price;
  }