import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:justfit/screens/add/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(
            "JustFit",
            style: GoogleFonts.hankenGrotesk(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade900,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey.shade100),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: DotNavigationBar(
          backgroundColor: Color(0xff212121),
          currentIndex: currentIndex, enablePaddingAnimation: false, splashColor: Colors.transparent,
          onTap: (p0) {
            if (p0 == 1) {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) {
                  return AddNewWorkout();
                },
              ));
            }
          },
          dotIndicatorColor: Colors.black,
          // enableFloatingNavBar: false
          items: [
            DotNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                selectedColor: Colors.white),

            /// Likes
            DotNavigationBarItem(
              icon: Image.asset("assets/risky.png"),
            ),

            /// Search
            DotNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                selectedColor: Colors.white),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minWidth: 85,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xff495057),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "69",
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Workouts",
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minWidth: 85,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xff495057),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "420",
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Minutes",
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
