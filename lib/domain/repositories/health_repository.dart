import '../entities/appointment.dart';
import '../entities/doctor.dart';
import '../entities/pharmacy.dart';

abstract interface class HealthRepository {
  Future<List<Doctor>> getDoctors();
  Future<List<Appointment>> getAppointments();
  Future<List<Pharmacy>> getPharmacies();
}
