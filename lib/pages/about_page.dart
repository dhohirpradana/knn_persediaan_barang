import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.systemPurple,
        title: const Text('TENTANG'),
      ),
      body: const Center(
        child: Text('Prediksi persediaan barang'),
      ),
    );
  }
}
