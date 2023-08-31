import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PinCodeDialog extends StatefulWidget {
  final String? pin;
  final ValueChanged<String>? onCompleted;
  const PinCodeDialog({
    super.key,
    required this.pin,
    this.onCompleted,
  }) : assert(pin?.length == 4);

  @override
  State<PinCodeDialog> createState() => _PinCodeDialogState();
}

class _PinCodeDialogState extends State<PinCodeDialog> {
  String input = '';

  void reset() {
    input = '';
  }

  void onBack() {
    Navigator.of(context, rootNavigator: true).pop<bool>(widget.pin == input);
  }

  void add(String value) {
    if (input.length == 4 || value.isEmpty) {
      return;
    }
    if (value == 'C') {
      reset();
      setState(() {});
      return;
    }
    if (value == 'B') {
      input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
      setState(() {});
      return;
    }
    setState(() {
      input += value;
      debugPrint('Success $input');
      validator();
    });
  }

  void validator() async {
    if (input.length == 4 && input != widget.pin) {
      animateError().then((value) {
        reset();
        setState(() {});
      });
      // await Future.delayed(const Duration(milliseconds: 500), () {

      // });
    } else if (input == widget.pin) {
      onBack();
    }
  }

  final pins = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'C', '0', 'B'];

  late AnimationController _animationController;

  Future<void> animateError() async {
    if (_animationController.value == 0) {
      await _animationController.forward();
    }
    {
      await _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              onBack();
            },
            icon: const Icon(Icons.close_rounded),
          ),
        ),
        body: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsets.only(right: index == 3 ? 0 : 10),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: input.length > index
                        ? Colors.indigo[900]
                        : Colors.indigo[200],
                  ),
                ),
              ),
            )
                .animate(
                  onInit: (controller) {
                    _animationController = controller;
                  },
                  autoPlay: false,
                )
                .shakeX(),
            // const SizedBox(height: 30),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: pins
                  .map(
                    (e) => e.isEmpty
                        ? const SizedBox.shrink()
                        : PinKey(
                            label: e,
                            onTap: add,
                          ),
                  )
                  .toList(),
            ).animate().slideY(
                  begin: 1,
                  end: 0,
                  duration: 200.ms,
                  curve: Curves.fastOutSlowIn,
                ),
          ],
        ),
      ),
    );
  }
}

class PinKey extends StatelessWidget {
  final String label;
  final ValueChanged<String>? onTap;
  const PinKey({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call(label);
      },
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.indigo[900],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
