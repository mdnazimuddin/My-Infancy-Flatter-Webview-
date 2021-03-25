import 'package:Infancy/splashscreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'https://myinfancy.com';

// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Infancy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (_) => SplashScreen(),
        '/widget': (_) {
          return WebviewScaffold(
            url: selectedUrl,
            javascriptChannels: jsChannels,
            mediaPlaybackRequiresUserGesture: true,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(34, 168, 12, 0.94),
              elevation: 0,
              title: Text(
                "My Infancy",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              leading: Container(),
            ),
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: SafeArea(
              child: Container(
                color: Colors.white10,
                child: const Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: "loading",
                    semanticsValue: "Loading",
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goBack();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goForward();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.autorenew),
                    onPressed: () {
                      flutterWebViewPlugin.reload();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      },
    );
  }
}
