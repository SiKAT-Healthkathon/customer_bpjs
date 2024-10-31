import 'package:bpjs_customer/models/reserve_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReservationService {
  final SupabaseClient client = Supabase.instance.client;

  Future<bool> createReservation(
      {required ReserveModel reservation, required String nik}) async {
    try {
      await client.from('reservations').insert({
        'layanan': reservation.layanan,
        'provinsi': reservation.provinsi,
        'kota': reservation.kota,
        'rumah_sakit': reservation.rumahSakit,
        'poli': reservation.poli,
        'dokter': reservation.dokter,
        'keluhan': reservation.keluhan,
        'tanggal': reservation.tanggal
            ?.toIso8601String(), // Mengonversi DateTime ke String
        'nik': nik,
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
