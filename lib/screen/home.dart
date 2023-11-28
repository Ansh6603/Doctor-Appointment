import 'package:doctor_app/auth/login_page.dart';
import 'package:doctor_app/screen/doctor_list.dart';
import 'package:doctor_app/screen/profile_page.dart';
import 'package:doctor_app/screen/scheduled_appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  List<String> appointments = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    List<String>? savedAppointments = prefs.getStringList('appointments');
    if (savedAppointments != null) {
      setState(() {
        appointments = savedAppointments;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? 'User Name'),
              accountEmail: Text(user?.email ?? 'user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : const AssetImage('images/design.png')
                        as ImageProvider<Object>,
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () async {
                Navigator.pop(context);

                User? updatedUser = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );

                if (updatedUser != null) {
                  setState(() {
                    user = updatedUser;
                  });
                }
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LogIn()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Available Doctors',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: DoctorList(onAppointmentBooked: addAppointment),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Scheduled Appointments',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ScheduledAppointments(appointments: appointments),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addAppointment(String appointmentInfo) {
    setState(() {
      appointments.add(appointmentInfo);
      prefs.setStringList('appointments', appointments);
    });
  }
}
