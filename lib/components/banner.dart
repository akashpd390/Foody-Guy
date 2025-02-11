import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.purple,
      ),
      child: Stack(
        children: [
          Positioned(
              top: 32,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Text(
                    "Cook the Best \nrecipes at home",
                    style: TextStyle(
                        height: 1.1,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:const  EdgeInsets.symmetric(horizontal: 33),
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child:const  Text("Explore",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  )
                ],
              )),
          Positioned(
            top: 0,
            bottom: 0,
            right: -20,
            child: Image.network("https://pngimg.com/d/chef_PNG190.png"))
        ],
      ),
    );
  }
}
