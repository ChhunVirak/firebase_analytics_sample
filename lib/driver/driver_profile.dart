import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shorthand/shorthand.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
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
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      'My Profile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const Gap(25),
                  Center(
                    child: Text(
                      'This week',
                      style: context.bodyMedium,
                    ),
                  ),
                  Center(
                    child: Text(
                      '\$340.50',
                      style: context.displayMedium,
                    ),
                  ),
                  const Gap(25),
                  Container(
                    clipBehavior: Clip.antiAlias,
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
                    child: const Column(
                      children: [
                        MenuCard(
                          title: 'Earning Detail',
                          description: 'Earning this week',
                        ),
                        Divider(
                          height: 0,
                          thickness: .2,
                          color: Color(0xff566269),
                        ),
                        MenuCard(
                          title: 'Recent Transaction',
                          description: '\$45.90',
                        ),
                        Divider(
                          height: 0,
                          thickness: .2,
                          color: Color(0xff566269),
                        ),
                        MenuCard(
                          title: 'Promotions',
                          description: 'See What\'s Available',
                        ),
                      ],
                    ),
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
                const Icon(
                  Icons.access_alarms_rounded,
                  size: 45,
                  color: Colors.white,
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Silent Mode',
                        style: context.displaySmall?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Your notification is silent.',
                        style: context.bodyMedium?.copyWith(
                          color: Colors.white,
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
                        color: Colors.black,
                      );
                    }

                    return const Icon(
                      Icons.close,
                      color: Color(0xffE8A05A),
                    );
                  }),
                  trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    return const Color(0xFFDB7C2E);
                  }),
                  // trackColor: MaterialStateProperty.resolveWith<Color?>(
                  //     (Set<MaterialState> states) {
                  //   return const Color(0xfffb8320);
                  // }),

                  inactiveTrackColor: const Color(0xFFDB7C2E),
                  activeTrackColor: const Color(0xFFDB7C2E),

                  thumbColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.white;
                  }),
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
                child: const Text('Cash Out'),
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
  const MenuCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [],
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
                  style: context.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff566269),
                  ),
                ),
                Text(
                  description,
                  style: context.bodyLarge?.copyWith(
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
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
