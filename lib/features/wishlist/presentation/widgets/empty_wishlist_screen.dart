import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:flutter/material.dart';

class EmptyWishlistScreen extends StatelessWidget {
  const EmptyWishlistScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.6,
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.width * 0.1),
            child: Image.asset(
              emptyWishlist,
              fit: BoxFit.fitWidth,
            ),
          ),
          const Text(
            'No recipes in wishlist!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
