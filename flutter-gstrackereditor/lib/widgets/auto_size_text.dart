import 'package:dartx/dartx.dart';
import 'package:flutter/widgets.dart';

class AutoSizeText extends StatelessWidget {
  final String data;
  final TextStyle? style;

  const AutoSizeText(this.data, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? const TextStyle(fontSize: 14);
    return LayoutBuilder(
      builder: (context, layout) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: data.split('\n').map((e) {
            return FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                _splitText(e, layout.biggest, style),
                style: style,
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _splitText(String data, Size biggest, TextStyle style) {
    Size measureText(String data, [double max = double.infinity]) {
      final text = TextPainter(
        text: TextSpan(text: data, style: style),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      text.layout(maxWidth: max);
      return text.size;
    }

    final lineHeight = measureText('0').height;

    final size = measureText(data, biggest.width);
    if (size.height <= lineHeight) {
      return data;
    }

    var ptr = 0;
    var dif = double.infinity;

    final words = data.split(' ').map((e) => (e, measureText(e))).toList();
    for (var i = 0; i < words.length; ++i) {
      final p0 = words.take(i).sumBy((e) => e.$2.width);
      final p1 = words.skip(i).sumBy((e) => e.$2.width);
      final val = (p0 - p1).abs();
      if (val > dif) break;
      dif = val;
      ptr = i;
    }

    final p0 = words.take(ptr).map((e) => e.$1).join(' ');
    final p1 = words.skip(ptr).map((e) => e.$1).join(' ');
    return '$p0\n$p1';
  }
}
