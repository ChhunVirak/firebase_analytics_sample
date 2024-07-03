// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:shorthand/shorthand.dart';
import 'job_finder_color.dart';

class BottomBar {
  final String name;
  final IconData iconData;
  const BottomBar({
    required this.name,
    required this.iconData,
  });
}

const bottomBar = [
  BottomBar(
    name: 'Home',
    iconData: Icons.home_rounded,
  ),
  BottomBar(
    name: 'Feed',
    iconData: Icons.bar_chart_rounded,
  ),
  BottomBar(
    name: 'My Jobs',
    iconData: Icons.work_rounded,
  ),
  BottomBar(
    name: 'Profile',
    iconData: Icons.person_rounded,
  ),
];

class JobFinderHomeScreen extends StatefulWidget {
  const JobFinderHomeScreen({super.key});

  @override
  State<JobFinderHomeScreen> createState() => _JobFinderHomeScreenState();
}

class _JobFinderHomeScreenState extends State<JobFinderHomeScreen> {
  int index = 0;
  int recommendIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: kTextTabBarHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Job\nFinder',
                    style: context.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 0,
                      color: jobMainColor,
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 90),
                    children: [
                      const Gap(10),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Find Your\nDream Job\nHere',
                                  style: context.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 0,
                                    color: jobMainColor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: jobYelloColor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: const Icon(
                                CupertinoIcons.search,
                                size: 30,
                                color: jobColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(40),
                      SingleChildScrollView(
                        primary: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: recommendationList
                              .asMap()
                              .entries
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      recommendIndex = e.key;
                                    });
                                  },
                                  child: RecommendCard(
                                    selected: recommendIndex == e.key,
                                    title: e.value.title,
                                    amount: e.value.value,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ).animate().slideX(
                            begin: .1,
                            end: 0,
                            duration: 200.ms,
                            curve: Curves.linear,
                          ),
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: jobs
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    color: e.color,
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${e.companyName} Need',
                                            style: context.bodySmall?.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            e.companyName,
                                            style:
                                                context.displayMedium?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '\$${e.salary} year',
                                            style:
                                                context.titleMedium?.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: context.screenWidth * .4,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor: jobColor,
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text('Apply'),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                color: Colors.white,
                                                icon: const Icon(
                                                  Icons
                                                      .bookmark_outline_rounded,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ).animate().slideY(
                            begin: .05,
                            end: 0,
                            duration: 200.ms,
                            curve: Curves.linear,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 10,
                  ),
                ],
              ),
              height: 90,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
              child: SafeArea(
                top: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: bottomBar
                      .asMap()
                      .entries
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              index = e.key;
                            });
                          },
                          child: AnimatedBottomBarItem(
                            icon: e.value.iconData,
                            selected: index == e.key,
                            title: e.value.name,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBottomBarItem extends StatelessWidget {
  const AnimatedBottomBarItem({
    super.key,
    required this.selected,
    required this.title,
    required this.icon,
  });

  final bool selected;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: AnimatedSwitcher(
        duration: 200.ms,
        child: !selected
            ? Icon(
                icon,
                size: 30,
              )
            : Column(
                children: [
                  Text(
                    title,
                    style: context.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: selected ? Colors.black : null,
                    ),
                  ),
                  const Gap(5),
                  const CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
        transitionBuilder: (child, animation) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
    );
  }
}

class RecommendCard extends StatelessWidget {
  const RecommendCard({
    super.key,
    required this.title,
    required this.amount,
    required this.selected,
  });

  final String title;
  final String amount;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 200.ms,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: selected ? jobColor : null,
        borderRadius: BorderRadius.circular(20),
        border: selected
            ? const Border.fromBorderSide(BorderSide.none)
            : Border.all(width: .1),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: selected ? Colors.white : null,
            ),
          ),
          const Gap(5),
          Text(
            amount,
            style: context.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}

class JobModel {
  final String companyName;
  final String position;
  final String salary;
  final Color color;

  JobModel({
    required this.companyName,
    required this.position,
    required this.salary,
    required this.color,
  });
}

Map<String, Color> companyColors = {
  'Twitter': Colors.blue,
  'Meta': Colors.purple,
  'Google': Colors.red,
  'BMW': Colors.green,
  'Apple': Colors.orange,
  'Amazon': Colors.yellow,
  'Microsoft': Colors.lightBlue,
  'Netflix': Colors.deepPurple,
  'SpaceX': Colors.teal,
  'Tesla': Colors.indigo,
};

List<JobModel> jobs = [
  JobModel(
    companyName: 'Twitter',
    position: 'Software Engineer',
    salary: '95K',
    color: Colors.blue,
  ),
  JobModel(
    companyName: 'Meta',
    position: 'Product Manager',
    salary: '115K',
    color: Colors.purple,
  ),
  JobModel(
    companyName: 'Google',
    position: 'Data Scientist',
    salary: '105K',
    color: Colors.red,
  ),
  JobModel(
    companyName: 'BMW',
    position: 'Mechanical Engineer',
    salary: '90K',
    color: Colors.green,
  ),
  JobModel(
    companyName: 'Apple',
    position: 'iOS Developer',
    salary: '100K',
    color: Colors.orange,
  ),
  JobModel(
    companyName: 'Amazon',
    position: 'Business Analyst',
    salary: '98K',
    color: Colors.yellow,
  ),
  JobModel(
    companyName: 'Microsoft',
    position: 'Software Architect',
    salary: '110K',
    color: Colors.lightBlue,
  ),
  JobModel(
    companyName: 'Netflix',
    position: 'UI/UX Designer',
    salary: '96K',
    color: Colors.deepPurple,
  ),
  JobModel(
    companyName: 'SpaceX',
    position: 'Aerospace Engineer',
    salary: '120K',
    color: Colors.teal,
  ),
  JobModel(
    companyName: 'Tesla',
    position: 'Electrical Engineer',
    salary: '97K',
    color: Colors.indigo,
  ),
];

class RecommendationData {
  final String title;
  final String value;

  RecommendationData({
    required this.title,
    required this.value,
  });
}

List<RecommendationData> recommendationList = [
  RecommendationData(
    title: 'Recommended Jobs',
    value: '135+',
  ),
  RecommendationData(
    title: 'Nearby Opportunities',
    value: '35+',
  ),
  RecommendationData(
    title: 'Trending Positions',
    value: '50+',
  ),
  RecommendationData(
    title: 'New Openings in Tech',
    value: '80+',
  ),
  RecommendationData(
    title: 'Hot Job Picks',
    value: '20+',
  ),
  RecommendationData(
    title: 'Different Job Roles',
    value: '95+',
  ),
  RecommendationData(
    title: 'Extra Employment Offers',
    value: '110+',
  ),
  RecommendationData(
    title: 'More Career Choices',
    value: '75+',
  ),
  RecommendationData(
    title: 'Additional Job Listings',
    value: '45+',
  ),
  RecommendationData(
    title: 'Last-Minute Job Updates',
    value: '30+',
  ),
];
