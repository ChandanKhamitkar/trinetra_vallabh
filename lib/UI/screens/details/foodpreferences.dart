// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';

class FoodPreferencePage extends StatefulWidget {
  const FoodPreferencePage({super.key});

  @override
  State<FoodPreferencePage> createState() => _FoodPreferencePageState();
}

class _FoodPreferencePageState extends State<FoodPreferencePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Search',
                                )),
                            Expanded(
                              child: ListView(
                                children: const <Widget>[
                                  Card(
                                    child: ListTile(
                                      title: Text('Peanut Allergy'),
                                      trailing: Icon(Icons.delete),
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text('Soy Allergy'),
                                      trailing: Icon(Icons.delete),
                                    ),
                                  ),
                                ],
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: 'Search',
                                )),
                            Expanded(
                              child: ListView(
                                children: const <Widget>[
                                  Card(
                                    child: ListTile(
                                      title: Text('Biryani'),
                                      trailing: Icon(Icons.delete),
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text('Gulab Jamun'),
                                      trailing: Icon(Icons.delete),
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text('Soft Drinks'),
                                      trailing: Icon(Icons.delete),
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text('Rasmalai'),
                                      trailing: Icon(Icons.delete),
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text('Ice-Cream'),
                                      trailing: Icon(Icons.delete),
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }
}
