import 'dart:async';

Stream<T> mergeStreams<T>(Iterable<Stream<T>> streams) {
  late StreamController<T> ctrl;
  List<StreamSubscription<T>>? subs;
  ctrl = StreamController<T>(
    onListen: () => subs = streams
        .map((e) => e.listen(ctrl.add, onError: ctrl.addError))
        .toList(),
    onCancel: () => subs?.map((e) => e.cancel()).wait,
  );
  return ctrl.stream;
}
