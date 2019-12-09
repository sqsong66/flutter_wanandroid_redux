import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/data/project_classify_bean.dart';

class ProjectListWidget extends StatefulWidget {
  final ProjectClassifyData classifyData;
  final List<ProjectClassifyData> classifyList;
  final Function(ProjectClassifyData) onClassifyDataTap;

  ProjectListWidget(
      {@required this.classifyData,
      @required this.classifyList,
      @required this.onClassifyDataTap});

  @override
  _ProjectListWidgetState createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: widget.classifyList.length,
        itemBuilder: (BuildContext context, int index) {
          final data = widget.classifyList[index];
          final isSelected = data.id == widget.classifyData.id;
          final backgroundColor =
              isSelected ? Colors.black54 : Colors.transparent;
          final foregroundColor =
              isSelected ? Colors.white : Colors.white.withOpacity(0.56);
          return Material(
            color: backgroundColor,
            child: ListTile(
              onTap: (){
                widget.onClassifyDataTap(data);
              },
              title: Text(
                data.name?.replaceAll("&amp;", "&"),
                style: TextStyle(fontSize: 16.0, color: foregroundColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
