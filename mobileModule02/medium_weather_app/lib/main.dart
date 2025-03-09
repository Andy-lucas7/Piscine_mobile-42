import 'package:flutter/material.dart';
import 'services/geolocator.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const TabBarApp(),
    );
  }
}

class TabBarApp extends StatefulWidget {
  const TabBarApp({super.key});

  @override
  State<TabBarApp> createState() => _TabBarAppState();
}

class _TabBarAppState extends State<TabBarApp> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _inputController;
  final LocationService _locationService = LocationService();
  late String value;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _inputController = TextEditingController();
    value = '';
    _findLocation();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _tabController.dispose();
    super.dispose();
  }

 
  Future<void> _findLocation() async {
    try {
      // Verifica e solicita permissões, se necessário
      if (!await _locationService.isLocationEnabled()) {
        throw Exception('Serviço de localização desabilitado');
      }

      // Obtém a localização atual
      final locationData = await _locationService.getCurrentLocation();
      
      if (locationData == null) {
        throw Exception('Não foi possível obter a localização');
      }

      // Extrai latitude e longitude
      final latitude = locationData.latitude?.toString() ?? 'desconhecido';
      final longitude = locationData.longitude?.toString() ?? 'desconhecido';

      // Atualiza a interface
      setState(() {
        value = 'Latitude: $latitude, Longitude: $longitude';
      });
    } catch (e) {
      print('Erro ao obter localização: $e');
      setState(() {
        value = 'Erro: ${e.toString()}';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 46, 46),
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            setState(() {
              value = _inputController.text;
            });
          },
        ),
        title: TextField(
          controller: _inputController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search location',
            hintStyle: TextStyle(color: Color.fromARGB(255, 165, 165, 165)),
            border: InputBorder.none,
          ),
          onSubmitted: (String value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_pin, color: Colors.white),
            onPressed: () {
              setState(() {
                _findLocation();
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Currently",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  Text(value, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  Text(value, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Weekly",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  Text(value, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 46, 46, 46),
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
          indicatorColor: Color.fromARGB(21, 0, 162, 255),
          labelColor: const Color.fromARGB(255, 0, 217, 255),
          dividerColor: const Color.fromARGB(255, 46, 46, 46),
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.access_time), text: 'Currently'),
            Tab(icon: Icon(Icons.today), text: 'Today'),
            Tab(icon: Icon(Icons.calendar_month), text: 'Weekly'),
          ],
        ),
      ),
    );
  }
}
