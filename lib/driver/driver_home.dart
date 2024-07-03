import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shorthand/shorthand.dart';

import 'driver_profile.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  bool button = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8A05A),
      body: Column(
        children: [
          Hero(
            tag: 'BG',
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Color(0XFFF3F3F2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      'My Menu',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const Gap(25),
                  MenuCard(
                    title: '\$340.50',
                    description: 'Earning this week',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DriverProfile(),
                        ),
                      );
                    },
                  ),
                  const Gap(25),
                  MenuCard(
                    title: 'Profile',
                    description: 'Earning this week',
                    onTap: () {},
                  ),
                  const Gap(25),
                  MenuCard(
                    title: 'Account',
                    description: 'Earning this week',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Silent Mode',
                        style: context.displaySmall?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: const Color(0xff566269),
                        ),
                      ),
                      Text(
                        'Your notification is silent.',
                        style: context.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Icon(
                        Icons.done,
                        color: Colors.red,
                      );
                    }

                    return const Icon(
                      Icons.close,
                      color: Colors.red,
                    );

                    // All other states will use the default thumbIcon.
                  }),
                  activeTrackColor: Colors.red,
                  value: button,
                  onChanged: (value) {
                    setState(() {
                      button = value;
                    });
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {},
                child: const Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String description;
  final GestureTapCallback onTap;
  const MenuCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.black12,
            blurRadius: 12,
            spreadRadius: .1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.displaySmall?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff566269),
                  ),
                ),
                Text(
                  description,
                  style: context.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 3,
              shadowColor: Colors.black,
            ),
            onPressed: onTap,
            icon: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
