import 'package:flutter/cupertino.dart';
import 'package:tracker/common/widgets/static/sliver_grid_fixed_size_delegate.dart';
import 'package:tracker/theme/gs_assets.dart';

class GsGridView extends StatelessWidget {
  final double childWidth;
  final double childHeight;
  final EdgeInsetsGeometry? padding;
  final SliverChildDelegate delegate;

  GsGridView({
    super.key,
    this.childWidth = 126,
    this.childHeight = 160,
    this.padding,
    required List<Widget> children,
  }) : delegate = SliverChildListDelegate(children);

  GsGridView.builder({
    super.key,
    this.childWidth = 126,
    this.childHeight = 160,
    this.padding,
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
  }) : delegate = SliverChildBuilderDelegate(
         itemBuilder,
         childCount: itemCount,
       );

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      childrenDelegate: delegate,
      padding: padding ?? GsSpacing.kListPadding,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedChildSize(
        childWidth: childWidth,
        childHeight: childHeight,
        mainAxisSpacing: GsSpacing.kGridSeparator,
        crossAxisSpacing: GsSpacing.kGridSeparator,
        alignment: CrossAxisAlignment.center,
      ),
    );
  }
}
