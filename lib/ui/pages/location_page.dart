import 'package:bpjs_customer/shared/theme.dart';
import 'package:bpjs_customer/ui/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  Widget body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            Text(
              '📍 Dimana Lokasi Pilihan Anda?',
              style: blackText.copyWith(fontSize: 24, fontWeight: bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              'Tentukan lokasi kantor cabang terkait untuk melayani kebutuhan anda. ',
              style: greyText.copyWith(fontSize: 12),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            CustomDropdown(
                label: 'Provinsi',
                hintText: 'Pilih lokasi provinsi',
                items: const ['Jawa Barat', 'Jawa Tengah', 'Jawa Timur'],
                selectedItem: null,
                onChanged: (val) {}),
            const SizedBox(height: 20),
            CustomDropdown(
                label: 'Kota/Kab',
                hintText: 'Pilih lokasi kota/kab',
                items: const ['Bandung', 'Semarang', 'Surabaya'],
                selectedItem: null,
                onChanged: (val) {}),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(progress: 2 / 5),
      body: body(),
      bottomNavigationBar: CustomBottomNavigation(
        onPressed: () => Navigator.pushNamed(context, '/poli'),
      ),
    );
  }
}
