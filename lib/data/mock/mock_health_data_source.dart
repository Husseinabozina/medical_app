import '../../core/health_domain.dart';

final class MockHealthDataSource implements HealthDataSource {
  MockHealthDataSource({
    this.latency = const Duration(milliseconds: 180),
  });

  final Duration latency;

  static const _specialties = <Specialty>[
    Specialty('Cardiology', '♡'),
    Specialty('Dermatology', '✦'),
    Specialty('General', '+'),
    Specialty('Gynecology', '◌'),
    Specialty('Odontology', '◇'),
    Specialty('Oncology', '✣'),
    Specialty('Ophthalmology', '◉'),
    Specialty('Orthopedics', '⌁'),
  ];

  static const _doctors = <Doctor>[
    Doctor(
      id: 'emma',
      name: 'Dr. Emma Wilson',
      specialty: 'Cardiologist',
      rating: 4.9,
      location: 'Central Medical Center',
      experience: '12 years',
      fee: 45,
      initials: 'EW',
    ),
    Doctor(
      id: 'chloe',
      name: 'Dr. Chloe Martin',
      specialty: 'Dermatologist',
      rating: 4.8,
      location: 'Health Point Clinic',
      experience: '9 years',
      fee: 40,
      initials: 'CM',
    ),
    Doctor(
      id: 'benjamin',
      name: 'Dr. Benjamin Lee',
      specialty: 'General Doctor',
      rating: 4.7,
      location: 'Wellness Medical Hub',
      experience: '11 years',
      fee: 35,
      initials: 'BL',
    ),
    Doctor(
      id: 'ava',
      name: 'Dr. Ava Carter',
      specialty: 'Ophthalmologist',
      rating: 4.9,
      location: 'Vision Care Center',
      experience: '10 years',
      fee: 50,
      initials: 'AC',
    ),
  ];

  final List<Appointment> _appointments = [
    Appointment(
      id: 'a1',
      doctor: _doctors[0],
      date: 'Monday, 12 Oct',
      time: '10:30 AM',
      status: 'Upcoming',
    ),
    Appointment(
      id: 'a2',
      doctor: _doctors[1],
      date: 'Friday, 02 Oct',
      time: '04:00 PM',
      status: 'Completed',
    ),
  ];

  static const _pharmacies = <Pharmacy>[
    Pharmacy('Vitality Pharmacy', '0.8 km', 4.8),
    Pharmacy('PureHealth Pharmacy', '1.2 km', 4.7),
    Pharmacy('Stay Health Pharmacy', '1.8 km', 4.6),
  ];

  final Set<String> _favoriteDoctorIds = {'emma'};

  final List<ChatMessage> _messages = [
    ChatMessage(
      id: 'm1',
      text: 'Hello Hussein, I reviewed your latest notes.',
      incoming: true,
      sentAt: DateTime(2026, 10, 4, 10, 30),
    ),
    ChatMessage(
      id: 'm2',
      text: 'Thank you. Is there anything I should do before Monday?',
      incoming: false,
      sentAt: DateTime(2026, 10, 4, 10, 34),
    ),
    ChatMessage(
      id: 'm3',
      text:
          'Please keep your current routine and bring your recent reports with you.',
      incoming: true,
      sentAt: DateTime(2026, 10, 4, 10, 36),
    ),
  ];

  final List<MedicalRecordEntry> _medicalRecords = [
    const MedicalRecordEntry(
      id: 'r1',
      title: 'Blood Test',
      category: 'Analysis',
      summary: 'Routine blood work added manually.',
    ),
    const MedicalRecordEntry(
      id: 'r2',
      title: 'Pollen',
      category: 'Allergy',
      summary: 'Sneezing and nasal congestion.',
    ),
  ];

  final List<PaymentCard> _paymentCards = [
    const PaymentCard(
      id: 'card1',
      holder: 'Jane Doe',
      last4: '4242',
      expiry: '04/28',
    ),
  ];

  UserProfile _profile = const UserProfile(
    name: 'Hussein Abozina',
    phone: '+123 567 89000',
    email: 'hussein@example.com',
    dateOfBirth: '01 / 01 / 2000',
  );

  Future<void> _wait() => Future<void>.delayed(latency);

  @override
  List<Appointment> get appointments =>
      List<Appointment>.unmodifiable(_appointments);

  @override
  List<Doctor> get doctors => _doctors;

  @override
  Set<String> get favoriteDoctorIds =>
      Set<String>.unmodifiable(_favoriteDoctorIds);

  @override
  List<MedicalRecordEntry> get medicalRecords =>
      List<MedicalRecordEntry>.unmodifiable(_medicalRecords);

  @override
  List<ChatMessage> get messages => List<ChatMessage>.unmodifiable(_messages);

  @override
  List<PaymentCard> get paymentCards =>
      List<PaymentCard>.unmodifiable(_paymentCards);

  @override
  List<Pharmacy> get pharmacies => _pharmacies;

  @override
  UserProfile get profile => _profile;

  @override
  List<Specialty> get specialties => _specialties;

  @override
  Future<void> addMedicalRecord(MedicalRecordEntry record) async {
    await _wait();
    _medicalRecords.add(record);
  }

  @override
  Future<void> addPaymentCard(PaymentCard card) async {
    await _wait();
    _paymentCards.add(card);
  }

  @override
  Future<void> cancelAppointment(String appointmentId, String reason) async {
    await _wait();
    final index =
        _appointments.indexWhere((appointment) => appointment.id == appointmentId);
    if (index == -1) return;
    _appointments[index] = _appointments[index].copyWith(status: 'Cancelled');
  }

  @override
  Future<void> rebookAppointment(String appointmentId) async {
    await _wait();
    final index =
        _appointments.indexWhere((appointment) => appointment.id == appointmentId);
    if (index == -1) return;
    _appointments[index] = _appointments[index].copyWith(status: 'Upcoming');
  }

  @override
  Future<ChatMessage> sendMessage(String text) async {
    await _wait();
    final message = ChatMessage(
      id: 'm${_messages.length + 1}',
      text: text.trim(),
      incoming: false,
      sentAt: DateTime.now(),
    );
    _messages.add(message);
    return message;
  }

  @override
  Future<void> toggleFavorite(String doctorId) async {
    await _wait();
    if (!_favoriteDoctorIds.add(doctorId)) {
      _favoriteDoctorIds.remove(doctorId);
    }
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    await _wait();
    _profile = profile;
  }
}
