import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tab_screen.dart';
import './widgets/new_note.dart';
import './models/todo_provider.dart';
import './models/note.dart';
import './helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => TodoProvider(),
        ),
        ChangeNotifierProvider(create: (ctx) => Notes())
      ],
      child: MaterialApp(
        title: 'ToDo List',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
            fontFamily: 'OpenSans',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
              },
            ),
            textTheme: ThemeData.light()
                .textTheme
                .copyWith(headline6: TextStyle(fontSize: 18)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light()
                    .textTheme
                    .copyWith(headline6: TextStyle(fontSize: 20)))),
        home: TabsScreen(),
        routes: {
          NewNote.routeName: (ctx) => NewNote(),
        },
      ),
    );
  }
}
