import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.years,
    this.favorite = false,
  });

  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final int years;
  final bool favorite;

  Doctor copyWith({bool? favorite}) => Doctor(
        id: id,
        name: name,
        specialty: specialty,
        rating: rating,
        reviews: reviews,
        years: years,
        favorite: favorite ?? this.favorite,
      );

  @override
  List<Object?> get props => [id, name, specialty, rating, reviews, years, favorite];
}
