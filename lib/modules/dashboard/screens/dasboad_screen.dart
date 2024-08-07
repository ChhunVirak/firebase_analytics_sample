import 'dart:io';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:http/http.dart' as http;

import 'package:flutter_svg/flutter_svg.dart';

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
    return PopScope(
      // onWillPop: () async {
      //   showExitAppDialog(context);
      //   return false;
      // },
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
                  exit(0);
                  // throw Exception('This Error Message from Flutter user 13');
                  // context.read<SwitchThemeCubit>().switchTheme();
                  // Navigator.of(context).pushNamed('/payment');
                },
                child: context.watch<SwitchThemeCubit>().isDarkMode
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
                        return const SvgMenu();
                        Menu(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SvgMenu extends StatelessWidget {
  const SvgMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      '''<svg width="1600" height="1200" viewBox="0 0 1600 1200" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M1600 893C1600 925.033 1574.26 951 1542.5 951C1510.74 951 1485 925.033 1485 893" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1600 49C1560.23 49 1528 16.5405 1528 -23.5C1528 -63.5407 1560.23 -96 1600 -96" stroke="#E53855" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M562 -37.0939C562 -3.90524 588.863 23 622 23C655.137 23 682 -3.90524 682 -37.0939V-105" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M137.235 1306C62.547 1306 2 1245.79 2 1171.5C2 1097.21 62.547 1037 137.235 1037H261" stroke="#FFB017" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M128.98 1214C104.138 1214 84 1194.53 84 1170.5C84 1146.47 104.138 1127 128.98 1127H177" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1600 356V187.681C1600 154.72 1573.13 128 1540 128C1506.87 128 1480 154.72 1480 187.681V213.734" stroke="#DA774A" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M673 866.036C676.59 866.036 679.5 863.126 679.5 859.536C679.5 855.946 676.59 853.036 673 853.036V866.036ZM567.622 1028.96C571.212 1028.96 574.122 1026.05 574.122 1022.46C574.122 1018.87 571.212 1015.96 567.622 1015.96V1028.96ZM366.84 1312.5C370.43 1312.5 373.34 1309.59 373.34 1306C373.34 1302.41 370.43 1299.5 366.84 1299.5V1312.5ZM574.655 1107.05C574.655 1103.46 571.745 1100.55 568.155 1100.55C564.565 1100.55 561.655 1103.46 561.655 1107.05H574.655ZM396.262 482C396.262 478.41 393.351 475.5 389.762 475.5C386.172 475.5 383.262 478.41 383.262 482H396.262ZM666.5 773.376C666.5 776.966 669.41 779.876 673 779.876C676.59 779.876 679.5 776.966 679.5 773.376H666.5ZM673 853.036H493.563V866.036H673V853.036ZM493.563 853.036C444.778 853.036 405.169 892.385 405.169 940.996H418.169C418.169 899.63 451.892 866.036 493.563 866.036V853.036ZM405.169 940.996C405.169 989.607 444.778 1028.96 493.563 1028.96V1015.96C451.892 1015.96 418.169 982.363 418.169 940.996H405.169ZM493.563 1028.96H567.622V1015.96H493.563V1028.96ZM366.84 1299.5H356.143V1312.5H366.84V1299.5ZM356.143 1299.5C328.181 1299.5 305.5 1276.8 305.5 1248.8H292.5C292.5 1283.97 320.988 1312.5 356.143 1312.5V1299.5ZM305.5 1248.8C305.5 1220.78 328.182 1198.08 356.143 1198.08V1185.08C320.987 1185.08 292.5 1213.62 292.5 1248.8H305.5ZM356.143 1198.08H483.723V1185.08H356.143V1198.08ZM483.723 1198.08C533.95 1198.08 574.655 1157.32 574.655 1107.05H561.655C561.655 1150.15 526.756 1185.08 483.723 1185.08V1198.08ZM383.262 482V546.285H396.262V482H383.262ZM383.262 546.285C383.262 628.172 449.569 694.566 531.38 694.566V681.566C456.763 681.566 396.262 621.007 396.262 546.285H383.262ZM531.38 694.566H587.787V681.566H531.38V694.566ZM587.787 694.566C631.252 694.566 666.5 729.844 666.5 773.376H679.5C679.5 722.678 638.445 681.566 587.787 681.566V694.566Z" fill="#DA774A"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M588 327C610.091 327 628 309.091 628 287C628 264.909 610.091 247 588 247C565.909 247 548 264.909 548 287C548 309.091 565.909 327 588 327Z" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M698 1147C730.033 1147 756 1121.26 756 1089.5C756 1057.74 730.033 1032 698 1032C665.967 1032 640 1057.74 640 1089.5C640 1121.26 665.967 1147 698 1147Z" stroke="#E53855" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M184 214C218.794 214 247 185.794 247 151C247 116.206 218.794 88 184 88C149.206 88 121 116.206 121 151C121 185.794 149.206 214 184 214Z" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M184.5 288C262.095 288 325 225.992 325 149.5C325 73.0084 262.095 11 184.5 11C106.905 11 44 73.0084 44 149.5" stroke="#FFB017" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1311.21 1118.46C1289.86 1198.27 1336.04 1280.01 1414.35 1301.04C1492.65 1322.05 1573.44 1274.39 1594.79 1194.57C1616.14 1114.76 1569.96 1033.02 1491.65 1012" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M481.83 1113.5C485.42 1113.5 488.33 1110.59 488.33 1107C488.33 1103.41 485.42 1100.5 481.83 1100.5V1113.5ZM356.371 853.553C358.128 850.423 357.016 846.46 353.886 844.703C350.755 842.945 346.793 844.058 345.036 847.188L356.371 853.553ZM587 775.5C590.59 775.5 593.5 772.59 593.5 769C593.5 765.41 590.59 762.5 587 762.5V775.5ZM388.363 795.169C385.531 797.375 385.024 801.459 387.23 804.291C389.436 807.123 393.52 807.63 396.352 805.424L388.363 795.169ZM481.83 1100.5C401.007 1100.5 334.5 1028.54 334.5 938.512H321.5C321.5 1034.59 392.739 1113.5 481.83 1113.5V1100.5ZM334.5 938.512C334.5 907.319 342.516 878.227 356.371 853.553L345.036 847.188C330.093 873.799 321.5 905.082 321.5 938.512H334.5ZM587 762.5H482.203V775.5H587V762.5ZM482.203 762.5C447.131 762.5 414.712 774.642 388.363 795.169L396.352 805.424C420.566 786.561 450.208 775.5 482.203 775.5V762.5Z" fill="#DA774A"/>
<path d="M328.5 308C296.743 308 271 333.743 271 365.5C271 397.257 296.743 423 328.5 423C360.257 423 386 397.257 386 365.5V308" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M346 -28.5C346 13.7495 380.026 48 422 48C463.974 48 498 13.7495 498 -28.5C498 -70.7498 463.974 -105 422 -105H346" stroke="#E53855" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M71.5 760.582C34.7731 760.582 5 731.127 5 694.791C5 658.455 34.7731 629 71.5 629C108.227 629 138 658.455 138 694.791V896" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1461.99 764C1461.99 797.689 1488.86 825 1522 825C1555.14 825 1582 797.689 1582 764C1582 730.311 1555.14 703 1522 703H1321" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M966 33.7908C930.654 33.7908 902 62.0434 902 96.8954C902 131.747 930.654 160 966 160C1001.35 160 1030 131.747 1030 96.8954V-106" stroke="#4484AB" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M914.919 1248C914.919 1215.97 940.681 1190 972.459 1190C1004.24 1190 1030 1215.97 1030 1248C1030 1280.03 1004.24 1306 972.459 1306H881" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1089.5 456.578C1121.26 456.578 1147 482.191 1147 513.789C1147 545.386 1121.26 571 1089.5 571C1057.74 571 1032 545.386 1032 513.789V300" stroke="#DA774A" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M62.5 462.708C30.7436 462.708 5 488.069 5 519.354C5 550.639 30.7436 576 62.5 576C94.2564 576 120 550.639 120 519.354V288" stroke="#DA774A" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M688.704 288C688.704 231.115 643.327 185 587.352 185C531.377 185 486 231.115 486 288C486 344.885 531.377 391 587.352 391H853" stroke="#FFB017" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1498.64 621C1554.63 621 1600 574.885 1600 518C1600 461.115 1554.63 415 1498.64 415H1233" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1107 69.5C1107 16.2042 1149.74 -27 1202.46 -27H1300.54C1353.26 -27 1396 16.2042 1396 69.5V69.5C1396 122.796 1353.26 166 1300.54 166H1202.46C1149.74 166 1107 122.796 1107 69.5V69.5Z" stroke="#DA774A" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M266.5 765C233.639 765 207 738.406 207 705.6V536.4C207 503.594 233.639 477 266.5 477V477C299.361 477 326 503.594 326 536.4V705.6C326 738.406 299.361 765 266.5 765V765Z" stroke="#FFB017" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M828 689.5V600.166C828 574.669 848.819 554 874.5 554V554C900.181 554 921 574.669 921 600.166V778.834C921 804.331 900.181 825 874.5 825V825V825C848.819 825 828 804.331 828 778.834V757.25" stroke="#E53855" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M914 211.93V219.719C914 264.057 877.959 300 833.5 300V300C789.041 300 753 264.057 753 219.719V-24.7189C753 -69.057 789.041 -105 833.5 -105V-105C877.959 -105 914 -69.057 914 -24.7189V-22.3225" stroke="#FFB017" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M71.75 846H66.9392C32.7312 846 5 873.758 5 908V908C5 942.242 32.7311 970 66.9392 970H210.061C244.269 970 272 942.242 272 908V908C272 873.758 244.269 846 210.061 846H205.25" stroke="#FFB017" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M751 554V785.637C751 854.873 807.636 911 877.5 911C947.364 911 1004 854.873 1004 785.637V730.909" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M497 946H704.802C783.888 946 848 1010.47 848 1090C848 1169.52 783.888 1234 704.802 1234H642.288" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M586 595H536.813C503.779 595 477 568.137 477 535C477 501.863 503.779 475 536.813 475H635.187C668.221 475 695 501.863 695 535V540.33C695 570.524 670.6 595 640.5 595" stroke="#4484AB" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1089.5 366H1145.68C1183.41 366 1214 337.122 1214 301.5C1214 265.878 1183.41 237 1145.68 237H1033.32C995.587 237 965 265.878 965 301.5" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M675 97H540.319C455.091 97 386 166.396 386 252" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1449.5 1100.84C1481.26 1100.84 1507 1126.4 1507 1157.92C1507 1189.44 1481.26 1215 1449.5 1215C1417.74 1215 1392 1189.44 1392 1157.92V786" stroke="#E53855" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1019 1138C1019 1079.46 1065.85 1032 1123.63 1032H1308" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M747 475H845.373C911.441 475 965 421.274 965 355" stroke="#4484AB" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1321 788V841.755C1321 896.014 1277 940 1222.71 940H1146" stroke="#4484AB" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1507 520H1422.99C1362.24 520 1313 569.697 1313 631" stroke="#DA774A" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M218 1306V1214.88C218 1162.42 258.975 1118.47 314 1107" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M44.5 220C44.5 229.313 44.5 346.548 44.5 404" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1088.5 643C1088.5 650.693 1088.5 747.539 1088.5 795" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M934.5 1056C934.5 1059.14 934.5 1098.64 934.5 1118" stroke="#44AB96" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M1239.5 481C1239.5 477.41 1236.59 474.5 1233 474.5C1229.41 474.5 1226.5 477.41 1226.5 481H1239.5ZM1118.58 846.605C1114.99 846.605 1112.08 849.515 1112.08 853.105C1112.08 856.695 1114.99 859.605 1118.58 859.605V846.605ZM954 979.5C950.41 979.5 947.5 982.41 947.5 986C947.5 989.59 950.41 992.5 954 992.5V979.5ZM1087.46 885.938C1087.46 882.348 1084.55 879.438 1080.96 879.438C1077.37 879.438 1074.46 882.348 1074.46 885.938H1087.46ZM1226.5 481V623.331H1239.5V481H1226.5ZM1226.5 623.331C1226.5 642.086 1211.17 657.366 1192.14 657.366V670.366C1218.24 670.366 1239.5 649.366 1239.5 623.331H1226.5ZM1192.14 657.366C1166.02 657.366 1144.77 678.384 1144.77 704.417H1157.77C1157.77 685.658 1173.11 670.366 1192.14 670.366V657.366ZM1144.77 704.417V712.828H1157.77V704.417H1144.77ZM1144.77 712.828C1144.77 738.86 1166.02 759.879 1192.14 759.879V746.879C1173.11 746.879 1157.77 731.586 1157.77 712.828H1144.77ZM1192.14 759.879C1211.16 759.879 1226.5 775.171 1226.5 793.931H1239.5C1239.5 767.897 1218.25 746.879 1192.14 746.879V759.879ZM1226.5 793.931V803.242H1239.5V793.931H1226.5ZM1226.5 803.242C1226.5 827.144 1206.96 846.605 1182.75 846.605V859.605C1214.05 859.605 1239.5 834.418 1239.5 803.242H1226.5ZM1182.75 846.605H1156.72V859.605H1182.75V846.605ZM1156.72 846.605H1118.58V859.605H1156.72V846.605ZM954 992.5H980.776V979.5H954V992.5ZM980.776 992.5C1039.69 992.5 1087.46 944.798 1087.46 885.938H1074.46C1074.46 937.604 1032.52 979.5 980.776 979.5V992.5Z" fill="#FFB017"/>
<path d="M1481 283.921V304.203C1481 332.81 1457.74 356 1429.06 356V356C1400.37 356 1377.1 332.81 1377.1 304.203V287.403C1377.1 259.014 1354.02 236 1325.56 236V236C1297.08 236 1274 259.014 1274 287.403V308.079" stroke="#E53855" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1089 1179.97C1089 1139.67 1121.68 1107 1162 1107V1107C1202.31 1107 1235 1139.67 1235 1179.97V1233.03C1235 1273.33 1202.31 1306 1162 1306V1306C1121.68 1306 1089 1273.33 1089 1233.03V1179.97Z" stroke="#4484AB" stroke-width="13" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''',
      fit: BoxFit.cover,
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
