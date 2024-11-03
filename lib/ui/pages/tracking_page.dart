import 'package:bpjs_customer/models/reserve_model.dart';
import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/custom_app_bar.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final future = Supabase.instance.client
        .from('reservations')
        .select()
        .eq('nik', '3273105503040004')
        .or('status.eq.Terdaftar,status.eq.Check In,status.eq.Belum Datang')
        .order('created_at', ascending: true)
        .limit(1)
        .single();

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
          child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                ReserveModel reserve = ReserveModel.fromJson(snapshot.data!);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 36),
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
                              title: reserve.layanan,
                              value: reserve.rumahSakit),
                          const SizedBox(height: 24),
                          list(
                            title: '🗓️ Waktu & Tanggal',
                            value: DateFormat('EE, dd MMM yyyy').format(
                              reserve.tanggal!,
                            ),
                          ),
                          const SizedBox(height: 24),
                          list(title: '🤒 Poli', value: reserve.poli ?? ''),
                          const SizedBox(height: 24),
                          list(
                            title: '👩🏻‍⚕️ Tenaga Kesehatan',
                            value: reserve.dokter,
                          ),
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
                    Visibility(
                        visible: reserve.status == 'Check In',
                        child: const SizedBox(height: 8)),
                    Visibility(
                      visible: reserve.status == 'Check In',
                      child: Text(
                        '001',
                        style: whiteText.copyWith(
                          fontWeight: bold,
                          fontSize: 40,
                        ),
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
                          reserve.status == 'Check In'
                              ? 'Checked In at ${DateFormat('HH:mm').format(reserve.checkInAt!)}'
                              : 'Terdaftar pada ${DateFormat('EE, dd MMM yyyy, HH:mm').format(reserve.tanggal!)}',
                          style: whiteText.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      );
    }

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
