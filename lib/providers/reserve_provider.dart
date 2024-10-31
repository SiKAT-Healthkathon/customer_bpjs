import 'package:bpjs_customer/models/reserve_model.dart';
import 'package:flutter/material.dart';

class ReserveProvider extends ChangeNotifier {
  // String _errorMessage = '';
  static ReserveModel _reserve = const ReserveModel(
    dokter: '',
    poli: null,
    keluhan: '',
    kota: null,
    layanan: '',
    provinsi: null,
    rumahSakit: '',
    tanggal: null,
  );

  // String get errorMessage => _errorMessage;
  ReserveModel get reserve => _reserve;

  // Fungsi untuk mengubah layanan
  void setLayanan(String layanan) {
    _reserve = _reserve.copyWith(layanan: layanan);
    notifyListeners();
  }

  // Fungsi untuk mengubah provinsi
  void setProvinsi(String provinsi) {
    _reserve = _reserve.copyWith(provinsi: provinsi);
    notifyListeners();
  }

  // Fungsi untuk mengubah kota
  void setKota(String? kota) {
    _reserve = _reserve.copyWith(kota: kota);
    notifyListeners();
  }

  // Fungsi untuk mengubah rumah sakit
  void setRumahSakit(String rumahSakit) {
    _reserve = _reserve.copyWith(rumahSakit: rumahSakit);
    notifyListeners();
  }

  // Fungsi untuk mengubah poli
  void setPoli(String poli) {
    _reserve = _reserve.copyWith(poli: poli);
    notifyListeners();
  }

  // Fungsi untuk mengubah dokter
  void setDokter(String dokter) {
    _reserve = _reserve.copyWith(dokter: dokter);
    notifyListeners();
  }

  // Fungsi untuk mengubah keluhan
  void setKeluhan(String keluhan) {
    _reserve = _reserve.copyWith(keluhan: keluhan);
    notifyListeners();
  }

  // Fungsi untuk mengubah tanggal
  void setTanggal(DateTime? tanggal) {
    _reserve = _reserve.copyWith(tanggal: tanggal);
    notifyListeners();
  }

  void setTimeSlot(int hour, int minute) {
    if (_reserve.tanggal != null) {
      final newDate = DateTime(
        _reserve.tanggal!.year,
        _reserve.tanggal!.month,
        _reserve.tanggal!.day,
        hour,
        minute,
      );
      _reserve = _reserve.copyWith(tanggal: newDate);
      notifyListeners();
    }
  }
}
