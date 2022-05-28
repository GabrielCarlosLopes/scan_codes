import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.warning, color: Colors.red, size: 72),
          SizedBox(height: 10),
          Text('Algo deu errado!'),
        ],
      ),
    );
  }
}
