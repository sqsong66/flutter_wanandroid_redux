import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/widget/setting_content.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with AutomaticKeepAliveClientMixin<SettingScreen> {
  double _contentMargin = 65;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate:
                SliverSettingBar(expandedHeight: 220, topPadding: topPadding),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              SettingContent(
                  contentHeight:
                      MediaQuery.of(context).size.height - topPadding)
            ]),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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

    // print(
    //     "ShrinkOffset: $shrinkOffset, kToolbarHeight: $kToolbarHeight, TopPadding: $topPadding, Percent: $percent");
    double avatarSize = minAvatarSize * percent + maxAvatarSize * (1 - percent);
    double startLeft = 16.0;

    double left =
        (screenWidth - maxAvatarSize) / 2 * (1 - percent) + startLeft * percent;
    double top = statusHeight +
        (kToolbarHeight - minAvatarSize) / 2 +
        (expandedHeight -
                maxAvatarSize / 2 -
                (statusHeight + (kToolbarHeight - minAvatarSize) / 2)) *
            (1 - percent);

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        _buildBackground(percent),
        _buildTitle(statusHeight, percent),
        _buildAvatar(left, top, avatarSize)
      ],
    );
  }

  Widget _buildBackground(double percent) {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: const Color(0x55000000),
            blurRadius: 1.0 * percent,
            offset: Offset(0.0, 0.0)),
      ]),
      child: Opacity(
        child: Image(
          image: AssetImage("assets/images/setting_background.jpg"),
          fit: BoxFit.cover,
        ),
        opacity: 1 - percent,
      ),
    );
  }

  Positioned _buildAvatar(double left, double top, double avatarSize) {
    return Positioned(
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
              image: AssetImage("assets/images/avatar.png"), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Positioned _buildTitle(double statusHeight, double percent) {
    return Positioned(
      left: 32 + minAvatarSize,
      top: statusHeight + (kToolbarHeight - minAvatarSize) / 2,
      child: Opacity(
        opacity: percent,
        child: Text(
          "SQSong",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.0 * percent,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => topPadding;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
