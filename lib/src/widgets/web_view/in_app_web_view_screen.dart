import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewScreen extends StatefulWidget {
  final String url;

  const InAppWebViewScreen({super.key, required this.url});

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  InAppWebViewController? controller;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('লাইফ ফ্রেন্ড'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller?.reload(),
          ),
        ],
      ),
      body: Column(
        children: [
          // ✅ Progress bar
          if (progress < 1)
            LinearProgressIndicator(value: progress),

          Expanded(
            child: InAppWebView(
              // ✅ safer
              initialUrlRequest:
              URLRequest(url: WebUri(widget.url)),

              // ✅ recommended settings
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                useHybridComposition: true,
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
              ),

              onWebViewCreated: (c) {
                controller = c;
                debugPrint('WebView Created');
              },

              onLoadStart: (c, url) {
                debugPrint('Loading started: $url');
              },

              onLoadStop: (c, url) {
                debugPrint('Loading finished: $url');
              },

              onProgressChanged: (c, p) {
                setState(() {
                  progress = p / 100;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

