import 'package:doctor_app/model/doctor.dart';
import 'package:doctor_app/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentForm extends StatefulWidget {
  final Doctor doctor;
  final Function(String) onAppointmentBooked;

  const AppointmentForm(
      {required this.doctor, required this.onAppointmentBooked, super.key});

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  TextEditingController patientNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: const Locale('en', 'US'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(
        () {
          selectedTime = picked;
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Doctor: ${widget.doctor.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: patientNameController,
                decoration:
                    const InputDecoration(labelText: 'Enter Patient Name'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: ageController,
                decoration:
                    const InputDecoration(labelText: 'Enter Patient Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: symptomsController,
                decoration: const InputDecoration(labelText: 'Enter Symptoms'),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  "Selected Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}",
                ),
                trailing: const Icon(Icons.keyboard_arrow_down),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text("Selected Time: ${selectedTime.format(context)}"),
                trailing: const Icon(Icons.keyboard_arrow_down),
                onTap: () => _selectTime(context),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  String result = 'Appointment Details:\n'
                      'Doctor: ${widget.doctor.name}\n'
                      'Patient Name: ${patientNameController.text}\n'
                      'Age: ${ageController.text}\n'
                      'Symptoms: ${symptomsController.text}\n'
                      'Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}\n'
                      'Time: ${selectedTime.format(context)}';
                  widget.onAppointmentBooked(result);
                  Navigator.pop(context, result);
                },
                child: const Text('Book Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
