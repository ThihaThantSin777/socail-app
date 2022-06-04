import 'package:flutter/material.dart';
import 'package:social_media_application/resources/dimens.dart';
import 'package:social_media_application/resources/images.dart';

import '../data/vos/news_feed_vo.dart';

class NewsFeedItemView extends StatelessWidget {
  const NewsFeedItemView({Key? key,required this.newsFeed,required this.onTapDelete,required this.onTapEdit}) : super(key: key);
  final NewsFeedVO newsFeed;
  final Function(int)onTapDelete;
  final Function(int)onTapEdit;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children:  [
            ProfileImageView(
              imagePath: newsFeed.profilePicture.toString(),
            ),
            const SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            NameLocationAndTimeAgoView(
              userName: newsFeed.userName.toString(),
            ),
            const Spacer(),
            MoreButtonView(
              onTapDelete: (){
                onTapDelete(newsFeed.id??0);
              },
              onTapEdit: (){
                onTapEdit(newsFeed.id??0);
              },
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
         PostImageView(
           imagePath: newsFeed.postImage.toString(),
         ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
         PostDescriptionView(
           description: newsFeed.description.toString(),
         ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: const [
            Text(
              "See Comments",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Icon(
              Icons.mode_comment_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.grey,
            )
          ],
        )
      ],
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  const PostDescriptionView({
    Key? key,
    required this.description
  }) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    return  Text(
      description,
      style: const TextStyle(
        fontSize: TEXT_REGULAR,
        color: Colors.black,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  const PostImageView({
    Key? key,
    required this.imagePath
  }) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: imagePath.isNotEmpty,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
        child:  FadeInImage(
          height: 200,
          width: double.infinity,
          placeholder: const NetworkImage(
            NETWORK_IMAGE_POST_PLACEHOLDER,
          ),
          image: NetworkImage(
            imagePath.isEmpty?'https://st3.depositphotos.com/5392356/13703/i/1600/depositphotos_137037020-stock-photo-professional-software-developer-working-in.jpg':imagePath
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  const MoreButtonView({
    Key? key,
    required this.onTapDelete,
    required this.onTapEdit
  }) : super(key: key);
  final Function onTapDelete;
  final Function onTapEdit;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context)=>[
          PopupMenuItem(
            onTap: (){
             onTapEdit();
            },
              child: const Text('Edit')
          ),
          PopupMenuItem(
              onTap: (){
                onTapDelete();
              },
              child: const Text('Delete')
          ),
        ]
    );
  }
}

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
    required this.imagePath
  }) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      backgroundImage: NetworkImage(
        imagePath
      ),
      radius: MARGIN_LARGE,
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {
  const NameLocationAndTimeAgoView({
    Key? key,
    required this.userName
  }) : super(key: key);
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:  [
            Text(
              userName,
              style: const TextStyle(
                fontSize: TEXT_REGULAR_2X,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(
              width: MARGIN_SMALL,
            ),
           const Text(
              "- 2 hours ago",
              style: TextStyle(
                fontSize: TEXT_SMALL,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        const Text(
          "Paris",
          style: TextStyle(
            fontSize: TEXT_SMALL,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
