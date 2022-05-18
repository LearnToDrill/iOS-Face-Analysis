import 'package:face_analysis/Resources/commonWidgets.dart';
import 'package:face_analysis/Resources/constants.dart';
import 'package:face_analysis/Screens/Menu/profileScreen.dart';
import 'package:face_analysis/Screens/loginScreen.dart';
import 'package:face_analysis/Screens/Menu/menuItem.dart';
import 'package:face_analysis/Screens/registrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Resources/commonClass.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const SizedBox(
    height: 57,
    child: Logo(),
  );

  final List<Widget> pages = [
    HomeScreenPage(),
    HomeScreenPage(),
    HomeScreenPage(),
  ];

  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: customSearchBar,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: IconButton(
                      onPressed: () {
                        // Search contents
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    title: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 4.0),
                          hintText: '',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                } else if (customIcon.icon == Icons.cancel) {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const SizedBox(
                    height: 57,
                    child: Logo(),
                  );
                }
              });
            },
            icon: customIcon,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        backgroundColor: Color(0xFF6D0162).withOpacity(0.55),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Expert Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Track Progress',
          ),
        ],
        unselectedLabelStyle:
            Constants.customTitleStyle(isUnderlined: false, fontSize: 12),
        selectedLabelStyle:
            Constants.customTitleStyle(isUnderlined: false, fontSize: 12),
        currentIndex: selectedPageIndex,
        enableFeedback: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFF63B4FF),
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
      ),
      bodyChild: pages.elementAt(selectedPageIndex),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF6D0162).withOpacity(0.8),
              ),
              child: Text(
                'Face\nAnalysis\nYour Complete\nBeauty Guide',
                textAlign: TextAlign.justify,
                style: Constants.customTitleStyle(
                    isUnderlined: true, fontSize: 18),
              ),
            ),
            MenuItem(
              imageName: "images/femaleicon.png",
              itemTitle: "Profile",
              onTapItem: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen();
                    },
                  ),
                );
              },
            ),
            MenuItem(
              imageName: "images/book.png",
              itemTitle: "Glossary",
              onTapItem: () {},
            ),
            MenuItem(
              imageName: "images/question.png",
              itemTitle: "Update your answers",
              onTapItem: () {},
            ),
            MenuItem(
              imageName: "images/gallery.png",
              itemTitle: "Track Progress",
              onTapItem: () {},
            ),
            MenuItem(
              imageName: "images/settings.png",
              itemTitle: "Settings",
              onTapItem: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget MenuItem(
    {required String imageName,
    required String itemTitle,
    required void Function() onTapItem}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: ImageIcon(
        AssetImage(imageName),
        color: Constants.themeColor,
        size: 30,
      ),
      title: Text(
        itemTitle,
        style: Constants.customTitleStyle(
            isUnderlined: false, fontSize: 16, textColor: Colors.black),
      ),
      onTap: onTapItem,
    ),
  );
}

class HomeScreenPage extends StatelessWidget {
  HomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text(
                "Personalized Beauty Plan For You",
                style: Constants.customTitleStyle(
                    isUnderlined: false, fontSize: 18),
              ),
            ),
          ),
          Visibility(
            replacement: SizedBox.shrink(),
            visible: didUserSkipScanning,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.FaceScanning.name);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset("images/faceScanner.png"),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Text(
                            "Scan your face to get personalized\ntutorials",
                            style: Constants.customTitleStyle(
                                isUnderlined: false,
                                fontSize: 16,
                                isBold: false),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: itemsContainer(
                  child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                "Start your glow journey today!!",
                                style: Constants.customTitleStyle(
                                    isUnderlined: false,
                                    fontSize: 14,
                                    isBold: true,
                                    textColor: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: SizedBox(
                                width: 30,
                                child: Image.asset("images/scan.png"),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            iconTitleButton(
                                title: "Makeup\nRoutine",
                                btnIcon: Image.asset("images/routine.png"),
                                btnAction: () {}),
                            iconTitleButton(
                                title: "Product\nTips",
                                btnIcon: Image.asset("images/tips.png"),
                                btnAction: () {}),
                            iconTitleButton(
                                title: "Makeup\nProducts",
                                btnIcon: Image.asset("images/products.jpg"),
                                btnAction: () {},
                                hasCalendarIcon: false),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            child: Text(
              "What have we personalised for you?",
              textAlign: TextAlign.center,
              style:
                  Constants.customTitleStyle(isUnderlined: false, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: itemsContainer(
                  child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            iconTitleButton(
                                title: "Facial\nExercises",
                                btnIcon: Image.asset("images/exercises.png"),
                                btnAction: () {}),
                            iconTitleButton(
                                title: "Skincare\nRoutines",
                                btnIcon: Image.asset("images/skincare.png"),
                                btnAction: () {}),
                            iconTitleButton(
                                title: "Lifestyle\nTips",
                                btnIcon: Image.asset("images/lifestyle.png"),
                                btnAction: () {}),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
