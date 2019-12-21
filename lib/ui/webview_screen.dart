import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/utils/common_utils.dart';
import 'package:flutter_wanandroid_redux/widget/circle_ripple_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String initUrl;

  WebViewScreen({@required this.title, @required this.initUrl});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool _showProgress = true;
  WebViewController _webViewController;

  _launchURL() async {
    if (await canLaunch(widget.initUrl)) {
      await launch(widget.initUrl);
    } else {
      Fluttertoast.showToast(
          msg: "No application process the url: ${widget.initUrl}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CommonUtils.removeHtmlTag(widget.title)),
        actions: <Widget>[
          SizedBox(width: 8.0),
          SizedBox(
            width: 60.0,
            height: 60.0,
            child: CircleRippleWidget(
              icon: Icon(Icons.refresh, size: 24.0),
              onClick: () {
                setState(() {
                  _showProgress = true;
                });
                _webViewController?.reload();
              },
            ),
          ),
          SizedBox(
            width: 60.0,
            height: 60.0,
            child: CircleRippleWidget(
              icon: Icon(Icons.open_in_browser, size: 24.0),
              onClick: _launchURL,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.initUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (url) {
              setState(() {
                _showProgress = false;
              });
            },
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
          ),
          _showProgress
              ? Positioned(
                  top: 20.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[RefreshProgressIndicator()],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
