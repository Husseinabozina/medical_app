import '../../domain/entities/appointment.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/entities/pharmacy.dart';
import '../../domain/repositories/health_repository.dart';

class MockHealthRepository implements HealthRepository {
  @override
  Future<List<Doctor>> getDoctors() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return const [
      Doctor(id: 'emma', name: 'Dr. Emma Hall, M.D.', specialty: 'General Doctor', rating: 5, reviews: 30, years: 12, favorite: true),
      Doctor(id: 'ava', name: 'Dr. Ava Williams, M.D.', specialty: 'Maternal-Fetal Medicine', rating: 4.9, reviews: 46, years: 15, favorite: true),
      Doctor(id: 'daniel', name: 'Dr. Daniel Rodriguez', specialty: 'Interventional Cardiologist', rating: 4.8, reviews: 39, years: 11, favorite: true),
      Doctor(id: 'benjamin', name: 'Dr. Benjamin Davis', specialty: 'Retinal Specialist', rating: 4.7, reviews: 27, years: 10),
      Doctor(id: 'chloe', name: 'Dr. Chloe Green, M.D.', specialty: 'Gynecology', rating: 4.9, reviews: 34, years: 9),
      Doctor(id: 'logan', name: 'Dr. Logan Williams, M.D.', specialty: 'Dermatology', rating: 4.7, reviews: 28, years: 8),
      Doctor(id: 'jacob', name: 'Dr. Jacob Lopez, M.D.', specialty: 'Surgical Dermatology', rating: 5, reviews: 40, years: 15),
    ];
  }

  @override
  Future<List<Appointment>> getAppointments() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return const [
      Appointment(id: 'a1', doctorId: 'emma', dateLabel: 'Sunday, 12 June', timeLabel: '9:30 AM – 10:00 AM', status: AppointmentStatus.upcoming),
      Appointment(id: 'a2', doctorId: 'logan', dateLabel: 'Friday, 20 June', timeLabel: '2:30 PM – 3:00 PM', status: AppointmentStatus.upcoming),
      Appointment(id: 'a3', doctorId: 'chloe', dateLabel: 'Tuesday, 15 June', timeLabel: '9:30 AM – 10:00 AM', status: AppointmentStatus.upcoming),
      Appointment(id: 'a4', doctorId: 'daniel', dateLabel: 'Friday, 20 June', timeLabel: '2:30 PM – 3:00 PM', status: AppointmentStatus.complete),
    ];
  }

  @override
  Future<List<Pharmacy>> getPharmacies() async {
    await Future<void>.delayed(const Duration(milliseconds: 90));
    return const [
      Pharmacy(id: 'p1', name: 'MediCure Pharmacy', address: '778 Locust View Drive, Oakland, CA', hours: '7:15 AM – 6:30 PM', rating: 5, favorite: true),
      Pharmacy(id: 'p2', name: 'Vitality Pharmacy', address: '778 Locust View Drive, Oakland, CA', hours: '7:15 AM – 6:30 PM', rating: 4.8),
      Pharmacy(id: 'p3', name: 'PureHealth Pharmacy', address: '778 Locust View Drive, Oakland, CA', hours: '7:15 AM – 6:30 PM', rating: 4.7),
      Pharmacy(id: 'p4', name: 'Stay Health Pharmacy', address: '778 Locust View Drive, Oakland, CA', hours: '7:15 AM – 6:30 PM', rating: 4.6),
    ];
  }
}
