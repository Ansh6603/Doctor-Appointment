import 'package:doctor_app/model/doctor.dart';
import 'package:doctor_app/screen/appointment_page.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatelessWidget {
  final Function(String) onAppointmentBooked;

  const DoctorList({required this.onAppointmentBooked, super.key});

  @override
  Widget build(BuildContext context) {
    List<Doctor> doctors = [
      Doctor(name: 'Dr. John Doe', specialization: 'Cardiologist'),
      Doctor(name: 'Dr. Jane Smith', specialization: 'Dermatologist'),
      Doctor(name: 'Dr. Alex Johnson', specialization: 'Neurologist'),
      Doctor(name: 'Dr. Emily White', specialization: 'Pediatrician'),
      Doctor(name: 'Dr. Michael Brown', specialization: 'Orthopedic Surgeon'),
      Doctor(name: 'Dr. Sarah Davis', specialization: 'Gynecologist'),
      Doctor(name: 'Dr. Richard Green', specialization: 'Ophthalmologist'),
      Doctor(name: 'Dr. Lisa Taylor', specialization: 'Endocrinologist'),
      Doctor(name: 'Dr. William Clark', specialization: 'Dentist'),
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        Doctor doctor = doctors[index];
        Color color = Colors.primaries[index % Colors.primaries.length];

        return GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentForm(
                  doctor: doctor,
                  onAppointmentBooked: onAppointmentBooked,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Text(
                  doctor.name[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          doctor.specialization,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentForm(
                            doctor: doctor,
                            onAppointmentBooked: onAppointmentBooked,
                          ),
                        ),
                      );
                    },
                    child: const Text('Book Appointment'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
