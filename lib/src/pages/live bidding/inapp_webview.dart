import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  final String urls;

  const WebViewScreen({super.key, required this.urls});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("InApp WebView")),
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
    );
  }
}
