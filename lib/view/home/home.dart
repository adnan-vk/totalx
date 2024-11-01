import 'dart:developer';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/user_controller.dart';
import 'package:totalx/view/home/widgets/add_user_widget.dart';
import 'package:totalx/view/home/widgets/sorting_dialogue.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<UserController>(context, listen: false).getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context, listen: false);
    provider.getUsersAndSort("All");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search by name...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onChanged: (value) {
                        provider.search(value);
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SortingDialogue(
                          currentSortOption: provider.selectedSortOption,
                          onSelected: (sort) {
                            provider.getUsersAndSort(sort);
                          },
                        );
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
              child: Consumer<UserController>(
                builder: (context, value, child) => value.isloading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: value.searchlist.isEmpty
                            ? value.allUsers.length
                            : value.searchlist.length,
                        itemBuilder: (context, index) {
                          final user = value.searchlist.isEmpty
                              ? value.allUsers[index]
                              : value.searchlist[index];
                          if (index < value.allUsers.length) {
                            log("loading existing user ${user.name}");
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      user.image != null ? user.image! : ""),
                                  child: user.image == null
                                      ? const Icon(EneftyIcons.people_bold)
                                      : null,
                                ),
                                title: Text(
                                  "${user.name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Age: ${user.age}",
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const AddUserWidget(),
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
