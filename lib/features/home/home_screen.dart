import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/features/home/widget/thread_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  static const String routeURL = "/";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
              floating: true,
              snap: false,
              pinned: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              title: SvgPicture.asset(
                'assets/app_logo.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  BlendMode.srcIn,
                ),
              )),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    ThreadItem(index: index),
                    if (index != 19) // Don't add divider after the last item
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade200,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
