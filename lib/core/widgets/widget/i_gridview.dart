import '../export.dart';

enum IGridViewType { sliver, grid }

class IGridViewParam {
  final IGridViewType type;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics? physics;
  final Key? key;

  IGridViewParam({
    this.physics,
    this.type = IGridViewType.grid,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.1,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.padding = EdgeInsets.zero,
    this.key,
  });

  IGridViewParam copyWith({
    IGridViewType? type,
    int? crossAxisCount,
    double? childAspectRatio,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    EdgeInsetsGeometry? padding,
    Key? key,
  }) {
    return IGridViewParam(
      type: type ?? this.type,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      childAspectRatio: childAspectRatio ?? this.childAspectRatio,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      padding: padding ?? this.padding,
      key: key ?? this.key,
    );
  }
}

abstract class IGridView {
  Widget render(
    ITheme theme,
    IGridViewParam param, {
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
  });
}
