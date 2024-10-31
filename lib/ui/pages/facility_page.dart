import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';
import '../widgets/facility_card.dart';

class FacilityPage extends StatelessWidget {
  const FacilityPage({super.key});

  Widget body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            Text(
              '😷 Fasilitas Mana yang Dituju untuk Layanan ?',
              style: blackText.copyWith(fontSize: 24, fontWeight: bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              'Berikan spesifikasi fasilitas kesehatan yang dibutuhkan untuk pengobatan.',
              style: greyText.copyWith(fontSize: 12),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 28),
            const FacilityCard(
              title: '🏡 Faskes Tingkat Pertama',
              description:
                  'Membuat janji pertemuan pada faskes tingkat pertama sebagai tindakan dini penaganan',
            ),
            const SizedBox(height: 20),
            const FacilityCard(
              title: '🏥 Faskes Rujukan Tingkat Lanjut',
              description:
                  'Membuat janji dengan faskes rujukan setelah mendapat rujukan pada faskes tingkat pertama',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(progress: 1 / 5),
      body: body(),
      bottomNavigationBar: CustomBottomNavigation(
        onPressed: () => Navigator.pushNamed(context, '/location'),
      ),
    );
  }
}
