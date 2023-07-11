import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final fem = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 10),
        child: TextButton(
          // entryZ6w (1:4)
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(37.5, 180, 38.5, 19),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffdedeea),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogroupxflbCfh (Qz4spQFm2vgm2JLUV3xFLB),
                  margin: const EdgeInsets.fromLTRB(5.5, 0, 5.5, 248),
                  width: double.infinity,
                  height: 273,
                  decoration: BoxDecoration(
                    color: const Color(0xff61678b),
                    borderRadius: BorderRadius.circular(136.5),
                  ),
                  child: const Center(
                    child: Center(
                      child: Text(
                        'CLIFF',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'RaillyRegular',
                          fontSize: 60.8823623657,
                          fontWeight: FontWeight.w600,
                          height: 1.55,
                          color: Color(0xff98bfd0),
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                  // developedbyanubhavkumaragF (8:42)
                  child: Text(
                    'DEVELOPED BY ANUBHAV KUMAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Mufanpfs',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                const Center(
                  // developedbyanubhavkumaragF (8:42)
                  child: Text(
                    'DESIGNED BY SHRESTHA DAS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Mufanpfs',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      color: Color(0xff000000),
                    ),
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
