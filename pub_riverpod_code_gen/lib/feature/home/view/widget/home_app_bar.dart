import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1C2834),
      title: SvgPicture.network(
        'https://pub.dev/static/hash-6pt3begn/img/pub-dev-logo.svg',
        width: 150,
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
