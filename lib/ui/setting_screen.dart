import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate:
                SliverSettingBar(expandedHeight: 250, topPadding: topPadding),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                height: MediaQuery.of(context).size.height - topPadding,
                color: Colors.white,
              )
            ]),
          )
          // Container(
          //   height: MediaQuery.of(context).size.height,
          //   color: Colors.teal,
          // )
        ],
      ),
    );
  }
}

class SliverSettingBar extends SliverPersistentHeaderDelegate {
  final double topPadding;
  final double expandedHeight;

  double maxAvatarSize = 100.0;
  double minAvatarSize = 35.0;

  SliverSettingBar({this.expandedHeight, this.topPadding});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double screenWidth = MediaQuery.of(context).size.width;
    double statusHeight = MediaQuery.of(context).padding.top;
    double percent = shrinkOffset / (expandedHeight - statusHeight);
    print(
        "ShrinkOffset: $shrinkOffset, TopPadding: $topPadding, Percent: $percent");

    double avatarSize = minAvatarSize * percent + maxAvatarSize * (1 - percent);
    double startLeft = 16.0;
    double startTop = statusHeight + (kToolbarHeight - minAvatarSize) / 2;

    double left =
        (screenWidth - maxAvatarSize) / 2 * (1 - percent) + startLeft * percent;
    double top = expandedHeight - maxAvatarSize / 2 - (expandedHeight - avatarSize / 2 - startTop) * percent;

    double _getTopOffset() {
      double top = (expandedHeight - avatarSize / 2) * (1 - percent);
      if (top < startTop) {
        top = startTop;
      }
      return top;
    }

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        Image(
            image: AssetImage("assets/images/image05.jpg"), fit: BoxFit.cover),
        Positioned(
          left: left,
          top: top,
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x88000000),
                  blurRadius: 8.0,
                  spreadRadius: 0.5,
                  offset: Offset(3.0, 3.0),
                )
              ],
              image: DecorationImage(
                  image: AssetImage("assets/images/image02.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => topPadding;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
