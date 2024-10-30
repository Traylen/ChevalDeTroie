import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff17191b),
      body: SafeArea(
          child: Column(
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: const BoxDecoration(
                        // color: Color.fromARGB(164, 0, 0, 0),
                        ),
                    child: CarouselSlider.builder(
                      itemCount: 3,
                      options: CarouselOptions(
                        height: 500,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                      ),
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Container(
                        child: Container(
                          // width: 500,
                          // height: 500,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/image-removebg-preview.png"))),
                          // child: Text(itemIndex.toString())
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      child: Container(
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      color: Colors.white,
                    ),
                  )),
                  Positioned(
                    top: 370,
                    right: -30,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-22 / 360),
                      child: Container(
                        height: 150,
                        width: 600,
                        decoration: const BoxDecoration(
                            color: Color(0xffe3eaf1),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(1000))),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 440,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xffe3eaf1),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(58))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(),
                          ),
                          Text(
                            "Super Title",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc scelerisque vitae ante eget scelerisque. Mauris et massa accumsan, convallis dolor et, tincidunt ligula. Pellentesque eleifend euismod leo. Maecenas elementum, metus ut ornare mattis, lacus ligula molestie diam, in viverra velit est sit amet ante. Etiam sollicitudin, tellus eu suscipit lobortis, nisl libero tincidunt leo, quis ullamcorper nibh elit sed lacus. Integer interdum dictum purus. Nunc molestie diam faucibus augue fermentum"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
