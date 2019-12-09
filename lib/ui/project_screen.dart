import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wanandroid_redux/model/project_view_model.dart';
import 'package:flutter_wanandroid_redux/redux/actions/project_action.dart';
import 'package:flutter_wanandroid_redux/redux/state/app_state.dart';
import 'package:flutter_wanandroid_redux/widget/load_error_widget.dart';
import 'package:flutter_wanandroid_redux/widget/loading_view.dart';
import 'package:flutter_wanandroid_redux/widget/loading_widget.dart';
import 'package:flutter_wanandroid_redux/widget/project_appbar.dart';
import 'package:flutter_wanandroid_redux/widget/project_item_widget.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with AutomaticKeepAliveClientMixin<ProjectScreen> {
  Text _titleText(String text) {
    return Text(text,
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold));
  }

  Widget _buildAppBar(ProjectViewModel viewModel) {
    if (viewModel.currentClassifyData == null || viewModel.classifyList.isEmpty)
      return AppBar(title: _titleText("Project"));
    return PreferredSize(
      child: ProjectAppBar(
          classifyData: viewModel.currentClassifyData,
          classifyList: viewModel.classifyList,
          onClassifyDataTap: (data) {
            viewModel.onClassifyDataChanged(data);
          },),
      preferredSize: const Size.fromHeight(kToolbarHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, ProjectViewModel>(
      onInit: (store) {
        store.dispatch(requestProjectClassifyAction());
      },
      converter: (store) => ProjectViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: _buildAppBar(viewModel),
          body: ProjectItemWidget(),
        );
      },
    );
  }
// LoadingView(
//             status: viewModel.status,
//             loadingContent: LoadingWidget(),
//             errorContent: LoadErrorWidget(),
//             successContent: Container(
//               child: Text("Hello World", style: TextStyle(fontSize: 50.0)),
//             ),
//           )
  @override
  bool get wantKeepAlive => true;
}
