import 'package:flutter/material.dart';

class Picker {
  static Future<void> timePicker({
    required BuildContext context,
    required TimeOfDay initialValue,
    required Function(TimeOfDay) onTimeChanged,
  }) async {
    int selectedHour = initialValue.hourOfPeriod == 0 ? 12 : initialValue.hourOfPeriod;
    int selectedMinute = initialValue.minute;
    String selectedPeriod = initialValue.period == DayPeriod.am ? "AM" : "PM";

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Time"),
          content: SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimeWheel(
                  context,
                  1,
                  12,
                  selectedHour,
                  (value) => selectedHour = value,
                ),
                const SizedBox(width: 10),
                _buildTimeWheel(
                  context,
                  0,
                  59,
                  selectedMinute,
                  (value) => selectedMinute = value,
                ),
                const SizedBox(width: 10),
                _buildAmPmWheel(context, selectedPeriod, (value) => selectedPeriod = value),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                int finalHour = selectedHour == 12 ? (selectedPeriod == "AM" ? 0 : 12) : 
                                (selectedPeriod == "PM" ? selectedHour + 12 : selectedHour);
                onTimeChanged(TimeOfDay(hour: finalHour, minute: selectedMinute));
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildTimeWheel(BuildContext context, int min, int max, int selected, Function(int) onChange) {
    return SizedBox(
      width: 60,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        perspective: 0.005,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: selected - min),
        onSelectedItemChanged: (index) => onChange(index + min),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) => Center(
            child: Text(
              "${index + min}".padLeft(2, '0'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          childCount: max - min + 1,
        ),
      ),
    );
  }

  static Widget _buildAmPmWheel(BuildContext context, String selected, Function(String) onChange) {
    return SizedBox(
      width: 70,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        perspective: 0.005,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: selected == "AM" ? 0 : 1),
        onSelectedItemChanged: (index) => onChange(index == 0 ? "AM" : "PM"),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) => Center(
            child: Text(
              index == 0 ? "AM" : "PM",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          childCount: 2,
        ),
      ),
    );
  }
}
