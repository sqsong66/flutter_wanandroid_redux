import 'package:flutter/material.dart';

import 'circle_ripple_widget.dart';

class SearchBar extends StatefulWidget {
  final bool showClose;
  final bool autofocus;
  final String defaultText;
  final Function(String) onSearch;
  final VoidCallback onClose;

  SearchBar({
    @required this.showClose,
    @required this.onSearch,
    @required this.autofocus,
    this.defaultText,
    this.onClose,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.text = widget.defaultText;
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  Widget _buildCloseWidget() {
    if (widget.showClose) {
      return Row(
        children: <Widget>[
          CircleRippleWidget(
            icon: Icon(Icons.close, size: 24.0),
            onClick: () {
              _textController.text = "";
              widget.onClose();
            },
          ),
          SizedBox(width: 8)
        ],
      );
    } else {
      return SizedBox(width: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: kToolbarHeight,
        color: Theme.of(context).primaryColor,
        child: Row(
          children: <Widget>[
            SizedBox(width: 8),
            CircleRippleWidget(
              icon: Icon(Icons.arrow_back, size: 24.0),
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _textController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Search"),
                autofocus: widget.autofocus,
                onSubmitted: (text) {
                  widget.onSearch(text);
                },
              ),
            ),
            SizedBox(width: 16),
            _buildCloseWidget()
          ],
        ),
      ),
    );
  }
}
