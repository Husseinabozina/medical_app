class Specialty {
  const Specialty(this.title, this.symbol);

  final String title;
  final String symbol;
}

class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.location,
    required this.experience,
    required this.fee,
    required this.initials,
  });

  final String id;
  final String name;
  final String specialty;
  final double rating;
  final String location;
  final String experience;
  final double fee;
  final String initials;
}

class Appointment {
  const Appointment({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
    required this.status,
  });

  final String id;
  final Doctor doctor;
  final String date;
  final String time;
  final String status;

  Appointment copyWith({
    String? date,
    String? time,
    String? status,
  }) {
    return Appointment(
      id: id,
      doctor: doctor,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }
}

class Pharmacy {
  const Pharmacy(this.name, this.distance, this.rating);

  final String name;
  final String distance;
  final double rating;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.text,
    required this.incoming,
    required this.sentAt,
  });

  final String id;
  final String text;
  final bool incoming;
  final DateTime sentAt;
}

class MedicalRecordEntry {
  const MedicalRecordEntry({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
  });

  final String id;
  final String title;
  final String category;
  final String summary;
}

class PaymentCard {
  const PaymentCard({
    required this.id,
    required this.holder,
    required this.last4,
    required this.expiry,
  });

  final String id;
  final String holder;
  final String last4;
  final String expiry;
}

class UserProfile {
  const UserProfile({
    required this.name,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
  });

  final String name;
  final String phone;
  final String email;
  final String dateOfBirth;

  UserProfile copyWith({
    String? name,
    String? phone,
    String? email,
    String? dateOfBirth,
  }) {
    return UserProfile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}

abstract interface class HealthDataSource {
  List<Specialty> get specialties;
  List<Doctor> get doctors;
  List<Appointment> get appointments;
  List<Pharmacy> get pharmacies;
  Set<String> get favoriteDoctorIds;
  List<ChatMessage> get messages;
  List<MedicalRecordEntry> get medicalRecords;
  List<PaymentCard> get paymentCards;
  UserProfile get profile;

  Future<void> toggleFavorite(String doctorId);
  Future<ChatMessage> sendMessage(String text);
  Future<void> cancelAppointment(String appointmentId, String reason);
  Future<void> rebookAppointment(String appointmentId);
  Future<void> addMedicalRecord(MedicalRecordEntry record);
  Future<void> addPaymentCard(PaymentCard card);
  Future<void> updateProfile(UserProfile profile);
}

abstract interface class HealthRepository {
  List<Specialty> get specialties;
  List<Doctor> get doctors;
  List<Appointment> get appointments;
  List<Pharmacy> get pharmacies;
  Set<String> get favoriteDoctorIds;
  List<ChatMessage> get messages;
  List<MedicalRecordEntry> get medicalRecords;
  List<PaymentCard> get paymentCards;
  UserProfile get profile;

  Future<void> toggleFavorite(String doctorId);
  Future<ChatMessage> sendMessage(String text);
  Future<void> cancelAppointment(String appointmentId, String reason);
  Future<void> rebookAppointment(String appointmentId);
  Future<void> addMedicalRecord(MedicalRecordEntry record);
  Future<void> addPaymentCard(PaymentCard card);
  Future<void> updateProfile(UserProfile profile);
}
