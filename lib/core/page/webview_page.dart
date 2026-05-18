import 'package:achat_vente/export.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

@RoutePage()
class WebViewPage extends StatefulWidget {
  final String? title;
  final String url;

  const WebViewPage({super.key, required this.url, this.title});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  late String url;

  Uri get loadUrl {
    Uri loadUrl = Uri.parse(url);
    if (loadUrl.isGouvBj && loadUrl.queryParameters['ismobile'] == null) {
      loadUrl = loadUrl.replace(
        queryParameters: {...loadUrl.queryParameters, 'ismobile': 'true'},
      );
    }

    return loadUrl;
  }

  @override
  void initState() {
    url = widget.url;
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            AppLogger.get().logInfo(
              'WebView is loading (progress : $progress%)',
            );
            if (mounted) {
              isLoading.value = progress < 100;
            }
          },
          onPageStarted: (String url) {
            AppLogger.get().logInfo('Page started loading: $url');
            if (mounted) {
              isLoading.value = true;
            }
          },
          onPageFinished: (String url) {
            AppLogger.get().logInfo('Page finished loading: $url');
            if (mounted) {
              isLoading.value = false;
            }
          },
          onWebResourceError: (WebResourceError error) {
            AppLogger.get().logError('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
            if (mounted) {
              isLoading.value = false;
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            AppLogger.get().logInfo('Navigation request: ${request.url}');
            Uri uri = Uri.parse(request.url);
            if (uri.isGouvBj && uri.queryParameters['ismobile'] == null) {
              uri = uri.replace(
                queryParameters: {...uri.queryParameters, 'ismobile': 'true'},
              );

              controller.loadRequest(uri);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            AppLogger.get().logInfo('Url changed: ${change.url}');

            if (change.url == url) {
              return;
            }

            setState(() {
              url = change.url ?? widget.url;
            });
          },
        ),
      )
      ..loadRequest(loadUrl);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // gradient: from top to bottom
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withValues(alpha: 0.9),
        Colors.black.withValues(alpha: 0),
      ],
      stops: const [0.0, 1.0],
    );
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        if (await _controller.canGoBack()) {
          _controller.goBack();
          return;
        }

        if (!context.mounted) {
          return;
        }

        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop(result);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                await _controller.goBack();
                return;
              }

              if (context.mounted && Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
          flexibleSpace:
              loadUrl.isGouvBj
                  ? Container(decoration: BoxDecoration(gradient: gradient))
                  : Container(
                    decoration: BoxDecoration(
                      gradient: IWidgetsFactory.build().defaultGradient,
                    ),
                  ),
          actions: <Widget>[
            NavigationControls(
              webViewController: _controller,
              url: url,
              subject: widget.title,
              withBorder: false,
            ),
          ],
        ),
        extendBodyBehindAppBar: loadUrl.isGouvBj,
        body: Padding(
          padding:
              loadUrl.isGouvBj
                  ? EdgeInsets.only(top: statusBarHeight)
                  : EdgeInsets.zero,
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder:
                    (context, value, child) =>
                        value
                            ? const LinearProgressIndicator()
                            : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({
    super.key,
    required this.webViewController,
    required this.url,
    this.subject,
    this.withBorder = false,
  });

  final WebViewController webViewController;
  final String url;
  final String? subject;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        BorderCircleIcon(
          withBorder: withBorder,
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () async {
            await Share.share('Partager $url', subject: subject);
          },
        ),
        const SizedBox(width: 15),
        BorderCircleIcon(
          withBorder: withBorder,
          icon: const Icon(Icons.replay, color: Colors.white),
          onPressed: () => webViewController.reload(),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class BorderCircleIcon extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? bgColor;
  final bool withBorder;

  const BorderCircleIcon({
    super.key,
    required this.icon,
    this.onPressed,
    this.borderColor,
    this.withBorder = true,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? Colors.black.withValues(alpha: 0.3),
          border:
              withBorder
                  ? Border.all(color: borderColor ?? Colors.white, width: 1)
                  : null,
          boxShadow:
              withBorder
                  ? const [BoxShadow(color: Colors.black, blurRadius: 2)]
                  : null,
        ),
        child: Center(child: icon),
      ),
    );
  }
}

extension XUri on Uri {
  // start with https://www.gouv.bj/ or https://gouv.bj/
  bool get isGouvBj => host == 'www.gouv.bj' || host == 'gouv.bj';
}
