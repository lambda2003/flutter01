import 'package:flutter/material.dart';

class TopApp extends StatelessWidget implements PreferredSizeWidget {
  const TopApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('영웅 Card'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        // A widget to display before the toolbar's [title].
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              alignment: AlignmentGeometry.center,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
