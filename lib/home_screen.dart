import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E1F92),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Get in touch',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),

              // launch call
              TextButton(
                onPressed: () async {
                  await launchCall();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.phone, color: Color(0xFFED92A2)),
                    SizedBox(width: 20.0),
                    Text(
                      '+0123 4567 8910',
                      style: TextStyle(
                          color: Color(0xFFA294C2),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              // launch SMS
              TextButton(
                onPressed: () async {
                  await sendSMS();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.sms, color: Color(0xFFED92A2)),
                    SizedBox(width: 20.0),
                    Text(
                      '+0123 4567 8910',
                      style: TextStyle(
                          color: Color(0xFFA294C2),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              // launch Email
              TextButton(
                onPressed: () async {
                  await launchEmail();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mail, color: Color(0xFFED92A2)),
                    SizedBox(width: 20.0),
                    Text(
                      'pjadav669@rku.ac.in',
                      style: TextStyle(
                        color: Color(0xFFA294C2),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // launch location
              TextButton(
                onPressed: () async {
                  await launchLocation();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_pin, color: Color(0xFFED92A2)),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Text(
                        '4XPJ+PWP, Bhavnagar Highway:, Sardhar, Gujarat 360025',
                        style: TextStyle(
                          color: Color(0xFFA294C2),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // launch webView or url
              TextButton(
                onPressed: () async {
                  await loadWebView();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.language, color: Color(0xFFED92A2)),
                    SizedBox(width: 20.0),
                    Text(
                      'https://github.com/Pradipjadav05',
                      style: TextStyle(
                        color: Color(0xFFA294C2),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // load url in browser or webView
  Future<void> loadWebView() async {
    const String url = "https://github.com/Pradipjadav05/";
    /*
    * Properties:
    * Mode -
    *   LaunchMode.platformDefault : open url in default application.
    *   LaunchMode.inAppWebView : open url in withing app.
    *   LaunchMode.externalApplication : Passes the URL to the OS to be handled by another application.
    *   LaunchMode.externalNonBrowserApplication : Passes the URL to the OS to be handled by another non-browser application.
    *
    * webOnlyWindowName -
    *   For web, webOnlyWindowName specifies a target for the launch. This supports the standard special link target names. For example:
    *   "_blank" opens the new URL in a new tab.
    *   "_self" opens the new URL in the current tab. Default behaviour when unset is to open the url in a new tab.
    *
    * webViewConfiguration -
    *   value : WebViewConfiguration()
    *   property of WebViewConfiguration():
    *     enableJavaScript: Whether or not JavaScript is enabled for the web content. Default true
    *     enableDomStorage: Whether or not DOM storage is enabled for the web content. Default true
    *     headers: Additional headers to pass in the load request.
    * */
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webOnlyWindowName: "PJ",
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // Launch Location in map.
  Future<void> launchLocation() async {
    const String lat = "42.3540";
    const String lng = "71.0586";
    const String mapUrl = "geo:$lat,$lng";

    if (!await launchUrl(Uri.parse(mapUrl))) {
      throw "Couldn't launch Map";
    }
  }

  // Launch mail
  Future<void> launchEmail() async {
    String email = 'this.is.tijani@gmail.com';
    String subject = 'This is a test email';
    String body = 'This is a test email body';

    String emailUrl = "mailto:$email?subject=$subject&body=$body";

    if (!await launchUrl(Uri.parse(emailUrl))) {
      throw "Error occurred sending an email";
    }
  }

  // send SMS with text
  Future<void> sendSMS() async {
    String mobile = "+0123 4567 8910";
    String message = "This is a test SMS body";
    String smsUrl = "sms:$mobile${Platform.isAndroid ? '?' : '&'}body=$message";

    if (!await launchUrl(Uri.parse(smsUrl))) {
      throw "Error occurred trying to send a message that number.";
    }

    // another way

    // final Uri smsLaunchUri = Uri(
    //   scheme: 'sms',
    //   path: '0123 999 811 897 189 9197',
    //   queryParameters: <String, String>{
    //     'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
    //   },
    // );
    // await launchUrl(smsLaunchUri);
  }

  Future<void> launchCall() async {
    String mobile = "+0123 4567 8910";
    String callUrl = "tel:$mobile";

    if (!await launchUrl(Uri.parse(callUrl))) {
      throw "Error occurred trying to call that number.";
    }
  }
}
