import 'package:isar/isar.dart';
part 'workout.g.dart';

@collection
class Workout {
  Id id = Isar.autoIncrement;

  String? name;
  List<Exercise>? exercises;

  /// List to paths pointing to actual bundled images
  List<String>? emojis;
}

@embedded
class Exercise {
  /// Name of the Exercise. Ex: 10 Pushups
  String? name;

  /// How long the break should be after this exercise. Must be in seconds and a whole number
  int? breakDuration;

  /// The total number of reps. A whole number
  int? repetition;
}

enum WorkoutStatus {
  completed,
  skipped,
}
