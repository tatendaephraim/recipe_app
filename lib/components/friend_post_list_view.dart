import 'package:flutter/material.dart';

import '../models/post.dart';
import 'friend_post_tile.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> friendPosts;
  const FriendPostListView({super.key, required this.friendPosts});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text('Social Chefs'),
             const SizedBox(height: 16),

            ListView.separated(
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: friendPosts.length,
                itemBuilder: (context,index){
                  final post = friendPosts[index];
                  return FriendPostTile(post: post);
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 16);
                },
            ),
            const SizedBox(height: 16),
          ],
        ),

    );
  }
}
