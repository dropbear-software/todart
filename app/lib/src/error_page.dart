import 'package:flutter/widgets.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(Exception? error, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
