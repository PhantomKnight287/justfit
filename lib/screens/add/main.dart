import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justfit/constants/main.dart';

class AddNewWorkout extends StatefulWidget {
  const AddNewWorkout({super.key});

  @override
  State<AddNewWorkout> createState() => _AddNewWorkoutState();
}

class _AddNewWorkoutState extends State<AddNewWorkout> {
  TextEditingController _nameController = TextEditingController();
  // probably a bad idea ig
  List<String> emojis = [];
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
            onPressed: () {},
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
                  style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 0),
                    ),
                    fillColor: Color(0xff212121),
                    hintText: "Abs, Arms, Legs",
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Emojis",
                  style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w700),
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
                            constraints: BoxConstraints(maxHeight: 80, maxWidth: 80, minHeight: 80, minWidth: 80),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(color: Color(0xff212121), borderRadius: BorderRadius.circular(8), border: emojis.contains(e) ? Border.all(color: Colors.green, width: 2) : null),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
