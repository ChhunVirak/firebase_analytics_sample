import 'package:flutter/material.dart';

import '../../../modules/register/screens/set_pin_code_screen.dart';

Future<bool> showPinCode(BuildContext context) async {
  final success = await Navigator.of(context).push<bool>(
    PageRouteBuilder(
      pageBuilder: (_, animation, secondAnimation) => FadeTransition(
        opacity: animation,
        child: const PinCodeDialog(
          pin: '1111',
        ),
      ),
    ),
  );
  // final success = await showDialog<bool>(
  //   barrierDismissible: false,
  //   context: context,
  //   useSafeArea: false,
  //   useRootNavigator: true,
  //   builder: (context) => const ,
  // );
  return success ?? false;
}
