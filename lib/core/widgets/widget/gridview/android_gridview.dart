import 'package:achat_vente/export.dart';

class AndroidGridview implements IGridView {
  @override
  Widget render(
    ITheme theme,
    IGridViewParam param, {
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
  }) {
    if (param.type == IGridViewType.sliver) {
      if (itemCount == null || itemCount == 0) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return Builder(
        builder:
            (context) => SliverPadding(
              padding: param.padding,
              sliver: SliverGrid.count(
                key: param.key,
                crossAxisCount: param.crossAxisCount,
                childAspectRatio: param.childAspectRatio,
                crossAxisSpacing: param.crossAxisSpacing,
                mainAxisSpacing: param.mainAxisSpacing,
                children: List.generate(
                  itemCount,
                  (index) => itemBuilder(context, index),
                ),
              ),
            ),
      );
    }

    if (itemCount == null || itemCount == 0) {
      return const SizedBox.shrink();
    }

    return Builder(
      builder:
          (context) => GridView.count(
            key: param.key,
            padding: param.padding,
            physics: param.physics,
            shrinkWrap: param.physics is NeverScrollableScrollPhysics,
            crossAxisCount: param.crossAxisCount,
            childAspectRatio: param.childAspectRatio,
            crossAxisSpacing: param.crossAxisSpacing,
            mainAxisSpacing: param.mainAxisSpacing,
            children: List.generate(
              itemCount,
              (index) => itemBuilder(context, index),
            ),
          ),
    );
  }
}
