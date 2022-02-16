import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: //doctor profile
              SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black26,
                      width: 0.4,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/doctor.jpg'),
                                    scale: 1,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.transparent,
                                        Colors.white10,
                                        Colors.white12,
                                        Colors.white24,
                                        Colors.white30,
                                        Colors.white54,
                                        Colors.white60,
                                        Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.70),
                                        Theme.of(context).primaryColor,
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 24,
                        child: Card(
                          elevation: 8,
                          child: Column(
                            children: [
                              Text(
                                'Dr. John Doe',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('Appointment'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.all(4),
                                // height: MediaQuery.of(context).size.height / 2,
                                // width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/doctor.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 8,
                                margin: EdgeInsets.all(4),
                                shadowColor: Colors.black26,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dr. John Doe',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Appointment'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/doctor.jpg'),
                                radius: 40,
                              ),
                              Container(
                                child: Card(
                                  child: Column(
                                    children: [
                                      Text('doctor name'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/background_doctor_image.jpg'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.red,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.1,
                      //   width: MediaQuery.of(context).size.width * 0.1,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Colors.white,
                      //   ),
                      //   child: Center(
                      //     child: Icon(
                      //       Icons.person,
                      //       size: MediaQuery.of(context).size.height * 0.05,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, bottom: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Dr. John Doe',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, bottom: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'MBBS, MD',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
