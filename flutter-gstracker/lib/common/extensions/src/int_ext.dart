extension IntExt on int {
  String format([String separator = ' ']) {
    final str = toString();
    final neg = str.startsWith('-');
    final src = neg ? 1 : 0;

    final buffer = StringBuffer();
    if (neg) buffer.write('-');

    final digits = str.length - src;
    var firstGroup = digits % 3;
    if (firstGroup == 0) firstGroup = 3;

    for (var i = src; i < str.length; ++i) {
      if (i > src && firstGroup == 0) {
        buffer.write(separator);
        firstGroup = 3;
      }

      buffer.write(str[i]);
      firstGroup--;
    }

    return buffer.toString();
  }

  String compact() {
    const units = ['', 'K', 'M', 'G', 'T', 'P'];
    var v = toDouble();
    var m = 0;
    while (v.abs() >= 1000) {
      m++;
      v /= 1000;
    }
    final fix = v.toStringAsFixed(1);
    return fix.endsWith('.0') ? '${v.toInt()}${units[m]}' : '$fix${units[m]}';
  }
}
