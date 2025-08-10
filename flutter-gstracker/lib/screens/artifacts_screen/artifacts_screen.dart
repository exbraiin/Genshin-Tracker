import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/artifacts_screen/artifact_details_card.dart';
import 'package:tracker/screens/artifacts_screen/artifact_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class ArtifactsScreen extends StatelessWidget {
  static const id = 'artifacts_screen';

  const ArtifactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsArtifact>(
      icon: AppAssets.menuIconArtifacts,
      title: context.labels.artifacts(),
      versionSort: (item) => item.version,
      itemBuilder:
          (context, state) => ArtifactListItem(
            state.item,
            onTap: state.onSelect,
            selected: state.selected,
          ),
      itemCardBuilder:
          (context, item) => ArtifactDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
