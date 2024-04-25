import 'package:flutter_dotenv/flutter_dotenv.dart';

final secureUri = dotenv.env['URI'];
final loginUri = dotenv.env['LOGIN_URI'];
String uri = secureUri!;
String loginuri = loginUri!;

String getUserDataUri = '$uri/';