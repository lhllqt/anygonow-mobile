import 'package:flutter_dotenv/flutter_dotenv.dart';

String getCDN(String s) {
  if (s == "") return s;
  if (s.contains('http')) {
    return s;
  }
  String cdnUrl = dotenv.env["CDN_URL"].toString();
  print({"db": cdnUrl != "" ? cdnUrl : 'http://d26p4pe0nfrg62.cloudfront.net/' + s});
  return cdnUrl != "" ? cdnUrl : 'http://d26p4pe0nfrg62.cloudfront.net/' + s;
}
