import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:caress_care/glass_box.dart';
import '../utils/const/app_colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, dynamic>> _posts = [
    {
      "name": "Rabail",
      "message": "Feeling grateful today!",
      "time": "2 hrs ago",
      "likes": 2,
      "liked": false,
      "comments": ["That's great!", "Keep it up!"],
    },
    {
      "name": "Noor Ul Huda",
      "message": "Anyone has tips for mindfulness?",
      "time": "4 hrs ago",
      "likes": 1,
      "liked": false,
      "comments": ["Try meditation daily."],
    },
    {
      "name": "You",
      "message": "Just started journaling, it feels great 😌",
      "time": "1 day ago",
      "likes": 5,
      "liked": true,
      "comments": ["Awesome!", "Proud of you."],
    },
    {
      "name": "Ali",
      "message": "Went for a 5km run today. Feeling fresh! 🏃‍♂️",
      "time": "3 days ago",
      "likes": 3,
      "liked": false,
      "comments": ["Inspiring!", "Keep running!"],
    },
    {
      "name": "Sarah Khan",
      "message": "Struggling a bit today, but staying hopeful.",
      "time": "5 days ago",
      "likes": 7,
      "liked": false,
      "comments": ["Stay strong 💙", "Here for you!"],
    },
    {
      "name": "Wajeeh",
      "message": "Finally started meditating! Already feel calmer.",
      "time": "1 week ago",
      "likes": 10,
      "liked": true,
      "comments": ["Proud of you!", "Meditation is life-changing!"],
    },
  ];

  /// Initially only 2 friends
  final List<Map<String, String>> _friends = [
    {"name": "Noor Ul Huda"},
    {"name": "Wajeeh"},
  ];

  void _toggleLike(int index) {
    setState(() {
      _posts[index]['liked'] = !_posts[index]['liked'];
      _posts[index]['likes'] += _posts[index]['liked'] ? 1 : -1;
    });
  }

  void _showComments(int index) {
    TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GlassBox(
            borderRadius: 24,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: _posts[index]['comments'].length,
                    itemBuilder:
                        (context, i) => ListTile(
                          dense: true,
                          title: Text(
                            _posts[index]['comments'][i],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                  ),
                ),
                TextField(
                  controller: commentController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Write a comment",
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (commentController.text.trim().isNotEmpty) {
                      setState(() {
                        _posts[index]['comments'].add(
                          commentController.text.trim(),
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add Comment"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _createPostDialog() {
    TextEditingController postController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.transparent,
            content: GlassBox(
              borderRadius: 20,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.book_rounded, size: 40, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    "Create Post",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: postController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.08),
                      hintText: "Share your thoughts...",
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (postController.text.trim().isNotEmpty) {
                        setState(() {
                          _posts.insert(0, {
                            "name": "You",
                            "message": postController.text.trim(),
                            "time": "Just now",
                            "likes": 0,
                            "liked": false,
                            "comments": [],
                          });
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Post"),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showFriendsList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GlassBox(
            borderRadius: 24,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Your Friends",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _friends.length,
                  itemBuilder: (context, i) {
                    final friend = _friends[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassBox(
                        borderRadius: 18,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                friend["name"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() => _friends.removeAt(i));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${friend['name']} unfriended",
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Unfriend",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addFriend(String name) {
    if (_friends.any((f) => f["name"] == name)) return;
    setState(() => _friends.add({"name": name}));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$name added to your friends")));
  }

  void _deletePost(int index) => setState(() => _posts.removeAt(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 100),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                final isFriend = _friends.any((f) => f["name"] == post["name"]);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GlassBox(
                    borderRadius: 16,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post["message"],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              post["time"],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white54,
                              ),
                            ),
                            Row(
                              children: [
                                if (post["name"] != "You" && !isFriend)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.person_add,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () => _addFriend(post["name"]),
                                  ),
                                IconButton(
                                  onPressed: () => _toggleLike(index),
                                  icon: Icon(
                                    post["liked"]
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        post["liked"]
                                            ? Colors.redAccent
                                            : Colors.white70,
                                  ),
                                ),
                                Text(
                                  "${post["likes"]}",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                IconButton(
                                  onPressed: () => _showComments(index),
                                  icon: const Icon(
                                    Icons.comment,
                                    color: Colors.white70,
                                  ),
                                ),
                                if (post["name"] == "You")
                                  IconButton(
                                    onPressed: () => _deletePost(index),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            /// Bottom corner buttons
            Positioned(
              bottom: 20,
              left: 20,
              child: FloatingActionButton(
                onPressed: _showFriendsList,
                backgroundColor: Colors.white.withOpacity(0.2),
                shape: const CircleBorder(),
                child: const Icon(Icons.group, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: _createPostDialog,
                backgroundColor: Colors.white.withOpacity(0.2),
                shape: const CircleBorder(),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
