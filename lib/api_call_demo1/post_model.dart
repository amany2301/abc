class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });


  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']);
  }

  // // Factory method to parse JSON into a Post object
  // factory Post.fromJson(Map<String, dynamic> json) {
  //   return Post(
  //     userId: json['userId'],
  //     id: json['id'],
  //     title: json['title'],
  //     body: json['body'],
  //   );
  // }
}
