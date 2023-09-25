import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:justfit/components/subtitle.dart';
import 'package:justfit/constants/main.dart';
import 'package:justfit/models/workout.dart';
import 'package:justfit/screens/workout/main.dart';
import 'package:path_provider/path_provider.dart';

class AddNewWorkout extends StatefulWidget {
  const AddNewWorkout({super.key});

  @override
  State<AddNewWorkout> createState() => _AddNewWorkoutState();
}

class _AddNewWorkoutState extends State<AddNewWorkout> {
  final TextEditingController _nameController = TextEditingController();

  // probably a bad idea ig
  List<String> emojis = [];
  final TextStyle _textStyle = GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w700);
  // int exercisesCount = 0;
  List<Exercise> exercises = [];

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Workout",
          style: GoogleFonts.hankenGrotesk(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              if (_nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Name is Empty'),
                ));
                return;
              }
              if (emojis.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select Emojis'),
                  ),
                );
                return;
              }
              if (exercises.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please add an exercise.'),
                  ),
                );
                return;
              }
              for (var i = 0; i < exercises.length; i++) {
                final exercise = exercises[i];
                if (exercise.name == null || exercise.name!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please Enter Name of Exercise'),
                    ),
                  );
                  return;
                }
                if (exercise.breakDuration == null || exercise.breakDuration!.isNaN) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please Enter a valid number in break duration.'),
                    ),
                  );
                  return;
                }
                if (exercise.repetition == null || exercise.repetition!.isNaN) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please Enter a valid number in repetition.'),
                    ),
                  );
                  return;
                }
                final workout = Workout();
                workout.emojis = emojis;
                workout.name = _nameController.text.trim();
                workout.exercises = exercises;
                final dir = await getApplicationDocumentsDirectory();

                final isar = await Isar.open(
                  [WorkoutSchema],
                  directory: dir.path,
                );

                await isar?.writeTxn(() async {
                  final id = await isar?.workouts.put(workout);
                  if (id == null) return;
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return WorkOutInfo(id: id);
                    },
                  ));
                });
                await isar.close();
              }
            },
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(width: 0),
                    ),
                    fillColor: const Color(0xff212121),
                    hintText: "Abs, Arms, Legs",
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Emojis",
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      ...EMOJIS.map(
                        (e) => GestureDetector(
                          onTap: () {
                            if (emojis.contains(e)) {
                              emojis.remove(e);
                            } else {
                              emojis.add(e);
                            }
                            setState(() {});
                          },
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 80, maxWidth: 80, minHeight: 80, minWidth: 80),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration:
                                BoxDecoration(color: const Color(0xff212121), borderRadius: BorderRadius.circular(8), border: emojis.contains(e) ? Border.all(color: Colors.green, width: 2) : null),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/$e.png",
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Exercises",
                      style: _textStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        exercises.add(Exercise());
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                for (var i = 0; i < exercises.length; i++)
                  Column(
                    children: [
                      ListTile(
                        tileColor: const Color(0xff212121),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            exercises[i].name ?? "N/A",
                            style: _textStyle,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.height / 2,
                                color: const Color(0xff212121),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        initialValue: exercises[i].name,
                                        decoration: InputDecoration(
                                          hintText: "Name of Exercise",
                                          filled: true,
                                          fillColor: const Color(0xff495057),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                          ),
                                          hintStyle: _textStyle,
                                          contentPadding: const EdgeInsets.only(left: 10),
                                        ),
                                        onChanged: (value) {
                                          exercises[i].name = value;
                                          setState(() {});
                                        },
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Break Duration",
                                                style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff989898)),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width / 2 - 20,
                                                child: TextFormField(
                                                  initialValue: exercises[i].breakDuration?.toString(),
                                                  keyboardType: TextInputType.number,
                                                  onChanged: (value) {
                                                    final val = int.tryParse(value);
                                                    if (val != null) {
                                                      exercises[i].breakDuration = val;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: const Color(0xff495057),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50.0),
                                                    ),
                                                    contentPadding: const EdgeInsets.only(left: 10),
                                                    hintStyle: _textStyle,
                                                    hintText: "in Seconds",
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Repetition",
                                                style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff989898)),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width / 2 - 20,
                                                child: TextFormField(
                                                  initialValue: exercises[i].repetition?.toString(),
                                                  onChanged: (value) {
                                                    final val = int.tryParse(value);
                                                    if (val != null) {
                                                      exercises[i].repetition = val;
                                                    }
                                                  },
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: const Color(0xff495057),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50.0),
                                                    ),
                                                    contentPadding: const EdgeInsets.only(left: 10),
                                                    hintStyle: _textStyle,
                                                    hintText: "Total Reps",
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Confirm",
                                            style: GoogleFonts.hankenGrotesk(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        subtitle: exercises[i].breakDuration == null && exercises[i].repetition == null ? null : SubTitle(breakDuration: exercises[i].breakDuration, reps: exercises[i].repetition),
                        trailing: i == 0
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  print(exercises);
                                  exercises.removeAt(i);
                                  setState(() {});
                                },
                              ),
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
