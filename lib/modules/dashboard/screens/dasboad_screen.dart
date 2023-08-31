// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:learn_bloc/config/routes/routes.dart';
import 'package:learn_bloc/config/theme/theme_config.dart';
import 'package:learn_bloc/config/ui_settings.dart';
import 'package:learn_bloc/utils/extensions/theme_extension.dart';
import 'package:learn_bloc/utils/services/asset_manager/network_asset_manager.dart';

import 'package:learn_bloc/utils/services/local_storage_service.dart';
import 'package:learn_bloc/widgets/glassed_container.dart';

import '../../../config/theme/dark_theme.dart';
import '../../../utils/ui/animations/router/push_animation_pageroute.dart';
import '../../../utils/ui/dialogs/exit_app_dialog.dart';
import '../../../widgets/menu.dart';

const menu = <MenuModel>[
  MenuModel(
    title: 'User',
    routeName: '/user',
  ),
  MenuModel(
    title: 'Cards',
    routeName: '/card',
  ),
  MenuModel(
    title: 'Transfers',
    routeName: '/transfer',
  ),
  MenuModel(
    title: 'Payments',
    routeName: '/payment',
  ),
];

class MenuModel {
  final String title;
  final String routeName;
  const MenuModel({
    required this.title,
    required this.routeName,
  });
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  final imgUtil = NetworkAssetManager();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        showExitAppDialog(context);
        return false;
      },
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        // alignment: Alignment.center,
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: ImageFiltered(
              imageFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.difference,
              ),
              enabled: false,
              child: CachedNetworkImage(
                imageUrl:
                    'https://img.freepik.com/free-photo/outdoors-blue-new-downtown-building_1112-963.jpg?w=2000',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('BIC Mobile'),
              backgroundColor: Colors.transparent,
            ),
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () async {
                  // final image = await imgUtil.saveImage(
                  //   imageUrl:
                  //       'https://cdn-icons-png.flaticon.com/512/2830/2830155.png',
                  //   imageName: 'bank.png',
                  // );
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(SnackBar(content: Text(image)));
                  context.read<SwitchThemeCubit>().switchTheme();
                },
                child: context.watch<SwitchThemeCubit>().state == darkTheme
                    ? const Icon(
                        Icons.light_mode_rounded,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.dark_mode_rounded,
                      ),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                GlassMorphism(
                  child: Container(
                    width: double.infinity,
                    margin: defaultPaddingValue,
                    padding: defaultPaddingValue,
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: innerBorderRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning! ${LocalSorageService().getString('user')}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'ID > ${LocalSorageService().getString('id')}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd()
                              .format(DateTime.now())
                              .toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GlassMorphism(
                  child: GridView.builder(
                    padding: defaultPaddingValue,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: gridSpacing,
                      mainAxisSpacing: gridSpacing,
                    ),
                    itemCount: menu.length,
                    itemBuilder: (_, index) {
                      return Menu(
                        animationController: _animationController,
                        onTap: () {
                          if (_animationController.value != 0) {
                            _animationController.animateTo(0);
                            return;
                          }
                          Navigator.of(context).push(
                            AppPageRoute(
                              page: AppRoute.routes[menu[index].routeName]!
                                  .call(context),
                            ),
                          );
                        },
                        onLongPressed: () {
                          if (_animationController.isAnimating) {
                            _animationController.animateTo(0);
                            return;
                          }
                          _animationController.animateTo(1);
                          _animationController.repeat(
                            reverse: true,
                          );

                          // Navigator.of(context).pushNamed(menu[index].routeName);
                        },
                        text: menu[index].title,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class Colored extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final random = v.SimplexNoise();
//     const frames = 90;
//     canvas.drawPaint(Paint()..color = Colors.black87);

//     for (double i = 10; i < frames; i += .1) {
//       canvas.translate(i % .3, i % .6);
//       canvas.save();
//       canvas.rotate(pi / i * 25);

//       final area = Offset(i, i) & Size(i * 10, i * 10);

//       // Blue trail is made of rectangle
//       canvas.drawRect(
//         area,
//         Paint()
//           ..filterQuality =
//               FilterQuality.high // Change this to lower render time
//           ..blendMode =
//               BlendMode.screen // Remove this to see the natural drawing shape
//           ..color =
//               // Addition of Opacity gives you the fading effect from dark to light
//               Colors.blue.withRed(i.toInt() * 20 % 11).withOpacity(i / 850),
//       );

//       // Tail particles effect

//       // Change this to add more fibers
//       final int tailFibers = (i * 1.5).toInt();

//       for (double d = 0; d < area.width; d += tailFibers) {
//         for (double e = 0; e < area.height; e += tailFibers) {
//           final n = random.noise2D(d, e);
//           final tail = exp(i / 50) - 5;
//           final tailWidth = .2 + (i * .11 * n);
//           canvas.drawCircle(
//             Offset(d, e),
//             tailWidth,
//             Paint()
//               ..color = Colors.red.withOpacity(.4)
//               ..isAntiAlias = true // Change this to lower render time
//               // Particles accelerate as they fall so we change the blur size for movement effect
//               ..imageFilter = ImageFilter.blur(sigmaX: tail, sigmaY: 0)
//               ..filterQuality =
//                   FilterQuality.high // Change this to lower render time
//               ..blendMode = BlendMode.screen,
//           ); // Remove this to see the natural drawing shape
//         }
//       }
//       canvas.restore();
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }


/*
class BackgroundWidget extends StatefulWidget {
  final Widget child;
  const BackgroundWidget({super.key, required this.child});

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener((status) {});
    _controller.dispose();

    super.dispose();
  }

  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: BackgroundPainter(
                  _animation,
                ),
                child: Container(),
              );
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Animation<double> animation;

  BackgroundPainter(this.animation);
  Offset getOffset(Path path) {
    final pms = path.computeMetrics(forceClosed: false).elementAt(0);
    final length = pms.length;
    final offset = pms.getTangentForOffset(length * animation.value)!.position;
    return offset;
  }

  // Offset getOffset(Path path) {
  //   final pms = path.computeMetrics(forceClosed: false).elementAt(0);
  //   final length = pms.length;
  //   final offset = pms.getTangentForOffset(length * animation.value)!.position;
  //   return offset;
  // }

  void drawSquare(Canvas canvas, Size size) {
    final paint1 = Paint();
    paint1.color = Colors.blue.shade300;
    paint1.maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    paint1.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.75, 100),
          width: 300,
          height: 300,
        ),
        const Radius.circular(20),
      ),
      paint1,
    );
  }

  void drawEllipse(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.stroke;
    path.moveTo(size.width * 0.4, -100);
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.6,
      size.width * 1.2,
      size.height * 0.4,
    );
    // canvas.drawPath(path, paint);

    paint.style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: getOffset(path),
        width: 450,
        height: 250,
      ),
      paint,
    );
  }

  void drawTriangle(Canvas canvas, Size size, paint) {
    paint.color = Colors.green;
    final path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;
    path.moveTo(-100.0, size.height * 0.5);
    path.quadraticBezierTo(
      300,
      size.height * 0.7,
      size.width,
      size.height * 1.2,
    );
    // canvas.drawPath(path, paint);
    paint.style = PaintingStyle.fill;

    // draw triangle
    final offset = getOffset(path);
    canvas.drawPath(
      Path()
        ..moveTo(offset.dx, offset.dy)
        ..lineTo(offset.dx + 450, offset.dy + 150)
        ..lineTo(offset.dx + 250, offset.dy - 500)
        ..close(),
      paint,
    );
  }

  void drawCircle(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.orange;
    Path path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;
    path.moveTo(size.width * 1.1, size.height / 4);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 1.0,
      -100,
      size.height / 4,
    );
    // canvas.drawPath((path), paint);
    paint.style = PaintingStyle.fill;
    final offset = getOffset(path);
    canvas.drawCircle(offset, 150, paint);
  }

  void drawAbstractShapes(Canvas canvas, Size size) {
    Path path = Path();
    final paint = Paint();
    path.moveTo(size.width * 1.2, 0);
    path.quadraticBezierTo(
      size.width * 1.2,
      300,
      size.width * 0.4,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.7,
      -100,
      size.height * 1.2,
    );
    path.lineTo(-50, -50);
    path.close();
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint
        ..color = Colors.purple.shade200
        ..style = PaintingStyle.fill,
    );
    // canvas.drawPath(
    //   path,
    //   paint
    //     ..color = Colors.purple.shade200
    //     ..style = PaintingStyle.fill,
    // );
    drawSquare(canvas, size);
  }

  void drawContrastingBlobs(Canvas canvas, Size size, Paint paint) {
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    paint.blendMode = BlendMode.overlay;
    drawCircle(canvas, size, paint);
    drawTriangle(canvas, size, paint);
    drawEllipse(canvas, size, paint);
  }

  void paintBackground(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width,
        height: size.height,
      ),
      Paint()..color = Colors.black,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // paintBackground(canvas, size);
    drawAbstractShapes(canvas, size);
    final paint = Paint();
    drawContrastingBlobs(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
*/