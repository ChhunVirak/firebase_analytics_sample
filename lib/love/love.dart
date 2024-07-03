import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../main.dart';

class LoverScreen extends StatefulWidget {
  const LoverScreen({super.key});

  @override
  State<LoverScreen> createState() => _LoverScreenState();
}

class _LoverScreenState extends State<LoverScreen> {
  double scale = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF2F8),
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(padding),
        itemCount: 10,
        separatorBuilder: (context, index) => const Gap(padding),
        itemBuilder: (context, index) => const FaqWidget(),
      ),
    );
  }
}

class FaqWidget extends StatefulWidget {
  const FaqWidget({super.key});

  @override
  State<FaqWidget> createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      lowerBound: 1,
      upperBound: 2,
      vsync: this,
      duration: 200.ms,
    );
    super.initState();
  }

  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.value == 1) {
          _animationController.forward().then((value) => setState(() {}));
        } else {
          _animationController.reverse().then((value) => setState(() {}));
        }
      },
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: 200.ms,
        curve: Curves.fastOutSlowIn,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          duration: 1000.ms,
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      '1. What is BIC Mobile Banking?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, __) => Transform.rotate(
                      angle: pi * _animationController.value,
                      child: const Icon(Icons.expand_more_rounded),
                    ),
                  ),
                ],
              ),
              _animationController.value == 2
                  ? const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Answer: BIC Mobile Banking is an application platform gives you the ability to connect to your BIC Bank account. With BIC Mobile Banking you can retrieve balances, pay bills, review pending transactions, review transactions, can perform transfer funds between accounts, within banks and Other Bank, find a local branch, contact us for help and more all from your mobile device without spending your time to visiting a branch.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
