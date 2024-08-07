import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static Future<void> setJWTTokenInfo(TokenModel token) async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('JWT_TokenInfo', token.toJson());
  }

  static Future<TokenModel?> getJWTTokenInfo() async {
    TokenModel? tokenModel;
    var prefs = await SharedPreferences.getInstance();
    var tokenInfo = prefs.getString('JWT_TokenInfo');
    if (tokenInfo != null) {
      tokenModel = TokenModel.fromJson(tokenInfo);
    }
    return tokenModel;
  }

  static Future<void> clearCache() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
