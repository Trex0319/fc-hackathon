import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class WorkerHarvestInterface extends StatefulWidget {
  const WorkerHarvestInterface({super.key});

  @override
  _WorkerHarvestInterfaceState createState() => _WorkerHarvestInterfaceState();
}

class _WorkerHarvestInterfaceState extends State<WorkerHarvestInterface> {
  final List<Map<String, dynamic>> progress = [];
  final List<String> trainingTips = [
    "Focus on choosing fruits that are fully ripe to improve quality.",
    "Handle the fruit gently to avoid damage and maintain high quality.",
    "Ensure you're using the correct harvesting technique for each type of fruit.",
    "Pay attention to color and firmness when selecting fruits for harvest.",
    "Remember to stay hydrated and take short breaks to maintain your productivity.",
  ];

  final _formKey = GlobalKey<FormState>();
  String quantity = '';
  String quality = '';
  bool submitted = false;
  bool showMidDayAlert = false;
  String dispute = '';
  List<String> chatMessages = [];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
  if (mounted) {
    setState(() {
      showMidDayAlert = true;
    });
  }
});

  }

  int getBonus(double quality) {
    if (quality >= 4) return 10;
    if (quality >= 3) return 5;
    return 0;
  }

  String getFeedback(double quantity, double quality) {
    if (quality >= 4) {
      return 'Great job! You harvested $quantity tonnes today with an average quality score of $quality stars.';
    } else {
      return 'You harvested $quantity tonnes today. Try to improve your quality tomorrow by focusing on ripeness!';
    }
  }

  String getRandomTip() {
    return trainingTips[Random().nextInt(trainingTips.length)];
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        progress.add({
          'day': progress.length + 1,
          'quantity': double.parse(quantity),
          'quality': double.parse(quality),
        });
        submitted = true;
      });
    }
  }

  void handleDisputeSubmit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Concern Submitted"),
        content: const Text("Your concern has been submitted to the supervisor."),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                dispute = '';
              });
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void addMessage(String message) {
    setState(() {
      chatMessages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Daily Harvest Report'),
        backgroundColor: Colors.white,
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showMidDayAlert)
              AlertDialog(
                title: const Text("Mid-day Reminder"),
                content: const Text("You're halfway through the day! Keep up the good work."),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        showMidDayAlert = false;
                      });
                    },
                    child: const Text("OK"),
                  )
                ],
              ),
            Card(
  color: Colors.white, // Set the background color to white
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    side: const BorderSide(color: Colors.orange, width: 2), // Set the orange border
  ),
  elevation: 2,
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Harvest',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.orange),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Quantity (tonnes)', 
            (value) => quantity = value!, 
            'Please enter quantity',
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Quality Score (1-5)', 
            (value) => quality = value!, 
            'Enter a quality score between 1 and 5', 
            isQualityField: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: handleSubmit,
            child: const Center(
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),
 if (submitted) ...[
              const SizedBox(height: 16),
              _buildSummaryCard(),
              _buildProgressCard(),
            ],
            const SizedBox(height: 16),
            _buildDisputeCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, FormFieldSetter<String> onSaved, String validatorMsg, {bool isQualityField = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.orange)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey), // Set the border color here
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey), // Color for the default border
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue), // Color for the focused border
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: onSaved,
          validator: (value) {
            if (value == null || value.isEmpty) return validatorMsg;
            if (isQualityField && (double.tryParse(value)! < 1 || double.tryParse(value)! > 5)) return validatorMsg;
            return null;
          },
        ),
      ],
    );
  }

 Widget _buildSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Summary', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.orange)),
            const SizedBox(height: 8),
            Text(getFeedback(double.parse(quantity), double.parse(quality))),
            const SizedBox(height: 8),
            Text('Bonus earned: RM${getBonus(double.parse(quality))}'),
            const SizedBox(height: 8),
            Text('Tip of the day: ${getRandomTip()}'),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Progress', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.orange)),
            const SizedBox(height: 8),
            ...progress.map((day) => Text('Day ${day['day']}: ${day['quantity']} tonnes, Quality: ${day['quality']} stars')),
          ],
        ),
      ),
    );
  }




Widget _buildDisputeCard() {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: Colors.orange, width: 2),
    ),
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Raise a Concern',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.orange),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Describe your concern',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                  onChanged: (value) => dispute = value,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.mic, color: Colors.orange),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: handleDisputeSubmit,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flag, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Submit Concern",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
