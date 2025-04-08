class ChatUser {
  ChatUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.lastActive,
    required this.email,
    required this.pushToken,
    required this.isonline,
  });
  late final String image;
  late final String about;
  late final String name;
  late final String createdAt;
  late final String id;
  late final String lastActive;
  late final String email;
  late final String pushToken;
  late final bool isonline;

  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image'] ??'';
    about = json['about']??'';
    name = json['name']??'';
    createdAt = json['created_at']??'';
    id = json['id']??'';
    lastActive = json['last_active']??'';
    email = json['email']??'';
    pushToken = json['push_token']??'';
    isonline = json['isonline']??'';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['isonline'] = isonline;
    return data;
  }
}
