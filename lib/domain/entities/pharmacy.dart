import 'package:equatable/equatable.dart';

class Pharmacy extends Equatable {
  const Pharmacy({
    required this.id,
    required this.name,
    required this.address,
    required this.hours,
    required this.rating,
    this.favorite = false,
  });

  final String id;
  final String name;
  final String address;
  final String hours;
  final double rating;
  final bool favorite;

  @override
  List<Object?> get props => [id, name, address, hours, rating, favorite];
}
