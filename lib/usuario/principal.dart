import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('HOME',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.person),
            onPressed: () {
              // Acciones del ícono
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Número de elementos en la lista
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(9.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 30, // Ajusta el tamaño como sea necesario
              ),
              title: const Text('USER'),
              subtitle: const Text('Título'),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('Fecha'),
                  Text('Hora'),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.green,
        type: BottomNavigationBarType.fixed, // Esto es necesario para más de 3 items
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Trámites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crisis_alert),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pagos',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
