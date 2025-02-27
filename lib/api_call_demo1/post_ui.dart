import 'package:abc/api_call_demo1/api_service.dart';
import 'package:abc/api_call_demo1/post_model.dart';
import 'package:flutter/material.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Post>> _posts;
  final TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _posts = _apiService.fetchPosts();
  }

  void _fetchFilteredPosts() {
    // Get the userId from the TextField
    String userIdText = _userIdController.text;
    int? userId = userIdText.isNotEmpty ? int.tryParse(userIdText) : null;

    setState(() {
      // Fetch posts based on the userId input
      _posts = _apiService.fetchPosts(userId: userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts with Query Parameter'),
      ),
      body: Column(
        children: [
          // TextField to enter userId
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter User ID (Optional)',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          // Button to fetch posts
          ElevatedButton(
            onPressed: _fetchFilteredPosts,
            child: Text('Fetch Posts'),
          ),
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: _posts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No posts found.'));
                } else {
                  // Displaying the list of posts
                  List<Post> posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(posts[index].title),
                        subtitle: Text(posts[index].body),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
