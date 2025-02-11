import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback callback;

  const MyIconButton({super.key, required this.iconData, required this.callback});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white,
        fixedSize: const Size(50, 50),
      ),
      onPressed: callback,
      icon: Icon(iconData,size: 30,),
    );
  }
}
