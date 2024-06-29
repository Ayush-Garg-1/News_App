import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatefulWidget {
  String? newsUrl;
  NewsDetailsScreen({this.newsUrl});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  late final WebViewController controller;
  bool isLoading=true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.newsUrl!));
    isLoading=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       isLoading ?
       Center(
         child: Container(
             width:100,
             height: 100,
             child: CircularProgressIndicator(color: Colors.orangeAccent,strokeWidth: 10,)),
       )
     : SafeArea(
       child: WebViewWidget(
            controller: controller
        ),
     )
    );
  }
}
