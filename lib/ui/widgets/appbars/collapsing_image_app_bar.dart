import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/widgets/appbars/collapsing_title.dart';

class CollapsingImageAppBar extends StatelessWidget {
  const CollapsingImageAppBar({
    super.key,
    required this.title,
    required this.image,
    this.automaticallyImplyLeading = true,
    this.expandedHeight = 600,
    this.rightIcon,
    this.rightIconTap,
  });

  final String title;
  final String image;
  final bool automaticallyImplyLeading;
  final double expandedHeight;
  final IconData? rightIcon;
  final void Function()? rightIconTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: automaticallyImplyLeading,
      expandedHeight: expandedHeight,
      actions: rightIcon != null
          ? [
              GestureDetector(
                onTap: rightIconTap?.call,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(rightIcon),
                ),
              )
            ]
          : null,
      title: CollapsingTitle(
        child: Text(title, style: bold_20),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(16),
        title: CollapsingTitle(
          visibleOnCollapsed: true,
          child: Text(
            title,
            style: bold_20.copyWith(shadows: imageShadow),
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
