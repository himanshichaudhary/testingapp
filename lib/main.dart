import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ApiCallSecond(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  const MyHomePage({required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  
  void _incrementCounter(){
    setState(() {
      
      counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have pushed the button this many times:"),
            
            Text('$counter')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add),),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive List'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context , index){
            return ListTile(
              title: Text('Item ${index + 1}'),
              subtitle: Text('This is the subtitle for item ${index + 1}'),
              leading: CircleAvatar(child: Text('${index + 1}'),)
            
            );
          },
        ),
      ),
    );
  }
}

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {

  List<dynamic> _post = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if(response.statusCode == 200){
      setState(() {
        _post = json.decode(response.body);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Data'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _post.length,
            itemBuilder: (context , index){
            return ListTile(
              title: Text('${_post[index]['title']}'),
            );
        }),
      ),
    );
  }
}

class CounterProvider with ChangeNotifier{

  int _counter = 0;

  int get counter => _counter;

  void increment(){
    _counter++;
    notifyListeners();
  }
}


class ProviderApp extends StatelessWidget {
  const ProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => CounterProvider() ,
    child: MaterialApp(
      home: CounterScreen(),
    ),
    );
  }
}
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider =  Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Satate Management '),
      ),
      body: Center(
        child: Column(
          children: [

            Text('Counter: ${counterProvider.counter}' , style: TextStyle(fontSize: 24),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: counterProvider.increment,
      child: Icon(Icons.add),),
    );
  }
}

class ApiCallSecond extends StatefulWidget {
  const ApiCallSecond({super.key});

  @override
  State<ApiCallSecond> createState() => _ApiCallSecondState();
}

class _ApiCallSecondState extends State<ApiCallSecond> {
   List<dynamic> _post = [];
   String input = "FlutterDevelopment".toLowerCase();
    Map<String, int> charSequence = {};
   List<String> repatedLetters = [];

    void foundChar(){
      for(var char in input.split('')){
        if(charSequence.containsKey(char)){
          charSequence[char] = charSequence[char]! + 1;
        }else{
          charSequence[char] = 1;
        }

      }
      repatedLetters = charSequence.keys.where((key) => charSequence[key]! > 1).toList();
    }
    
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foundChar();
    getPost();
  }

  Future<void> getPost() async{
     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
     if(response.statusCode == 200){
       setState(() {
         _post = json.decode(response.body);
       });
     }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Found Repated Char'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: repatedLetters.length,
            itemBuilder: (context , index){
          return Text(repatedLetters[index]);
        }),
      ),
    );
  }
}








// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
