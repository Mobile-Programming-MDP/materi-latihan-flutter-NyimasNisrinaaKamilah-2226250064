import 'package:flutter/material.dart';
import 'package:wisata_candi/widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //TODO:1. Deklarasi variable (state) yang dibutuhkan
  bool isSignIn = true;
  String fullName = "Nyimas Nisrinaa Kamilah";
  String userName = "Nyimas";
  int favoritCandiCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Color.fromARGB(255, 208, 127, 251),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200 - 50),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color.fromARGB(255, 102, 56, 181), width: 3),
                            shape: BoxShape.circle),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('images/placeholder_image.png'),
                        ),
                      ),
                      if (isSignIn)
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: const Color.fromARGB(255, 208, 127, 251),
                            ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ProfileInfoItem (
                      icon: Icons.lock,
                      label: 'Pengguna',
                      value: userName,
                      iconColor: Colors.amber,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ProfileInfoItem(
                        icon: Icons.person,
                        label: 'Nama',
                        value: fullName,
                        showEditIcon: isSignIn,
                        onEditPressed: () {
                          debugPrint('Icon edit ditekan ...');
                        },
                        iconColor: Colors.blue),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ProfileInfoItem(
                        icon: Icons.favorite,
                        label: 'Favorit',
                        value:
                            favoritCandiCount > 0 ? '$favoritCandiCount' : '',
                        iconColor: Colors.red),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isSignIn
                        ? TextButton(
                            onPressed: () {},
                            child: Text('Sign Out'),
                            style: TextButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 208, 127, 251),
                                padding: const EdgeInsets.all(20),
                                elevation: 5),
                          )
                        : TextButton(
                            onPressed: () {},
                            child: Text('Sign In'),
                            style: TextButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                padding: const EdgeInsets.all(20),
                                elevation: 5),
                          )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


