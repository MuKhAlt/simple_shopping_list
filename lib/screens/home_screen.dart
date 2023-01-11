import 'package:flutter/material.dart';
import 'package:simple_shopping_list/main.dart';
import 'package:simple_shopping_list/models/shopping_list.dart';
import 'package:simple_shopping_list/screens/shopping_list_screen.dart';
import 'package:simple_shopping_list/widgets/custom_material_app.dart';
import 'package:simple_shopping_list/widgets/new_shopping_list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ShoppingList> shoppingLists = objectbox.shoppingListBox.getAll();
  bool displayNewShoppingCard = false;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      body: SafeArea(
        child: Stack(
            children: [
                  ListView.separated(
                      itemCount: shoppingLists.length,
                      itemBuilder: ((context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(shoppingLists[index].name),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                ),
                                onPressed: () {
                                  objectbox.shoppingListBox
                                      .remove(shoppingLists[index].id);
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => ShoppingListScreen(
                                          name: shoppingLists[index].name,
                                        )),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height:
                                  (index == shoppingLists.length - 1) ? 100 : 0,
                            )
                          ],
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      }),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          displayNewShoppingCard = true;
                        });
                      },
                    ),
                  ),
                ] +
                addNewShoppingListCard()),
      ),
    );
  }

  List<Widget> addNewShoppingListCard() {
    if (displayNewShoppingCard) {
      return [
        NewShoppingListCard(
          context: context,
          onBack: _handleShoppingListCardOnBack,
        ),
      ];
    } else {
      return [];
    }
  }

  void _handleShoppingListCardOnBack() {
    setState(() {
      displayNewShoppingCard = false;
    });
  }
}
