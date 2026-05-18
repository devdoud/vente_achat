import 'package:achat_vente/export.dart';

class AndroidAppBar extends IAppBar {
  @override
  Widget render(
    ITheme theme,
    IAppBarType type, {
    List<Widget>? actions,
    Widget? title,
    bool? forceElevated,
    double? elevation,
    bool? implyLeading,
  }) {
    final titleWidget = Hero(
      tag: "logo",
      child:
          title ??
          Builder(
            builder:
                (context) => GestureDetector(
                  child: const SvgOrPicture(
                    link: "assets/img/logo-3.png",
                  ).sized(
                    Size(
                      AppBar().preferredSize.height * 2.1,
                      AppBar().preferredSize.height,
                    ),
                  ),
                  onTap: () {
                    if (context.router.canPop()) context.router.maybePop();
                  },
                ),
          ),
    );

    if (type == IAppBarType.sliver) {
      return SliverAppBar(
        toolbarHeight: AppBar().preferredSize.height * 1.2,
        clipBehavior: Clip.hardEdge,
        snap: true,
        stretch: true,
        floating: true,
        pinned: true,
        elevation: elevation,
        forceElevated: forceElevated ?? false,
        automaticallyImplyLeading: implyLeading ?? true,
        actions: actions,
        title: titleWidget,
      );
    }

    return AppBar(
      toolbarHeight: AppBar().preferredSize.height * 1.2,
      clipBehavior: Clip.hardEdge,
      actions: actions,
      elevation: elevation,
      automaticallyImplyLeading: implyLeading ?? true,
      title: titleWidget,
    );
  }
}
