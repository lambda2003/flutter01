



import 'package:flutter/material.dart';

// class Page1 extends StatelessWidget implements PreferredSizeWidget {
class Page1 extends StatelessWidget {
  const Page1 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                spacing: 10,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/Lee.jpg'),
                    radius: 50,
                  ),
                  Divider(height: 5),
                  
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름', style: TextStyle(color: Colors.white)),
                  Text(
                    '이순신 장군',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text('전적', style: TextStyle(color: Colors.white)),
                  Text(
                    '62전 62승',
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.check_circle_outline),
                      Text('옥포해전'),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.check_circle_outline),
                      Text('사천포해전'),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.check_circle_outline),
                      Text('당포해전'),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.check_circle_outline),
                      Text('한산도대첩'),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.check_circle_outline),
                      Text('부산포해전'),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.check_circle_outline),
                      Text('명량해전'),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.check_circle_outline),
                      Text('노량해전'),
                    ],
                  ),
                ],
              ),
            )
                ],
              ),
            );

  }
  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}