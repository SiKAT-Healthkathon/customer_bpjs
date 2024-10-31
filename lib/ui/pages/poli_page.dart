import 'package:bpjs_customer/shared/theme.dart';
import 'package:bpjs_customer/ui/widgets/custom_dropdown.dart';
import 'package:bpjs_customer/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';

class PoliPage extends StatelessWidget {
  const PoliPage({super.key});

  Widget body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            Text(
              '🤒 Poli Mana yang Anda Dibutuhkan?',
              style: blackText.copyWith(fontSize: 24, fontWeight: bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              'Tentukan poli yang akan menjadi tujuan dari tindakan yang dibutuhkan.',
              style: greyText.copyWith(fontSize: 12),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            CustomDropdown(
                label: 'Poli',
                hintText: 'Pilih poli yang dibutuhkan',
                items: const ['Poli Umum', 'Poli Gigi', 'Poli KIA'],
                selectedItem: null,
                onChanged: (val) {}),
            const SizedBox(height: 20),
            const CustomTextField(
              isMultiline: true,
              label: 'Keluhan',
              hintText: 'Tuliskan keluhan yang dialami...',
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
      appBar: const CustomAppBar(progress: 3 / 5),
      body: body(),
      bottomNavigationBar: CustomBottomNavigation(
          onPressed: () => Navigator.pushNamed(context, '/time')),
    );
  }
}
