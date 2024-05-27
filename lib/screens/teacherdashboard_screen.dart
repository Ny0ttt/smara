// import 'package:education_app/constants/color.dart';
// import 'package:education_app/dbHelper/mongodb.dart';
// import 'package:education_app/dbHelper/userprovider.dart';
// // import 'package:education_app/constants/icons.dart';
// // import 'package:education_app/models/category.dart';
// import 'package:education_app/models/coursework.dart';
// import 'package:education_app/models/coursework_model.dart';
// import 'package:education_app/models/lesson.dart';
// // import 'package:education_app/models/users_modeltemporary.dart';
// import 'package:education_app/routes/route_helper.dart';
// import 'package:education_app/widgets/circle_button.dart';
// import 'package:education_app/widgets/custom_icon_button.dart';
// // import 'package:education_app/widgets/custom_video_player.dart';
// import 'package:education_app/widgets/search_testfield.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:smart_hub/models/materialnotice_model.dart';
//import 'package:video_player/video_player.dart';

import '../constants/color.dart';
import '../dbHelper/mongodb.dart';
import '../dbHelper/userprovider.dart';
import '../models/coursework_model.dart';
import '../widgets/circle_button.dart';
import 'parentmaterialnotice_screen.dart';
import 'teachercoursework_screen.dart';

class TeacherDashboard extends StatefulWidget {
  // final String title;
  const TeacherDashboard({
    Key? key,
    // required this.title,
  }) : super(key: key);

  @override
  _TeacherDashboard createState() => _TeacherDashboard();
}

class _TeacherDashboard extends State<TeacherDashboard> {
  // ignore: unused_field
  int _selectedTag = 0;

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  static Widget? currentwidget;

  @override
  void initState() {
    super.initState();
    currentwidget = CourseworkList(function: _changewidget);
  }

  void _changewidget(Widget widget) {
    setState(() {
      currentwidget = widget;
    });
  }

  //  Widget courselistwidget = CourseworkList(function: _changewidget);

  @override
  Widget build(BuildContext context) {
    // currentwidget = CourseworkList(function: _changewidget,);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.1, 0.5],
                      colors: [
                        Color(0xff886ff2),
                        Color(0xff6849ef),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello,\nGood Morning",
                            textScaler: const TextScaler.linear(0.8),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          CircleButton(
                            icon: Icons.notifications,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          // "Aly Zanaty",
                          // "{$context.watch<UserProvider>().name}",
                          '${context.watch<UserProvider>().nickname}',
                          key: const Key('counterState'),
                          textScaler: const TextScaler.linear(3.5),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(child: currentwidget),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseworkList extends StatefulWidget {
  final Function function;
  const CourseworkList({Key? key, required this.function}) : super(key: key);

  @override
  _CourseworkList createState() => _CourseworkList();
}

class _CourseworkList extends State<CourseworkList> {
  @override
  Widget build(BuildContext context) {
    return
        // Column(children: [
        Expanded(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Active Courseworks",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     "See All",
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodyMedium
              //         ?.copyWith(color: kPrimaryColor),
              //   ),
              // )
            ],
          ),
        ),
        Expanded(
            child: FutureBuilder(
                // future: MongoDatabase.getcourseworkbyteacherid(m.ObjectId.parse(
                //     '${context.watch<UserProvider>().id}'.substring(10, 34))),
                future: Future.wait([
                  MongoDatabase.getcourseworkbyteacherid(m.ObjectId.parse(
                      '${context.watch<UserProvider>().id}'.substring(10, 34))),
                  MongoDatabase.getmaterialnoticebyteacherid(m.ObjectId.parse(
                      '${context.watch<UserProvider>().id}'.substring(10, 34))),
                ]),
                builder: (context, AsyncSnapshot snapshot) {
                  // print('${context.read<UserProvider>().id}'.substring(10, 34));
                  // print(m.ObjectId.parse('${context.watch<UserProvider>().id}'.substring(10, 34)));

                  if (snapshot.hasData) {
                    // var totalData = snapshot.data.length;

                    final List<Map<String, dynamic>> items1 = snapshot.data![0];
                    final List<Map<String, dynamic>> items2 = snapshot.data![1];

                    final List<CourseworkModel> courseworklist =
                        items1.map((map) {
                      return CourseworkModel.fromJson(map);
                    }).toList();

                    final List<MaterialNoticeModel> materialnoticelist =
                        items2.map((map) {
                      return MaterialNoticeModel.fromJson(map);
                    }).toList();

                    Set<DateTime> courseworkuniquedates = {};
                    Set<DateTime> materialnoticeuniquedates = {};

                    courseworkuniquedates =
                        courseworklist.map((e) => e.duedate).toSet();
                    materialnoticeuniquedates =
                        materialnoticelist.map((e) => e.assigndate).toSet();
                    // print(courseworklist.map((e) => print(e[4])));
                    print(courseworklist.map((e) => e.duedate).toSet());
                    // var jsonstring = jsonEncode(courseworklist);
                    // print(jsonDecode(jsonstring).toString());
                    // print(courseworklist.toList().toString());

                    List<DateTime> courseworkuniqueDatesList =
                        courseworkuniquedates.toList();
                    List<DateTime> materialnoticeuniqueDatesList =
                        materialnoticeuniquedates.toList();
                    List<DateTime> uniquedates = [];

                    uniquedates.addAll(courseworkuniqueDatesList);
                    uniquedates.addAll(materialnoticeuniqueDatesList);

                    // print("snapshot data " + snapshot.data.toString());
                    return ListView.builder(
                        // itemCount: snapshot.data.length,
                        // itemCount: courseworkuniqueDatesList.length,
                        itemCount: uniquedates.length,
                        itemBuilder: (context, index) {
                          return ItemsContainer(
                            function: widget.function,
                            courseworklist: courseworklist,
                            materialnoticelist: materialnoticelist,
                            color: Colors.black,
                            date: uniquedates[index],
                          );
                        });
                  } else {
                    return const Center(
                      child: Text("No Data Available"),
                    );
                  }
                })),
      ],
    ));
  }
}

class ItemsContainer extends StatelessWidget {
  final Function function;
  final DateTime date;
  final List<MaterialNoticeModel> materialnoticelist;
  final List<CourseworkModel> courseworklist;
  final Color color;
  const ItemsContainer(
      {Key? key,
      required this.courseworklist,
      required this.color,
      required this.function,
      required this.date,
      required this.materialnoticelist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // "Add New Coursework",
                DateFormat('dd-MM-yyy').format(date),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        ListView(
            shrinkWrap: true, // Set to true to shrink-wrap the content
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            children: courseworklist
                .where((map) => map.duedate.isAtSameMomentAs(date))
                .map((product) {
              return CourseworkContainer(
                  function: function,
                  // coursework: CourseworkModel.fromJson(
                  //     // snapshot.data[index]), color: _color.elementAt(int.parse(index.toString()[0])));
                  //     snapshot.data[index]),
                  coursework: product,
                  color: Colors.black);
            }).toList()),
        ListView(
            shrinkWrap: true, // Set to true to shrink-wrap the content
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            children: materialnoticelist
                .where((map) => map.assigndate.isAtSameMomentAs(date))
                .map((product) {
              return MaterialNoticeContainer(
                  function: function,
                  materialnotice: product,
                  color: Colors.black);
            }).toList()),
      ],
    );
  }
}
