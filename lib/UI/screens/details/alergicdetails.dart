// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import 'package:trinetra_vallabh/UI/screens/home_screen.dart';

class AlergicDetailsPage extends StatefulWidget {
  const AlergicDetailsPage({super.key});

  @override
  State<AlergicDetailsPage> createState() => AlergicDetailsPageState();
}

class AlergicDetailsPageState extends State<AlergicDetailsPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _allergyController = TextEditingController();
  final TextEditingController _favoriteFoodController = TextEditingController();
  List<String> _allergies = [];
  List<String> _favoriteFoods = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _allergyController.dispose();
    _favoriteFoodController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _allergies = prefs.getStringList('allergies') ?? [];
      _favoriteFoods = prefs.getStringList('favoriteFoods') ?? [];
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('allergies', _allergies);
    prefs.setStringList('favoriteFoods', _favoriteFoods);
  }

  void _addAlergy() {
    if (_allergyController.text.trim().isNotEmpty) {
      setState(() {
        _allergies.add(_allergyController.text.trim());
        _allergyController.clear();
        _saveData();
      });
    }
  }

  void _addFavoriteFood() {
    if (_favoriteFoodController.text.trim().isNotEmpty) {
      setState(() {
        _favoriteFoods.add(_favoriteFoodController.text.trim());
        _favoriteFoodController.clear();
        _saveData();
      });
    }
  }

  void _deleteAlergy(int index) {
    setState(() {
      _allergies.removeAt(index);
      _saveData();
    });
  }

  void _deleteFavoriteFood(int index) {
    setState(() {
      _favoriteFoods.removeAt(index);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        rightImagePath: 'images/non-user.png',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 80,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sweet',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Hot',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black.withOpacity(0.5)),
                  )
                ],
              ),
              TabBar(
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(
                    text: 'Allergies',
                  ),
                  Tab(
                    text: 'Dietary Restrictions',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                                controller: _allergyController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Enter Allergy',
                                )),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: _addAlergy,
                                  child: Text('Add'),
                                )),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _allergies.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(_allergies[index]),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => _deleteAlergy(index),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Text('Favourite Foods',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900)),
                            ),
                            TextField(
                                controller: _favoriteFoodController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Enter Favorite Food',
                                )),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: _addFavoriteFood,
                                  child: Text('Add'),
                                )),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: _favoriteFoods.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(_favoriteFoods[index]),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () =>
                                              _deleteFavoriteFood(index),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ]),
                    ),
                    const Center(
                      child: Text("Dietary Restrictions"),
                    )
                  ],
                ),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveData();
          Timer(const Duration(seconds: 3), () {
            // ignore: avoid_print
            print('loggin');
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreenPage(),
            ),
          );
        },
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
