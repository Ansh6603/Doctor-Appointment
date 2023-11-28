import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduledAppointments extends StatefulWidget {
  final List<String> appointments;

  const ScheduledAppointments({required this.appointments, super.key});

  @override
  _ScheduledAppointmentsState createState() => _ScheduledAppointmentsState();
}

class _ScheduledAppointmentsState extends State<ScheduledAppointments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.appointments.length,
      itemBuilder: (context, index) {
        String appointment = widget.appointments[index];
        List<String> appointmentDetails = appointment.split('\n');
        Color avatarColor = getAvatarColor(index);

        return Dismissible(
          key: Key(appointment),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            setState(
              () {
                widget.appointments.removeAt(index);
                saveAppointmentsToSharedPreferences();
              },
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Appointment canceled"),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    setState(
                      () {
                        widget.appointments.insert(index, appointment);
                        saveAppointmentsToSharedPreferences();
                      },
                    );
                  },
                ),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: avatarColor,
                child: const Text(
                  'D',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                appointmentDetails[1],
                style: TextStyle(
                  color: avatarColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${appointmentDetails[5]}                ${appointmentDetails[6]}',
                style: TextStyle(color: avatarColor),
              ),
            ),
          ),
        );
      },
    );
  }

  Color getAvatarColor(int index) {
    List<Color> avatarColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
      Colors.brown,
    ];

    return avatarColors[index % avatarColors.length];
  }

  void saveAppointmentsToSharedPreferences() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('appointments', widget.appointments);
    });
  }
}
