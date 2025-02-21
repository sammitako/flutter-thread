import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';

class NewThreadScreen extends StatefulWidget {
  const NewThreadScreen({super.key});

  @override
  State<NewThreadScreen> createState() => _NewThreadScreenState();
}

class _NewThreadScreenState extends State<NewThreadScreen> {
  final TextEditingController _threadController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isPostEnabled = false;
  bool _showReplyBar = false;

  @override
  void initState() {
    super.initState();
    _threadController.addListener(_onTextChanged);
    _focusNode.addListener(() {
      setState(() {
        _showReplyBar = _focusNode.hasFocus;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void _onTextChanged() {
    setState(() {
      _isPostEnabled = _threadController.text.isNotEmpty;
    });
  }

  void _onCancelTap(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _threadController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.size14),
        ),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.grey.shade200,
                height: 1,
              ),
            ),
            leadingWidth: 80,
            leading: TextButton(
              onPressed: () => _onCancelTap(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: Sizes.size16),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              'New thread',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.size16,
                  right: Sizes.size16,
                  top: Sizes.size16,
                  bottom: Sizes.size80,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/12345678",
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 100,
                          margin: const EdgeInsets.symmetric(
                              vertical: Sizes.size10),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                        ),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                          child: Opacity(
                            opacity: 0.5,
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/12345678",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: Sizes.size16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'jane_mobbin',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Sizes.size16,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            TextField(
                              controller: _threadController,
                              focusNode: _focusNode,
                              cursorColor: Theme.of(context).primaryColor,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: 'Start a thread...',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: Sizes.size14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              maxLines: null,
                            ),
                            Transform.translate(
                              offset: const Offset(-32, 0),
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.paperclip,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  size: Sizes.size20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_showReplyBar)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size12,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border(
                          top: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Anyone can reply',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Sizes.size16,
                            ),
                          ),
                          TextButton(
                            onPressed: _isPostEnabled ? () {} : null,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'Post',
                              style: TextStyle(
                                color: _isPostEnabled
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade400,
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
