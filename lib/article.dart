import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleArguments {
  final String url;

  ArticleArguments(this.url);
}

class ArticleWebView extends StatefulWidget {
  const ArticleWebView({super.key});
  static const routeName = '/article';

  @override
  State<ArticleWebView> createState() => _ArticleWebView();
}

class _ArticleWebView extends State<ArticleWebView> {
  double _progress = 0.0;
  bool _isFirst = true;
  bool _isLoading = false;
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
      },
      onPageFinished: (url) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      onProgress: (progress) {
        if (mounted) {
          setState(() {
            _progress = progress / 100;
          });
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArticleArguments;
    if (_isFirst) {
      _isFirst = false;
      controller.loadRequest(Uri.parse(args.url));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('article'),
      ),
      body: Column(
        children: [
          _isLoading
              ? LinearProgressIndicator(value: _progress)
              : const SizedBox.shrink(),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
