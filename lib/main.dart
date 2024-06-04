import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:twsapp/app_usage_details.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:twsapp/chatbot/chat_screen.dart'; // Adjusted the import path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Time Well Spent'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getAllTheInstalledApps();
  }

  getAllTheInstalledApps() async {
    UsageStats.grantUsagePermission();

    bool isPermission = UsageStats.checkUsagePermission() as bool;
    if (isPermission) {
      print("Tracking usage");
    } else {
      print("Permission is required to track usage");
    }

    List<Application> apps = await DeviceApps.getInstalledApplications(
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true,
        includeAppIcons: true);
    print('LENGTH OF THE APPS ${apps.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: DeviceApps.getInstalledApplications(
              includeSystemApps: true,
              onlyAppsWithLaunchIntent: true,
              includeAppIcons: true),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(),
                child: const Text('we do not have any apps installed'),
              );
            }
            List<Application> apps = snapshot.data as List<Application>;
            return Container(
              child: ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: apps.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AppUsageDetails(
                              application: apps[index],
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 114, 141, 250),
                        ),
                        child: Center(
                          child: ListTile(
                            leading: Image.memory(
                                (apps[index] as ApplicationWithIcon).icon),
                            title: Container(
                              width: MediaQuery.of(context).size.width * 0.05,
                              child: Text(
                                '${apps[index].appName}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                apps[index].openApp();
                              },
                              icon: const Icon(Icons.open_in_new),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(17.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChatScreen(),
              ),
            );
          },
          child: const Icon(Icons.chat),
          backgroundColor: Color.fromARGB(255, 184, 236, 243),
        ),
      ),
    );
  }
}









// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/material.dart';
// import 'package:twsapp/app_usage_details.dart';
// import 'package:usage_stats/usage_stats.dart';
// // import 'package:twsapp/app_usage_details.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Time Well Spent'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     getAllTheInstalledApps();
//   }

//   getAllTheInstalledApps() async {
//     // grant usage permission - opens Usage Settings
//     UsageStats.grantUsagePermission();

//     // check if permission is granted
//     bool isPermission = UsageStats.checkUsagePermission() as bool;
//     if (isPermission) {
//       // Permission is granted, proceed with tracking usage
//       print("Tracking usage");
//     } else {
//       // Permission is not granted, show a message or request permission
//       print("Permission is required to track usage");
//     }

//     List<Application> apps = await DeviceApps.getInstalledApplications(
//         includeSystemApps: true,
//         onlyAppsWithLaunchIntent: true,
//         includeAppIcons: true);
//     print('LENGTH OF THE APPS ${apps.length}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: Text(widget.title),
//         ),
//         body: Container(
//           child: FutureBuilder(
//             future: DeviceApps.getInstalledApplications(
//                 includeSystemApps: true,
//                 onlyAppsWithLaunchIntent: true,
//                 includeAppIcons: true),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Container(
//                   decoration: const BoxDecoration(),
//                   child: const Text(
//                     'we do not have any apps installed',
//                   ),
//                 );
//               }
//               List<Application> apps = snapshot.data as List<Application>;
//               return Container(
//                 child: ListView.builder(
//                   physics: const ScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: apps.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return AppUsageDetails(
//                                 application: apps[index],
//                               );
//                             },
//                           ),
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(3.0),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.1,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                               15,
//                             ),
//                             color: Color.fromARGB(255, 114, 141, 250),
//                           ),
//                           child: Center(
//                             child: ListTile(
//                               leading: Image.memory(
//                                   (apps[index] as ApplicationWithIcon).icon),
//                               title: Container(
//                                 width: MediaQuery.of(context).size.width * 0.05,
//                                 child: Text('${apps[index].appName}',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color.fromARGB(
//                                             255, 255, 255, 255))),
//                               ),
//                               trailing: IconButton(
//                                 onPressed: () {
//                                   apps[index].openApp();
//                                 },
//                                 icon: Icon(
//                                   Icons.open_in_new,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ));
//   }
// }
