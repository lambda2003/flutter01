import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modal Buttom Sheet')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showType1BottomSheet(),
              child: Text('Rectangle'),
            ),

            ElevatedButton(
              onPressed: () => showType2BottomSheet(),
              child: Text('Rounded'),
            ),

             ElevatedButton(
              onPressed: () => showGet1BottomSheet(),
              child: Text('Getx : Rectangle'),
            ),
          ],
        ),
      ),
    );
  }

  // === Functions

  // Without Getx
  showType1BottomSheet(){
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          width: 300,
          height: 200,
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Type #1 Bottom SHeet'),
              ElevatedButton(
                onPressed: ()=>Get.back(),
                child: Text('Close')
              )
            ],
          )
        );  
      },
    );
  }


  // Without Getx
  showType2BottomSheet(){
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          // color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Type #1 Bottom SHeet'),
              ElevatedButton(
                onPressed: ()=>Get.back(),
                child: Text('Close')
              )
            ],
          )
        );  
      },
    );
  }


  // With Getx
  showGet1BottomSheet(){
    Get.bottomSheet(
      Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          // color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 150,
                child: Column(
                  children: [
                    Text('Type #1 Bottom SHeet'),
                    SizedBox(
                      width:299,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )
                        ),
                        onPressed: (){}, 
                        child: Text('TEST')
                      )
                    ),
                    SizedBox(
                      width:299,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            
                            borderRadius: BorderRadius.zero,
                          )
                        ),
                        onPressed: (){}, 
                        child: Text('TEST')
                      )
                    ),
                  ],
                )),
                
              IconButton(
                onPressed: ()=>Get.back(),
                icon: Icon(Icons.arrow_downward_rounded)
              )
            ],
          )
        ),
        barrierColor: Colors.green,
        
    );
  }


}
