import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  Widget list({required String title, required String value}) {
    return Column(children: [
      Text(
        title,
        style: greyText.copyWith(
          fontSize: 12,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: blackText.copyWith(fontSize: 16, fontWeight: bold),
      ),
    ]);
  }

  Widget body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: whiteColor,
              ),
              child: Column(
                children: [
                  Text(
                    'Detail Reservasi',
                    style: blackText.copyWith(
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 20),
                  list(
                      title: '🏥 Faskes Rujukan Tingkat Lanjut',
                      value: 'Rumah Sakit Salamun'),
                  const SizedBox(height: 24),
                  list(
                      title: '🗓️ Waktu & Tanggal', value: '09.00, 08/05/2024'),
                  const SizedBox(height: 24),
                  list(title: '🤒 Poli', value: 'Kulit & Kelamin'),
                  const SizedBox(height: 24),
                  list(
                      title: '👩🏻‍⚕️ Tenaga Kesehatan',
                      value: 'dr. Sa\'da Barira, Sp.DVE'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Nomor Antrian Sesuai Kedatangan',
              style: whiteText.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '004',
              style: whiteText.copyWith(
                fontWeight: bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: greenColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Checked In at 07.00',
                  style: whiteText.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      appBar: const CustomAppBar(
        color: blueColor,
        textColor: whiteColor,
        title: 'Lacak Antrian',
      ),
      body: body(),
    );
  }
}
