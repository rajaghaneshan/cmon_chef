import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/widgets/appbar_title.dart';
import 'package:cmon_chef/features/network/presentation/pages/offline_recipe_screen.dart';
import 'package:cmon_chef/features/network/presentation/widgets/empty_downloads_screen.dart';
import 'package:cmon_chef/features/recipe/data/models/offline_recipe.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  _OfflineScreenState createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  late final Box<Offlinerecipe> box;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box(recipeBox);
  }

  removeRecipeFromHive(int index) {
    box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: appBarTitleText(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02,
            vertical: 20,
          ),
          child: Column(
            children: [
              Text(
                'You\'re Offline',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (BuildContext context, Box value, _) {
                  if (value.isEmpty) {
                    return EmptyDownloadsScreen(size: size);
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      Offlinerecipe? currentData = box.getAt(index);
                      // print('$index ${currentData!.image}');
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OfflineRecipeScreen(
                                recipe: currentData!,
                                index: index,
                              ),
                            ),
                          );
                        },
                        title: Text(currentData!.title),
                        subtitle:
                            Text('Prep time: ${currentData.readyInMinutes}'),
                        trailing: InkWell(
                          onTap: () {
                            removeRecipeFromHive(index);
                          },
                          child: const Icon(
                            Icons.delete_outline,
                            color: AppColors.primary,
                            // size: 15,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
