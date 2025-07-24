extension StringBufferExt on StringBuffer {
  void writeGenHeader() {
    this
      ..writeln('// ############################################')
      ..writeln('// ## GENERATED CODE - DO NOT MODIFY BY HAND ##')
      ..writeln('// ############################################')
      ..writeln();
  }
}

String normalizePath(String path) {
  return path.replaceAll('\\', '/');
}
