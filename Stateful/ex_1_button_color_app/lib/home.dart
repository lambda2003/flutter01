import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool _isOn;
  late bool _isOk;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isOn = false;
    _isOk = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change button color & text"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TOP
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () => _updateState(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isOn ? Colors.orange : Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: !_isOn ? Text('로그인') : Text('로그아웃'),
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  void _updateState(context) {
    setState(() {
      if (_isOn) {
         _showDialog(context);
        
        _isOn = _isOk ? false : true;
        
      } else {
        _isOn = true;
      }
      // _sendMessage(context, "isOn => ${_isOn.toString()}");
    });
  }

  void _sendMessage(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(milliseconds: 500)),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.grey,

      builder: (context) {
        return AlertDialog(
        
          title: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            textDirection: TextDirection.ltr,
            
            children: [
              Icon(Icons.info),
              Text('Dialog Box', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600 ))
            ],
            
          ),
         
          
          
          content: const SizedBox(
            width: 100,
            height: 100,
          
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('정말로 로그아웃 하시겠습니까?')],
              ),
            ),
          ),
    
          backgroundColor: Colors.deepPurple[100],

          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isOk = true;
                });
                Navigator.of(context).pop();
              },

              child: Text('Yes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isOk = false;
                });
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

}
