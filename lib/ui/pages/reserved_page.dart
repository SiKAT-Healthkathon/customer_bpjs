import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigation.dart';

class ReservedPage extends StatelessWidget {
  const ReservedPage({super.key});

  Widget body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              './assets/images/success.png',
              width: 200,
            ),
            const SizedBox(height: 24),
            Text(
              'Reservasi Berhasil Dibuat!',
              style: blackText.copyWith(fontSize: 20, fontWeight: semibold),
            ),
            const SizedBox(height: 8),
            Text(
              'Selalu perhatikan kelengkapan dokumen dan jadwal yang dipilih untuk memperoleh layanan kesehatan',
              style: greyText.copyWith(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: body(),
      bottomNavigationBar: CustomBottomNavigation(
        textSeccond: 'Beranda',
        onPressedSeccond: () => Navigator.pushNamed(context, '/facility'),
        text: 'Tracking',
        onPressed: () => Navigator.pushNamed(context, '/tracking'),
      ),
    );
  }
}
