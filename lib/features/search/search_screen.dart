import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "search";
  static const String routeURL = "/search";

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final faker = Faker();
  final List<bool> _isFollowing = List.generate(20, (index) => false);
  final List<String> usernames =
      List.generate(20, (index) => Faker().internet.userName());
  final List<String> companies =
      List.generate(20, (index) => Faker().company.name());
  final List<String> followers = List.generate(20,
      (index) => (Faker().randomGenerator.decimal() * 100).toStringAsFixed(1));
  final List<String> profileImages = List.generate(
      20, (index) => Faker().image.image(keywords: ['person'], random: true));

  List<int> _filteredIndices = List.generate(20, (index) => index);

  void _onSearchChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _filteredIndices = List.generate(20, (index) => index);
      } else {
        _filteredIndices = List.generate(20, (index) => index).where((i) {
          final username = usernames[i].toLowerCase();
          final company = companies[i].toLowerCase();
          final query = value.toLowerCase();
          return username.contains(query) || company.contains(query);
        }).toList();
      }
    });
  }

  void _onFollowTap(int index) {
    setState(() {
      _isFollowing[index] = !_isFollowing[index];
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 12,
            ),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              placeholder: "Search",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredIndices.length,
        itemBuilder: (context, i) {
          final index = _filteredIndices[i];
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(profileImages[index]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  usernames[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                Gaps.h5,
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.certificate,
                                      color: Colors.blue,
                                      size: 15,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.check,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Colors.white,
                                      size: 8,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              companies[index],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Gaps.v12,
                            Text(
                              '${followers[index]}K followers',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 32,
                      constraints: BoxConstraints(),
                      child: TextButton(
                        onPressed: () => _onFollowTap(index),
                        style: TextButton.styleFrom(
                          foregroundColor: _isFollowing[index]
                              ? Colors.grey
                              : (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black
                                  : Colors.white),
                          backgroundColor: _isFollowing[index]
                              ? Theme.of(context).scaffoldBackgroundColor
                              : (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _isFollowing[index] ? 'Following' : 'Follow',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _isFollowing[index]
                                ? Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade600
                                : (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (i < _filteredIndices.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade200,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        },
      ),
    );
  }
}
