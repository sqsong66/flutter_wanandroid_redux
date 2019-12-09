import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';
import 'package:flutter_wanandroid_redux/widget/project_list_widget.dart';

class ProjectSelectorPopup extends PopupRoute {
  final ProjectClassifyData classifyData;
  final List<ProjectClassifyData> classifyList;
  final Function(ProjectClassifyData) onClassifyDataTap;

  ProjectSelectorPopup(
      {@required this.classifyData,
      @required this.classifyList,
      @required this.onClassifyDataTap});

  final opacityTween = Tween(begin: 0.0, end: 1.0);
  final positionTween = Tween(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  );

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => kThemeAnimationDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    final curve = CurvedAnimation(
      parent: animation,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.decelerate,
    );

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRect(
        child: FadeTransition(
          opacity: opacityTween.animate(curve),
          child: SlideTransition(
            position: positionTween.animate(curve),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Container(
      color: Theme.of(context).cardColor,
      child: ProjectListWidget(
        classifyData: this.classifyData,
        classifyList: this.classifyList,
        onClassifyDataTap: onClassifyDataTap,
      ),
    );
  }
}
