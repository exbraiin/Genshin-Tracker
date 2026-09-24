import 'dart:async';

Stream<T> mergeStreams<T>(Iterable<Stream<T>> streams) {
  late StreamController<T> controller;
  final subscriptions = <StreamSubscription<T>>[];

  controller = StreamController<T>(
    onListen: () {
      for (final stream in streams) {
        subscriptions.add(
          stream.listen(controller.add, onError: controller.addError),
        );
      }
    },
    onCancel: () async {
      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    },
  );

  return controller.stream;
}
