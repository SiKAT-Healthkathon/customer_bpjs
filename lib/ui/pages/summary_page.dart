import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';
import '../widgets/facility_card.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  Widget card({required IconData icon, required String title, Widget? child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: blackColor,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: blackText.copyWith(
                    fontSize: 14,
                    fontWeight: semibold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mode_edit_outlined,
                color: blueColor,
              ),
            )
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 40, bottom: 12),
            child: child ?? const SizedBox()),
        const Divider(),
      ],
    );
  }

  Widget body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            card(
              icon: Icons.account_circle_outlined,
              title: 'Nomor Induk Kependudukan',
              child: Text(
                '3273105503040004',
                style: greyText.copyWith(fontSize: 12),
              ),
            ),
            card(
              icon: Icons.description_outlined,
              title: 'Fasilitas Kesehatan',
              child: const FacilityCard(
                title: '🏥 Faskes Rujukan Tingkat Lanjut',
                description:
                    'Membuat janji dengan faskes rujukan setelah mendapat rujukan pada faskes tingkat pertama',
              ),
            ),
            card(
              icon: Icons.location_on_outlined,
              title: 'Lokasi',
              child: Text(
                'RS Salamun',
                style: greyText.copyWith(fontSize: 12),
              ),
            ),
            card(
              icon: Icons.calendar_today_outlined,
              title: 'Waktu',
              child: Text(
                '12/10/2024 08:10',
                style: greyText.copyWith(fontSize: 12),
              ),
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
      appBar: const CustomAppBar(
        title: 'Kesimpulan',
      ),
      body: body(),
      bottomNavigationBar: CustomBottomNavigation(
        text: 'Konfirmasi',
        onPressed: () => Navigator.pushNamed(context, '/reserved'),
      ),
    );
  }
}
