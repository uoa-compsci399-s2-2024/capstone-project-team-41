import 'package:auth0_flutter/auth0_flutter.dart';

class Auth0Connector {
  Auth0Connector.internal();

  static final Auth0Connector _instance = Auth0Connector.internal();
  factory Auth0Connector() => _instance;
  static Auth0Connector get instance => _instance;

  late Auth0 _auth0;

  Future<void> init() async {
    _setupAuth0();
  }

  Auth0 get auth0 {
    return _auth0;
  }

  _setupAuth0() {
    final auth0 = Auth0('dev-omhf4f5ly70nx3i0.us.auth0.com',
        'AiN21zau0pRZaDFpuTS9exROyhMw9yaZ');
    _auth0 = auth0;
  }
}
