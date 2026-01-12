import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black, size: 50),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Mahesh Kumar Suthar",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "maheshsuthardm@gmail.com",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                SizedBox(height: 20),
          
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          leading: Icon(
                            Icons.person_outline,
                            color: Colors.grey.shade600,
                          ),
                          title: Text("Name"),
                          trailing: Text("Mahesh Kumar Suthar", style: TextStyle(fontSize: 16),),
                        ),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          leading: Icon(
                            Icons.email_outlined,
                            color: Colors.grey.shade600,
                          ),
                          title: Text("Email"),
                          trailing: Text(
                            "mahesh@gmail.com",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          leading: Icon(
                            Icons.phone_outlined,
                            color: Colors.grey.shade600,
                          ),
                          title: Text("Phone"),
                          trailing: Text("9876543210", style: TextStyle(fontSize: 16),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.grey.shade600,
                          ),
                          title: Text("Change Password"),
                          trailing: Icon(Icons.arrow_forward_ios)
                        ),

                        ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              Icons.language,
                              color: Colors.grey.shade600,
                            ),
                            title: Text("Language"),
                            trailing: Text("English", style: TextStyle(fontSize: 16),),
                        ),
                      ],
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
