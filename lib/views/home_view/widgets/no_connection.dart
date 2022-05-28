import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.wifi_off, color: Colors.red, size: 72),
          SizedBox(height: 20),
          Text('Sem conexão com a internet!')
        ],
      ),
    );
  }
}
