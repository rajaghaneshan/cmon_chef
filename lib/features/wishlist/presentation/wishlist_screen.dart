import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/core/widgets/loading_indicator.dart';
import 'package:cmon_chef/features/recipe/presentation/recipe_screen_id.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your Favourites',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(homeController.currentUser.value!.id)
                      .collection('wishlist')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LoadingIndicator();
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.03,
                        mainAxisSpacing: size.width * 0.03,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      controller: _scrollController,
                      // physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return wishlistCard(data);
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget wishlistCard(QueryDocumentSnapshot<Object?> data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreenId(
              id: data['id'],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.5, color: AppColors.accent),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 2),
              color: AppColors.accent,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    data['photoUrl'],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Title ${data['title']}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
