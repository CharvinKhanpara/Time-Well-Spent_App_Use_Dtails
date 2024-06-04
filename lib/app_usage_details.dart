import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:usage_stats/usage_stats.dart';
// import 'package:usage_stats/usage_stats.dart';

class AppUsageDetails extends StatefulWidget {
  final Application application;
  const AppUsageDetails({super.key, required this.application});

  @override
  State<AppUsageDetails> createState() => _AppUsageDetailsState();
}

class _AppUsageDetailsState extends State<AppUsageDetails> {
  UsageInfo? appUasgeInfo;

  getUsage() async {
    DateTime endDate = new DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    // query usage stats
    List<UsageInfo> usageStats =
        await UsageStats.queryUsageStats(startDate, endDate);

    if (usageStats.isNotEmpty) {
      usageStats.forEach((element) {
        if (element.packageName == widget.application.packageName) {
          setState(() {
            appUasgeInfo = element;
          });
        }
      });
    }

    print('VALUE INSIDE APP USAGE INFO ${appUasgeInfo!.packageName}');
  }

  @override
  void initState() {
    super.initState();
    getUsage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.application.appName,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    'Screen Time :',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    '${(int.parse(appUasgeInfo!.totalTimeInForeground!) / 1000 / 60).toStringAsFixed(2)} min:sec',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    'Last Used Time :',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    '${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(int.parse(appUasgeInfo!.lastTimeUsed!)))}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}








// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:usage_stats/usage_stats.dart';

// class AppUsageDetails extends StatefulWidget {
//   final Application application;
//   const AppUsageDetails({super.key, required this.application});

//   @override
//   State<AppUsageDetails> createState() => _AppUsageDetailsState();
// }

// class _AppUsageDetailsState extends State<AppUsageDetails> {
//   UsageInfo? appUsageInfo;

//   Future<void> getUsage() async {
//     DateTime endDate = DateTime.now();
//     DateTime startDate =
//         DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

//     // Query usage stats
//     List<UsageInfo> usageStats =
//         await UsageStats.queryUsageStats(startDate, endDate);

//     if (usageStats.isNotEmpty) {
//       for (var element in usageStats) {
//         if (element.packageName == widget.application.packageName) {
//           setState(() {
//             appUsageInfo = element;
//           });
//           break;
//         }
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUsage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.application.appName),
//       ),
//       body: Container(
//         child: appUsageInfo != null
//             ? Column(
//                 children: [
//                   const SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.5,
//                         child: const Text(
//                           'Last Used Time:',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.3,
//                         child: Text(
//                           DateFormat('dd-MM-yyyy HH:mm:ss').format(
//                             DateTime.fromMillisecondsSinceEpoch(
//                               int.parse(appUsageInfo!.lastTimeUsed!),
//                             ),
//                           ),
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             : const Center(
//                 child: CircularProgressIndicator(),
//               ),
//       ),
//     );
//   }
// }
