import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/app_theme.dart';
import 'package:cmon_chef/core/format_string.dart';
import 'package:cmon_chef/core/widgets/back_button.dart';
import 'package:cmon_chef/features/recipe/data/models/offline_recipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OfflineRecipeScreen extends StatefulWidget {
  final Offlinerecipe recipe;
  final int index;
  const OfflineRecipeScreen({
    Key? key,
    required this.recipe,
    required this.index,
  }) : super(key: key);

  @override
  State<OfflineRecipeScreen> createState() => _OfflineRecipeScreenState();
}

class _OfflineRecipeScreenState extends State<OfflineRecipeScreen> {
  late Box<Offlinerecipe> box;
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
    var instructionsList =
        FormatString.formatInstructions(widget.recipe.instructions);
    var occasions = FormatString.formatOccasions(widget.recipe.occasions);
    var dishTypes = FormatString.formatOccasions(widget.recipe.dishTypes);
    var diets = FormatString.formatOccasions(widget.recipe.diets);
    var ingredients =
        FormatString.getIngredients(widget.recipe.analyzedInstructions);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              // controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration:const  BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(
                        image: AssetImage(recipeImage),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.025,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.recipe.title,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.watch_later_outlined),
                                  Text(' ${widget.recipe.readyInMinutes} mins'),
                                ],
                              ),
                              const Spacer(),
                              //
                              IconButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    deleteBottomSheet(size, context),
                                  );
                                },
                                icon:const  Icon(
                                  Icons.download_done_rounded,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppTheme.subHeadingText(size, 'Ingredients'),
                        Wrap(
                          children: ingredients
                              .map(
                                (e) => Container(
                                  margin:const  EdgeInsets.all(4.0),
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.primary,
                                      )),
                                  child: Text(' $e '),
                                ),
                              )
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTheme.subHeadingText(size, 'Instructions'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: instructionsList
                                    .map((e) => Text('* $e\n'))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        AppTheme.subHeadingText(size, 'Occasions'),
                        Text(occasions),
                        AppTheme.subHeadingText(size, 'Dish Types'),
                        Text(dishTypes),
                        AppTheme.subHeadingText(size, 'Diets'),
                        Text(diets),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const CustomBackButton(),
          ],
        ),
      ),
    );
  }

  Widget deleteBottomSheet(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.3,
      padding: EdgeInsets.all(size.width * 0.1),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Are you sure, you want to remove this recipe from Offline ?',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                ),
                onPressed: () {
                  removeRecipeFromHive(widget.index);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child:const  Text('Yes, Remove'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'No, Cancel',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
