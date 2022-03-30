import 'package:cycle/services/navigation.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:cycle/components/menu.dart';

class NavigationPage extends StatefulWidget {
  static const String id = 'navigation_page';
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as NavigationPageArguments;

    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text(
          'Navigation',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.lightBlue,
        child: ListView(
          children: args._stops
              .map(
                (e) => Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.pin_drop_outlined,
                      color: Color.fromRGBO(183, 28, 28, 1),
                    ),
                    title: const Text('One-line with leading widget'),
                    tileColor: Colors.lightBlueAccent,
                    onTap: () {
                      List<LatLng> stops = [];
                      stops.add(args._stops[args._stops.indexOf(e) - 1]);
                      stops.add(e);

                      Navigation navigation = Navigation(
                          args._context, stops, args._numberOfRiders);
                      navigation.navigate();
                    },
                  ),
                ),
              )
              .toList(),
        ),
        // ListView.separated(
        //   padding: const EdgeInsets.all(8),
        //   itemCount: args._stops.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Container(
        //       height: 50,
        //       color: const Color.fromARGB(255, 65, 33, 243),
        //       child: Center(
        //           child: Text(
        //               '${args._stops[index].latitude}${args._stops[index].longitude}')),
        //     );
        //   },
        //   separatorBuilder: (BuildContext context, int index) =>
        //       const Divider(),
        // ),
      ),
    );
  }
}

class NavigationPageArguments {
  List<LatLng> _stops = [];
  final _context;
  int _numberOfRiders;

  NavigationPageArguments(this._context, this._stops, this._numberOfRiders);
}

/////////////////////////////////////

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         ExtractArgumentsScreen.routeName: (context) =>
//             const ExtractArgumentsScreen(),
//       },
//       // Provide a function to handle named routes.
//       // Use this function to identify the named
//       // route being pushed, and create the correct
//       // Screen.
//       onGenerateRoute: (settings) {
//         // If you push the PassArguments route
//         if (settings.name == PassArgumentsScreen.routeName) {
//           // Cast the arguments to the correct
//           // type: ScreenArguments.
//           final args = settings.arguments as ScreenArguments;

//           // Then, extract the required data from
//           // the arguments and pass the data to the
//           // correct screen.
//           return MaterialPageRoute(
//             builder: (context) {
//               return PassArgumentsScreen(
//                 title: args.title,
//                 message: args.message,
//               );
//             },
//           );
//         }
//         // The code only supports
//         // PassArgumentsScreen.routeName right now.
//         // Other values need to be implemented if we
//         // add them. The assertion here will help remind
//         // us of that higher up in the call stack, since
//         // this assertion would otherwise fire somewhere
//         // in the framework.
//         assert(false, 'Need to implement ${settings.name}');
//         return null;
//       },
//       title: 'Navigation with Arguments',
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // A button that navigates to a named route.
//             // The named route extracts the arguments
//             // by itself.
//             ElevatedButton(
//               onPressed: () {
//                 // When the user taps the button,
//                 // navigate to a named route and
//                 // provide the arguments as an optional
//                 // parameter.
//                 Navigator.pushNamed(
//                   context,
//                   ExtractArgumentsScreen.routeName,
//                   arguments: ScreenArguments(
//                     'Extract Arguments Screen',
//                     'This message is extracted in the build method.',
//                   ),
//                 );
//               },
//               child: const Text('Navigate to screen that extracts arguments'),
//             ),
//             // A button that navigates to a named route.
//             // For this route, extract the arguments in
//             // the onGenerateRoute function and pass them
//             // to the screen.
//             ElevatedButton(
//               onPressed: () {
//                 // When the user taps the button, navigate
//                 // to a named route and provide the arguments
//                 // as an optional parameter.
//                 Navigator.pushNamed(
//                   context,
//                   PassArgumentsScreen.routeName,
//                   arguments: ScreenArguments(
//                     'Accept Arguments Screen',
//                     'This message is extracted in the onGenerateRoute '
//                         'function.',
//                   ),
//                 );
//               },
//               child: const Text('Navigate to a named that accepts arguments'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // A Widget that extracts the necessary arguments from
// // the ModalRoute.
// class ExtractArgumentsScreen extends StatelessWidget {
//   const ExtractArgumentsScreen({Key? key}) : super(key: key);

//   static const routeName = '/extractArguments';

//   @override
//   Widget build(BuildContext context) {
//     // Extract the arguments from the current ModalRoute
//     // settings and cast them as ScreenArguments.
//     final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(args.title),
//       ),
//       body: Center(
//         child: Text(args.message),
//       ),
//     );
//   }
// }

// // A Widget that accepts the necessary arguments via the
// // constructor.
// class PassArgumentsScreen extends StatelessWidget {
//   static const routeName = '/passArguments';

//   final String title;
//   final String message;

//   // This Widget accepts the arguments as constructor
//   // parameters. It does not extract the arguments from
//   // the ModalRoute.
//   //
//   // The arguments are extracted by the onGenerateRoute
//   // function provided to the MaterialApp widget.
//   const PassArgumentsScreen({
//     Key? key,
//     required this.title,
//     required this.message,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Text(message),
//       ),
//     );
//   }
// }

// // You can pass any object to the arguments parameter.
// // In this example, create a class that contains both
// // a customizable title and message.
// class ScreenArguments {
//   final String title;
//   final String message;

//   ScreenArguments(this.title, this.message);
// }
