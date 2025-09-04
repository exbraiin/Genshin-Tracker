import 'package:flutter/material.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/theme/gs_assets.dart';

class CharaterTalentsLabel extends StatelessWidget {
  final CharInfo info;
  final TextStyle? style;

  const CharaterTalentsLabel(this.info, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.themeStyles.label14n;
    final subStyle = TextStyle(
      fontSize: 6,
      height: 1.5,
      color: Colors.white.withValues(alpha: kDisableOpacity),
    );
    final talents = info.talents;
    if (talents == null) {
      return Text('-', style: style, strutStyle: style.toStrut());
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          CharTalentType.values
              .map((talent) {
                final value = talents.talentWithExtra(talent);
                final hasExtra = talents.hasExtra(talent);
                return Text(
                  '$value',
                  style: style.copyWith(
                    color: hasExtra ? context.themeColors.extraTalent : null,
                  ),
                  strutStyle: style.toStrut(),
                );
              })
              .separate(
                Text(
                  ' \u2022 ',
                  style: subStyle,
                  strutStyle: subStyle.toStrut(),
                ),
              )
              .toList(),
    );
  }
}
