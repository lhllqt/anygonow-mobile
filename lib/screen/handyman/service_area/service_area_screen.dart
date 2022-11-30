import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/controller/handyman/service_area/service_area_controller.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/layout.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ServiceAreaScreen extends StatelessWidget {
  ServiceAreaController serviceAreaController =
      Get.put(ServiceAreaController());



  // final flutterWebviewPlugin = FlutterWebviewPlugin();


  @override
  Widget build(BuildContext context) {

    final Set<JavascriptChannel> jsChannels = {
      JavascriptChannel(
          name: 'Print',
          onMessageReceived: (JavascriptMessage message) async {
            print('message.message: ${message.message}');
            var json = jsonDecode(message.message);
            List<String> zipcodes = [];
            for (int i = 0; i < json["zipcodes"].length; i++) {
              zipcodes.add(json["zipcodes"][i]);
            }
            await Get.put(ServiceAreaController().saveZipcode(zipcodes));
          }),
    };

    print(Get.put(GlobalController()).user.value.certificate.toString());
    var flutterWebviewPlugin = FlutterWebviewPlugin();

    // flutterWebviewPlugin.evalJavascript("(function() { try { window.localStorage.setItem('persist:userInfo', {auth: ${Get.put(GlobalController()).user.value.certificate.toString()}}); } catch (err) { return err; } })();");

    var base64cert = base64.encode(
        utf8.encode(Get.put(GlobalController()).user.value.certificate ?? ""));
    print(GlobalController.baseWebUrl + "map?certificate=$base64cert");

    flutterWebviewPlugin.onUrlChanged.listen((state) async {
      print("abcdscds" + state);
      if (state.contains("https://handyman-2.uetbc.xyz/map")) {
        // String script =
        //     'window.addEventListener("message", receiveMessage, false);' +
        //         'function receiveMessage(event) {Print.postMessage(event.data);}';
        // flutterWebviewPlugin.evalJavascript(script);
        final res = await flutterWebviewPlugin.evalJavascript(
            '(function() { try { window.addEventListener("message", receiveMessage, false); function receiveMessage(event) {Print.postMessage(event.data);} var elem = document.getElementsByTagName("button"); elem[0].addEventListener("click", function() { setTimeout(() => {var x = localStorage.getItem("business"); if (x != null) { window.postMessage(x);}}, 1000) });} catch (err) {  } })();');
        print("dsadjsk$res");
      }
    });
    // flutterWebviewPlugin
    //     .launch(
    //   GlobalController.baseWebUrl + "map?certificate=$base64cert",
    //   withLocalStorage: true,
    //   withJavascript: true,
    // )
    //     .whenComplete(() {
    //   final res = flutterWebviewPlugin.evalJavascript(
    //       '(function() { try { var elem = document.getElementById("updateBtn"); elem.addEventListener("click", function() {var x = localStorage.getItem("business"); if (x != null) var json = JSON.parse(x); });} catch (err) { alert(err); } })();');
    //   print("Eval result: $res");
    // });

    return Scaffold(
      appBar: appBar(),
      body: WebviewScaffold(
        url: GlobalController.baseWebUrl + "map?certificate=$base64cert",
        javascriptChannels: jsChannels,
        withJavascript: true,
        withLocalStorage: true,
      ),
    );
  }
}
