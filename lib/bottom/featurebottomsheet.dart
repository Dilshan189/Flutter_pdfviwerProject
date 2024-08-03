import 'package:flutter/material.dart';

class FeatureRequestBottomSheet extends StatelessWidget {
  final String imagePath;

  const FeatureRequestBottomSheet({required this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 9.5,
      height: MediaQuery.of(context).size.height * 20.0,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            imagePath,
            width: 100.0,
            height: 100.0,
          ),
          const SizedBox(height: 10.0),
          const Text(
            'What other features do you want?',
            style: TextStyle(fontSize: 22.0),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'We’ll prioritize adding the features you want',
            style: TextStyle(fontSize: 15.0),
          ),
          const SizedBox(height: 20.0),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          child: TextButton.icon(
                            onPressed: () => {},
                            icon: const Icon(Icons.document_scanner_outlined),
                            label: const Text('Scan to PDF'),
                          ),
                        ),
                        Card(
                          child: TextButton.icon(
                            onPressed: () => {
                              // Implement your functionality here
                            },
                            icon: const Icon(Icons.cloud_done_outlined),
                            label: const Text('Cloud Sync'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      child: TextButton.icon(
                        onPressed: () => {
                          // Implement your functionality here
                        },
                        icon: const Icon(Icons.create_new_folder_outlined),
                        label: const Text('Create Folders'),
                      ),
                    ),
                    Card(
                      child: TextButton.icon(
                        onPressed: () => {
                          // Implement your functionality here
                        },
                        icon: const Icon(Icons.offline_bolt_outlined),
                        label: const Text('Others'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement your functionality here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: const Size(350.0, 50.0),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
