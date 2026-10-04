import '../core/health_domain.dart';

final class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl({required HealthDataSource dataSource})
      : _dataSource = dataSource;

  final HealthDataSource _dataSource;

  @override
  List<Appointment> get appointments => _dataSource.appointments;

  @override
  List<Doctor> get doctors => _dataSource.doctors;

  @override
  Set<String> get favoriteDoctorIds => _dataSource.favoriteDoctorIds;

  @override
  List<MedicalRecordEntry> get medicalRecords => _dataSource.medicalRecords;

  @override
  List<ChatMessage> get messages => _dataSource.messages;

  @override
  List<PaymentCard> get paymentCards => _dataSource.paymentCards;

  @override
  List<Pharmacy> get pharmacies => _dataSource.pharmacies;

  @override
  UserProfile get profile => _dataSource.profile;

  @override
  List<Specialty> get specialties => _dataSource.specialties;

  @override
  Future<void> addMedicalRecord(MedicalRecordEntry record) =>
      _dataSource.addMedicalRecord(record);

  @override
  Future<void> addPaymentCard(PaymentCard card) =>
      _dataSource.addPaymentCard(card);

  @override
  Future<void> cancelAppointment(String appointmentId, String reason) =>
      _dataSource.cancelAppointment(appointmentId, reason);

  @override
  Future<void> rebookAppointment(String appointmentId) =>
      _dataSource.rebookAppointment(appointmentId);

  @override
  Future<ChatMessage> sendMessage(String text) =>
      _dataSource.sendMessage(text);

  @override
  Future<void> toggleFavorite(String doctorId) =>
      _dataSource.toggleFavorite(doctorId);

  @override
  Future<void> updateProfile(UserProfile profile) =>
      _dataSource.updateProfile(profile);
}
