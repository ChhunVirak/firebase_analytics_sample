import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void showMaintenance(BuildContext context) {
  late final AnimationController animationController;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/568/568297.png',
                  width: 30,
                ),
                const SizedBox(height: 10),
                const Text(
                  'We will be back soon!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    // height: -1,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Sorry for the inconvenience but we\'re performing some maintenance at the moment.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Material(
                  child: InkWell(
                    onTap: () {
                      animationController.duration = 200.ms;
                      animationController.reverse().then(
                            (value) => Navigator.pop(_),
                          );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Ink(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue,
                            Colors.indigo,
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Ok',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ).animate(
            onInit: (controller) {
              animationController = controller;
            },
          ).scale(
            begin: const Offset(0, 0),
            end: const Offset(1, 1),
            duration: 200.ms,
            // curve: Curves.linear,
          ),
        ),
      ),
    ),
  );
}
