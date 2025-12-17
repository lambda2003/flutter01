import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ItemView extends StatefulWidget {
  final String url;
  final int w;
  final int h;
  const ItemView({super.key, required this.url,required this.w, required this.h});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  double scaleX = 1.0;
  double scaleY = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
        Container(
          child:PhotoView(
            imageProvider: NetworkImage(widget.url)
          )
        )
      
      // Stack(
      //   children: [
      //  InteractiveViewer(
      //   boundaryMargin: EdgeInsets.all(25.0+(25*(scaleX-1))),
      //   minScale: 1,
      //   maxScale: scaleX,
      //   child:
      //     Container(
      //       width: widget.w*scaleX,
      //       height: widget.h*scaleX,
      //       child: Transform.scale(
      //           scale: scaleX,
      //           child: Image.network(widget.url, fit: BoxFit.fill),
      //         ),
      //     ),
      //  ),
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.end,
      //       children: [
      //         IconButton(
      //           onPressed: () {
      //             scaleX+=0.3;
      //             scaleY++;
      //             setState(() {});
      //           },
      //           icon: Icon(Icons.zoom_in, color: Colors.white),
      //         ),
      //         IconButton(
      //           onPressed: () {
      //             if (scaleX > 1) {
      //               scaleX-=0.3;
      //               scaleY--;
      //               setState(() {});
      //             }
      //           },
      //           icon: Icon(Icons.zoom_out, color: Colors.white),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
     
    );
  }
}
