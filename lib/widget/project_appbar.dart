import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';
import 'package:flutter_wanandroid_redux/route/project_selector_popup.dart';

class ProjectAppBar extends StatefulWidget {
  final ProjectClassifyData classifyData;
  final List<ProjectClassifyData> classifyList;
  final Function(ProjectClassifyData) onClassifyDataTap;

  ProjectAppBar(
      {@required this.classifyData,
      @required this.classifyList,
      @required this.onClassifyDataTap});

  @override
  _ProjectAppBarState createState() => _ProjectAppBarState();
}

class _ProjectAppBarState extends State<ProjectAppBar> {
  bool isMenuOpen = false;

  void _toggleProjectPop() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      _setMenuOpenFlag(false);
    } else {
      _setMenuOpenFlag(true);
      await Navigator.push(
          context,
          ProjectSelectorPopup(
              classifyData: widget.classifyData,
              classifyList: widget.classifyList,
              onClassifyDataTap: (data) {
                widget.onClassifyDataTap(data);
                Navigator.pop(context);
              }));
      _setMenuOpenFlag(false);
    }
  }

  void _setMenuOpenFlag(bool isOpen) {
    setState(() {
      isMenuOpen = isOpen;
    });
  }

  Widget _buildAppBarTitle() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _toggleProjectPop,
        child: Container(
          height: kToolbarHeight,
          color: isMenuOpen ? Colors.black12 : Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.classifyData.name?.replaceAll("&amp;", "&"), style: TextStyle(fontSize: 20.0)),
              Icon(isMenuOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _buildAppBarTitle(),
    );
  }
}
