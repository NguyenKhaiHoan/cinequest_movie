import 'package:equatable/equatable.dart';

class DatesDto extends Equatable {
  final DateTime? maximum;
  final DateTime? minimum;

  const DatesDto({
    this.maximum,
    this.minimum,
  });

  @override
  List<Object?> get props => [maximum, minimum];
}
