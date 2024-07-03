import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:shorthand/shorthand.dart';
import 'package:showcaseview/showcaseview.dart';

class LearnAnimation extends StatefulWidget {
  const LearnAnimation({super.key});

  @override
  State<LearnAnimation> createState() => _LearnAnimationState();
}

class _LearnAnimationState extends State<LearnAnimation> {
  late OverlayState overlayState;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      overlayState = Overlay.of(context);
    });
    super.initState();
  }

  final topSafeArea =
      MediaQueryData.fromView(WidgetsBinding.instance.renderView.flutterView)
          .padding
          .top;

  void showOverLay() async {
    late final OverlayEntry overlayEntry;
    late final AnimationController animationController;

    void closeOverlay() {
      // if (!overlayEntry.mounted) return;
      animationController.animateTo(0).then(
        (value) {
          overlayEntry.remove();
        },
      );
    }

    overlayEntry = OverlayEntry(
      builder: (_) => Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            closeOverlay();
          },
          onVerticalDragUpdate: (detail) {
            animationController
                .animateTo(detail.globalPosition.dy / (80 + topSafeArea));
          },
          onVerticalDragEnd: (details) {
            if (animationController.value < 0.9) {
              closeOverlay();
            }
          },
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(top: topSafeArea),
              height: 80,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, -1),
                    color: Colors.black12,
                    spreadRadius: .5,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    size: 35,
                    color: Colors.white,
                  ),
                  const Gap(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Something went wrong!',
                        style:
                            context.titleLarge?.copyWith(color: Colors.white),
                      ),
                      Text(
                        'Make sure data is correct and try again.',
                        style:
                            context.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
            .animate(
              onInit: (controller) => animationController = controller,
            )
            .fade()
            .slideY(
              begin: -1,
              end: 0,
              duration: 200.ms,
              curve: Curves.easeInOut,
            )
            .flip()
            .shimmer(
              delay: 800.ms,
              duration: 300.ms,
            ),
      ),
    );

    overlayState.insert(overlayEntry);

    await Future.delayed(
      2000.ms,
      () {
        closeOverlay();
      },
    );
  }

  final items = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  void show() {
    int index = 0;
    late final OverlayEntry overlayEntry;
    late Offset widgetPosition;
    late Size widgetSize;
    late double right;
    late double bottom;

    void getWidgetPosition() {
      final renderBox =
          items[index].currentContext?.findRenderObject() as RenderBox;
      widgetPosition = renderBox.localToGlobal(Offset.zero);
      widgetSize = renderBox.size;
      right = context.screenWidth -
          widgetPosition.dx -
          100 -
          (widgetSize.width / 2);

      bottom = context.screenHeight - widgetPosition.dy + 20 + 10;
    }

    getWidgetPosition();

    void next() {
      if (index < items.length - 1) {
        index++;
        getWidgetPosition();
        overlayState.setState(() {});
      } else {
        overlayEntry.remove();
      }
    }

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          overlayEntry.remove();
        },
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), //background
                  BlendMode.srcOut, //require
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ///background
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Colors.white, //any color
                        backgroundBlendMode: BlendMode.dstOut, //require
                      ),
                    ),

                    ///Cut-out widget
                    AnimatedPositioned(
                      left: widgetPosition.dx - 30,
                      top: widgetPosition.dy - 30,
                      duration: 200.ms,
                      child: GestureDetector(
                        onTap: () {}, //Ignore Click able in widget area
                        child: AnimatedContainer(
                          //normal Container Widget is OK : Container()
                          margin: const EdgeInsets.all(20),
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: widgetSize.width + 20,
                          height: widgetSize.height + 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: 200.ms,
                // left: 20,
                right: right,
                bottom: bottom,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: 200.ms,
                      width: 200,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Expanded(
                            child: Text(
                              'This is Button',
                              style: context.titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              next();
                            },
                            child: Text(
                              index == items.length - 1 ? 'DONE' : 'Next',
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .slideX(begin: 1, end: 0)
                        .flipH(
                          // duration: 3000.ms,
                          begin: 1,
                          end: 0,
                        )
                        .then()
                        .shimmer(),
                    const Gap(10),
                    CachedNetworkImage(
                      imageUrl:
                          'https://cdn.asp.events/CLIENT_QMJ_Publ_D7FED80C_5056_B733_495F9E29E2AD233F/sites/Stone-Show-2023/media/_IndustryChoiceAwards/down-arrow_animated.gif',
                      width: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);
  }

  final GlobalKey _one = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Learn Animation'),
            ),
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ShowCaseWidget.of(context).startShowCase([_one]);
                      // _show();
                      // showOverLay();
                    },
                    child: const Text('Show Snack bar'),
                  ),
                  // Showcase(
                  //   key: _one,
                  //   targetPadding: const EdgeInsets.all(20),
                  //   description: 'This is Test',
                  //   child: Container(
                  //     key: items[0],
                  //     color: Colors.green,
                  //     padding: const EdgeInsets.all(20),
                  //     child: const Text('SHOW'),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ToolTipsWidget(
                        child: Container(
                          color: Colors.green,
                          padding: const EdgeInsets.all(20),
                          child: const Text('SHOW'),
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'SHOW',
                          // style: context.titleLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'SHOW',
                          // style: context.titleLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'SHOW',
                          // style: context.titleLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                      Showcase(
                        key: _one,
                        targetPadding: const EdgeInsets.all(20),
                        description: 'This is Test',
                        child: Container(
                          key: items[0],
                          color: Colors.green,
                          padding: const EdgeInsets.all(20),
                          child: const Text('SHOW'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ToolTipsWidget extends StatefulWidget {
  final Widget child;
  const ToolTipsWidget({super.key, required this.child});

  @override
  State<ToolTipsWidget> createState() => _ToolTipsWidgetState();
}

class _ToolTipsWidgetState extends State<ToolTipsWidget> {
  late OverlayState overlayState;

  final topSafeArea =
      MediaQueryData.fromView(WidgetsBinding.instance.renderView.flutterView)
          .padding
          .top;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: widget.child,
    );
  }
}
