import 'dart:io';
import 'package:flutter/services.dart';
import 'certificate_http_overrides.dart';

//https://github.com/cfug/dio/issues/956
//https://letsencrypt.org/certs/lets-encrypt-r3.pem
class CertificateService {
  Future<void> initService() async {
    HttpOverrides.global = CertificateHttpOverrides();
    ByteData data = await PlatformAssetBundle().load('lib/app/assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asInt8List());
  }
}
