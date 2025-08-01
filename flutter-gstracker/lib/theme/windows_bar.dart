import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tracker/theme/gs_assets.dart';

class WindowBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const WindowBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final mainColor = context.themeColors.mainColor1;
    final whiteColor = context.themeColors.almostWhite;
    final mouseDown = Color.lerp(mainColor, whiteColor, 0.1);
    final mouseOver = Color.lerp(mainColor, whiteColor, 0.2);
    final colors = WindowButtonColors(
      mouseDown: mouseDown,
      mouseOver: mouseOver,
      iconNormal: whiteColor,
    );

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: 32,
          color: context.themeColors.mainColor1,
          child: Row(
            children: [
              Expanded(
                child: MoveWindow(
                  onDoubleTap: () => setState(appWindow.maximizeOrRestore),
                  child:
                      title != null
                          ? Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              left: GsSpacing.kGridSeparator * 2,
                            ),
                            child: Text(
                              title!,
                              style: context.themeStyles.label12b,
                              strutStyle:
                                  context.themeStyles.label12b.toStrut(),
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
              ),
              if (kDebugMode)
                Container(
                  padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB71C1C),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text('DEBUG', style: context.themeStyles.label12b),
                ),
              MinimizeWindowButton(colors: colors),
              appWindow.isMaximized
                  ? RestoreWindowButton(
                    colors: colors,
                    onPressed: () => setState(appWindow.maximizeOrRestore),
                  )
                  : MaximizeWindowButton(
                    colors: colors,
                    onPressed: () => setState(appWindow.maximizeOrRestore),
                  ),
              CloseWindowButton(
                colors: WindowButtonColors(
                  mouseOver: const Color(0xFFD32F2F),
                  mouseDown: const Color(0xFFB71C1C),
                  iconNormal: whiteColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(32);
}
