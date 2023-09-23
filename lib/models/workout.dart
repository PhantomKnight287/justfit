import 'package:isar/isar.dart';

@collection
class Workout {
  Id id = Isar.autoIncrement;

  String? name;

  List<Exercise>? exercises;

  /// List to paths pointing to actual bundled images
  List<String>? emojis;
}

class Exercise {
  /// Name of the Exercise. Ex: 10 Pushups
  String? name;

  /// Time at which the exercise will start, required for first exercise and then optional.
  DateTime? startTime;

  /// Not Required for any exercise but can be added. For Example: 30s jumping jacks
  DateTime? endTime;

  /// How long the break should be after this exercise. Must be in seconds and a whole number
  int? breakDuration;

  /// The total number of reps. A whole number
  int? repetition;
}
