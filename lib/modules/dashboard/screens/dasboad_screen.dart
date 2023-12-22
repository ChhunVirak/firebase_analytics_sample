import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../config/theme/theme_config.dart';
import '../../../config/ui_settings.dart';
import '../../../utils/extensions/theme_extension.dart';
import '../../../utils/services/firebae/firebase_analytics_service.dart';
import '../../../utils/services/local_storage_service.dart';
import '../../../widgets/glassed_container.dart';
import '../../../widgets/menu.dart';
import '../../payment/bloc/payment_bloc.dart';
import '../../payment/screens/payment_listing_screen.dart';
import '../../photo_editor/screen/editor_home_screen.dart';
import '../../../utils/extensions/logger_extension.dart';
import '../../../config/theme/dark_theme.dart';
import '../../../utils/ui/dialogs/exit_app_dialog.dart';
import 'package:http/http.dart' as http;

const url =
    'https://digi-uat.bicbank.com.kh/qr/generate?accountNumber=100070723&currency=USD&amount=0';

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
    show();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  void show() {
    final views = ui.PlatformDispatcher.instance.views;
    views.length.log();
    for (var element in views) {
      element.display.size.log();
    }
  }

  Future<Uint8List?> getImage() async {
    final data = await http.get(Uri.parse(url));
    if (data.statusCode == 200) {
      debugPrint(data.bodyBytes.toString());
      return data.bodyBytes;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = context.getSize;
    return WillPopScope(
      onWillPop: () async {
        showExitAppDialog(context);
        return false;
      },
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        // fit: StackFit.loose,
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
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Colors.transparent,
            ),
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () async {
                  throw Exception('This Error Message from Flutter user 13');
                  // context.read<SwitchThemeCubit>().switchTheme();
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
            body: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ListView(
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
                            AnalyticsService().logScreenViewWithParam(
                              screenName: 'payment_listing_screen',
                              parameters: {
                                'screen_type': 'all_payments',
                              },
                            );

                            // throw Exception('This is sample Error');
                            Navigator.of(context).push(
                              // AppPageRoute(
                              //   page: AppRoute.routes[menu[index].routeName]!
                              //       .call(context),
                              // ),
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => PaymentBloc(),
                                  child: const PaymentListingScreen(),
                                ),
                              ),
                            );
                          },
                          onLongPressed: () {
                            // if (_animationController.isAnimating) {
                            //   _animationController.animateTo(0);
                            //   return;
                            // }
                            // _animationController.animateTo(1);
                            // _animationController.repeat(
                            //   reverse: true,
                            // );

                            // Navigator.of(context).pushNamed(menu[index].routeName);
                          },
                          text: menu[index].title,
                        );
                      },
                    ),
                  ),
                  ButtonBar(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          throw Exception(
                              'This is sample Error on Android User 02');
                        },
                        child: const Text('Error Devided by 0'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final num = int.parse('TasdasEXT');
                        },
                        child: const Text('Parse Text'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QrWidget extends StatelessWidget {
  const QrWidget({
    super.key,
    required this.size,
    required this.img,
  });

  final Size size;
  final String img;

  @override
  Widget build(BuildContext context) {
    final khQrHeight = size.width - 40;
    final khQrWidth = khQrHeight * 8 / 9;
    final qrWidth = khQrWidth * 0.8;
    return Container(
      width: size.width,
      height: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(30),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Container(
        width: khQrWidth,
        height: khQrHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.16),
              spreadRadius: 0,
              blurRadius: 21,
            ),
          ],
        ),
        // alignment: Alignment.center,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          color: const Color(0xffE1232E),
          child: Column(
            children: [
              SizedBox(
                height: khQrHeight * .12,
                // padding: const EdgeInsets.symmetric(vertical: 17),
                child: Center(
                  child: Image.network(
                    'https://donate.raksakoma.org/wp-content/themes/charityfoundation-child/img/KHQR%20Logo.png',
                    height: (khQrHeight * .12) / 3,
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  surfaceTintColor: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Image.network(
                      url,
                      fit: BoxFit.contain,
                      width: qrWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
