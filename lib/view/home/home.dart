import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:totalx/view/home/widgets/add_user_widget.dart';
import 'package:totalx/view/home/widgets/sorting_dialogue.dart';

class Home extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {"name": "Martin Dokidis", "age": 34, "image": "assets/images/person.jpg"},
    {"name": "Marilyn Rosser", "age": 34, "image": "assets/images/person.jpg"},
    {
      "name": "Cristofer Lipshutz",
      "age": 34,
      "image": "assets/images/person.jpg"
    },
    {"name": "Wilson Botosh", "age": 34, "image": "assets/images/person.jpg"},
    {"name": "Anika Saris", "age": 34, "image": "assets/images/person.jpg"},
    {"name": "Phillip Gouse", "age": 34, "image": "assets/images/person.jpg"},
    {"name": "Wilson Bergson", "age": 34, "image": "assets/images/person.jpg"},
  ];

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.white),
            SizedBox(width: 5),
            Text(
              'Nilambur',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by name...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SortingDialogue();
                      },
                    );
                  },
                  icon: const Icon(EneftyIcons.filter_outline),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Users Lists',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          user['image'],
                        ),
                      ),
                      title: Text(
                        user['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Age: ${user['age']}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddUserWidget(),
              );
            },
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(
          EneftyIcons.add_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}
