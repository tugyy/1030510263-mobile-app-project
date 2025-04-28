import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



// Erciyes Üniversitesi
// Mühendislik Fakültesi
// Bilgisayar Mühendisliği
// Mobile Application Development
// Dr. Öğr. Üyesi Fehim KÖYLÜ

// Proje ödevi

// 1030510263
// Tugay COŞKUN



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // Counter value
  int _counter = 0;
  
  // Key for storing the counter value in SharedPreferences
  static const String _counterKey = 'counter';

  @override
  void initState() {
    super.initState();
    // Load the saved counter value when the app starts
    _loadCounter();
  }

  // Load the counter value from SharedPreferences
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt(_counterKey) ?? 0;
    });
  }

  // Save the counter value to SharedPreferences
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_counterKey, _counter);
  }

  // Increment the counter and save the new value
  void _incrementCounter() {
    setState(() {
      _counter++;
      _saveCounter();
    });
  }

  // Decrement the counter and save the new value
  void _decrementCounter() {
    setState(() {
      _counter--;
      _saveCounter();
    });
  }

  // Reset the counter to zero and save
  void _resetCounter() {
    setState(() {
      _counter = 0;
      _saveCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Persistent Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            heroTag: 'reset',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
} 