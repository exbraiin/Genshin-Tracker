import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

abstract final class Network {
  static Future<T?> _download<T>(
    String url,
    Future<T> Function(HttpClientResponse value) transform,
  ) {
    late final none = Future.value(null);
    final client = HttpClient();

    return client
        .getUrl(Uri.parse(url))
        .then((value) => value.close())
        .then((v) => v.statusCode == HttpStatus.ok ? transform(v) : none)
        .catchError((error) => null)
        .whenComplete(client.close);
  }

  static Future<String?> downloadString(String url) {
    return _download<String>(
      url,
      (value) => value.transform(utf8.decoder).join(),
    );
  }

  static Future<Uint8List?> downloadBytes(String url) {
    return _download<Uint8List>(
      url,
      (value) => value
          .toList()
          .then((value) => value.expand((list) => list).toList())
          .then((value) => Uint8List.fromList(value)),
    );
  }
}
