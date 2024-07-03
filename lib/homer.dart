import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class StretchController extends GetxController {
  bool stretched = false;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Color? backgroundColors;

  static const kExpandedHeight = 250.0;

  final _cont = Get.put(StretchController());

  double offset = 0.0;
  String image =
      'https://emdiya.github.io/potfolio/assets/my_photo-b5cd2ac9.jpeg';

  bool visible = true;
  bool isScrolled = false;

  final topSafeArea =
      MediaQueryData.fromView(WidgetsBinding.instance.renderView.flutterView)
          .padding
          .top;

  final stretched = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: NestedScrollView(
            headerSliverBuilder: (_, __) => <Widget>[
              SliverAppBar(
                leadingWidth: 10,
                elevation: 0,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                floating: false,
                pinned: true,
                expandedHeight: kExpandedHeight,
                centerTitle: false,
                onStretchTrigger: () async {},
                flexibleSpace: Flexer(
                  onStrech: (value) {
                    _cont.stretched = value == 1;

                    if (value == 1 && _cont.stretched == true) {
                      Future.delayed(50.ms, () {
                        _cont.update(['HEAD']);
                      });
                    }

                    if (value != 1 && _cont.stretched == false)
                      Future.delayed(50.ms, () {
                        _cont.update(['HEAD']);
                      });
                    {}
                  },
                  title: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        image,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            body: Column(
              children: <Widget>[
                GetBuilder(
                  id: 'HEAD',
                  init: _cont,
                  builder: (_) => Header(_cont.stretched),
                ),
                Expanded(
                  child: ListView.separated(
                    primary: true,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) => Material(
                      type: MaterialType.transparency,
                      child: ListTile(
                        tileColor: Colors.white,
                        title: Text('Hello ${index + 1}'),
                      ),
                    ),
                    separatorBuilder: (context, index) => const Gap(5),
                    itemCount: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.991, -0.253),
            end: const Alignment(-1.8, 0.6),
            colors: <Color>[
              const Color(0xffac065f),
              const Color(0xff791162),
              const Color(0xce49004b).withOpacity(.95),
            ],
            stops: const <double>[0, 0.316, 1],
            tileMode: TileMode.mirror,
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  Header(this.swapToLeading, {super.key});
  final bool swapToLeading;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: AnimatedContainer(
        duration: 200.ms,
        height: _height,
        alignment: Alignment.center, // Customize as needed
        child: AnimatedSwitcher(
          duration: 50.ms,
          transitionBuilder: (child, animation) => SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(-.1, -.3), end: Offset.zero)
                    .animate(animation),
            child: child,
          ),
          child: swapToLeading
              ? const SizedBox.shrink()
              : const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Chhoeung Chhun Virak',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Flutter Developer',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  final topSafeArea =
      MediaQueryData.fromView(WidgetsBinding.instance.renderView.flutterView)
          .padding
          .top;

  double get _height => kTextTabBarHeight + topSafeArea;
}

class Flexer extends StatefulWidget {
  final Widget title;
  final ValueChanged<double> onStrech;
  const Flexer({super.key, required this.title, required this.onStrech});

  @override
  State<Flexer> createState() => _FlexerState();
}

class _FlexerState extends State<Flexer> {
  Alignment _getTitleAlignment(bool effectiveCenterTitle) {
    if (effectiveCenterTitle) {
      return Alignment.bottomCenter;
    }
    final TextDirection textDirection = Directionality.of(context);
    switch (textDirection) {
      case TextDirection.rtl:
        return Alignment.bottomRight;
      case TextDirection.ltr:
        return Alignment.bottomLeft;
    }
  }

  bool _getEffectiveCenterTitle(ThemeData theme) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final FlexibleSpaceBarSettings settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;

        final List<Widget> children = <Widget>[];

        final double deltaExtent = settings.maxExtent - settings.minExtent;

        // 0.0 -> Expanded
        // 1.0 -> Collapsed to toolbar
        final double t = clampDouble(
          1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent,
          0.0,
          1.0,
        );

        widget.onStrech.call(t);

        // title
        final ThemeData theme = Theme.of(context);

        Widget? title;
        switch (theme.platform) {
          case TargetPlatform.iOS:
          case TargetPlatform.macOS:
            title = widget.title;
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
          case TargetPlatform.linux:
          case TargetPlatform.windows:
            title = Semantics(
              namesRoute: true,
              child: widget.title,
            );
        }

        final double opacity = settings.toolbarOpacity;
        if (opacity > 0.0) {
          TextStyle titleStyle = theme.primaryTextTheme.titleLarge!;
          titleStyle = titleStyle.copyWith(
            color: titleStyle.color!.withOpacity(opacity),
          );
          final bool effectiveCenterTitle = _getEffectiveCenterTitle(theme);
          final EdgeInsetsGeometry padding = EdgeInsetsDirectional.only(
            start: effectiveCenterTitle ? 0.0 : 72.0,
            bottom: 16.0,
          );
          final double scaleValue =
              Tween<double>(begin: 4, end: 1.0).transform(t);

          final Matrix4 scaleTransform = Matrix4.identity()
            ..scale(scaleValue, scaleValue, 1.0);

          final Alignment titleAlignment =
              _getTitleAlignment(effectiveCenterTitle);

          children.add(
            Container(
              padding: padding,
              child: Transform(
                alignment: titleAlignment,
                transform: scaleTransform,
                child: Align(
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: titleStyle,
                    child: LayoutBuilder(
                      builder: (_, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth / scaleValue,
                          alignment: Alignment(
                            clampDouble(-t, -.9, 0),
                            1,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              title ?? const SizedBox.shrink(),
                              if (t == 1)
                                const Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Chhoeung Chhun Virak',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'View Profile',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return ClipRect(child: Stack(children: children));
      },
    );
  }
}

class FlexibleSpaceHeaderOpacity extends SingleChildRenderObjectWidget {
  const FlexibleSpaceHeaderOpacity({
    required this.opacity,
    required super.child,
    required this.alwaysIncludeSemantics,
  });

  final double opacity;
  final bool alwaysIncludeSemantics;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderFlexibleSpaceHeaderOpacity(
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderFlexibleSpaceHeaderOpacity renderObject,
  ) {
    renderObject
      ..alwaysIncludeSemantics = alwaysIncludeSemantics
      ..opacity = opacity;
  }
}

class RenderFlexibleSpaceHeaderOpacity extends RenderOpacity {
  RenderFlexibleSpaceHeaderOpacity({
    super.opacity,
    super.alwaysIncludeSemantics,
  });

  @override
  bool get isRepaintBoundary => false;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }
    if (opacity == 0) {
      layer = null;
      return;
    }
    assert(needsCompositing);
    layer = context.pushOpacity(
      offset,
      (opacity * 255).round(),
      super.paint,
      oldLayer: layer as OpacityLayer?,
    );
    assert(() {
      layer!.debugCreator = debugCreator;
      return true;
    }());
  }
}
