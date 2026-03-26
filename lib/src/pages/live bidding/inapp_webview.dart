import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';

class WebViewScreen extends StatefulWidget {
  final String urls;

  const WebViewScreen({super.key, required this.urls});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;

  Future<bool> _onBackPressed() async {
    // Navigate to another page
    Get.offAll(() => DashboardView());
    return false; // prevent default pop
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "InApp WebView",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _onBackPressed(),
          ),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.urls)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStart: (controller, url) {
            debugPrint("Started loading: $url");
          },
          onLoadStop: (controller, url) async {
            debugPrint("Finished loading: $url");
          },
        ),
      ),
    );
  }
}