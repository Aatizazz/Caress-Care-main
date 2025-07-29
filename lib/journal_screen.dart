import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../glass_box.dart';
import '../utils/const/app_colors.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final Box journalBox = Hive.box('journals');

  @override
  void initState() {
    super.initState();
    _addDummyDataIfEmpty();
  }

  void _addDummyDataIfEmpty() {
    if (journalBox.isEmpty) {
      journalBox.addAll([
        {
          'title': 'Grateful Morning',
          'content':
              'Woke up early today and had a peaceful meditation session.',
          'date':
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toIso8601String(),
        },
        {
          'title': 'Nature Walk',
          'content':
              'Went for a walk in the park. The fresh air really helped clear my mind.',
          'date':
              DateTime.now()
                  .subtract(const Duration(days: 2))
                  .toIso8601String(),
        },
        {
          'title': 'New Hobby',
          'content': 'Started journaling! Feeling excited about this habit.',
          'date':
              DateTime.now()
                  .subtract(const Duration(days: 3))
                  .toIso8601String(),
        },
      ]);
    }
  }

  void addJournalEntry(String title, String content) {
    journalBox.add({
      'title': title,
      'content': content,
      'date': DateTime.now().toIso8601String(),
    });
  }

  void deleteEntry(int index) {
    journalBox.deleteAt(index);
    setState(() {});
  }

  void showAddEntryDialog() {
    titleController.clear();
    contentController.clear();
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.transparent,
            child: GlassBox(
              padding: const EdgeInsets.all(20),
              borderRadius: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.book_rounded, size: 40, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    "New Journal Entry",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    style: TextStyle(color: Colors.grey[100]),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.08),
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: contentController,
                    maxLines: 5,
                    style: TextStyle(color: Colors.grey[100]),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.08),
                      hintText: 'Write your thoughts...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save, color: Colors.white),
                    onPressed: () {
                      if (titleController.text.isNotEmpty &&
                          contentController.text.isNotEmpty) {
                        addJournalEntry(
                          titleController.text,
                          contentController.text,
                        );
                        Navigator.pop(context);
                        setState(() {});
                      }
                    },
                    label: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: showAddEntryDialog,
        backgroundColor: Colors.blueAccent.withOpacity(0.8),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: journalBox.listenable(),
          builder: (context, Box box, _) {
            if (box.isEmpty) {
              return Center(
                child: Text(
                  "No journal entries yet.",
                  style: TextStyle(color: Colors.grey[100], fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 100),
              itemCount: box.length,
              itemBuilder: (context, index) {
                final entry = box.getAt(index) as Map;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GlassBox(
                    borderRadius: 16,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[100],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry['content'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[200],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => deleteEntry(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
