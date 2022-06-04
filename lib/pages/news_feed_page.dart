import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_application/bloc/new_feeds_bloc.dart';
import 'package:social_media_application/pages/add_new_post.dart';
import 'package:social_media_application/pages/login_page.dart';
import 'package:social_media_application/resources/dimens.dart';
import 'package:social_media_application/utils/extension.dart';
import 'package:social_media_application/viewitems/news_feed_item_view.dart';

import '../data/vos/news_feed_vo.dart';

class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  void _navigateToEditPostPage(context, int newsFeedID) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddNewPostPage(
              newsFeedID: newsFeedID,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsFeedBloc>(
      create: (context) => NewsFeedBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            navigatePush(context, AddNewPostPage());
            // FirebaseCrashlytics.instance.crash();
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Container(
            margin: const EdgeInsets.only(
              left: MARGIN_MEDIUM,
            ),
            child: const Text(
              "Social",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TEXT_HEADING_1X,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(
                  right: MARGIN_LARGE,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: MARGIN_LARGE,
                ),
              ),
            ),
            Consumer<NewsFeedBloc>(
              builder: (context, bloc, child) => GestureDetector(
                onTap: () {
                  bloc.logout().then(
                      (_) => navigatePushReplacement(context, LoginPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    right: MARGIN_LARGE,
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: MARGIN_LARGE,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Consumer<NewsFeedBloc>(
            builder: (context, bloc, child) => (bloc.newsFeed?.isEmpty ?? true)
                ? const Center(
                    child: Text('No post available'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: MARGIN_LARGE,
                      horizontal: MARGIN_LARGE,
                    ),
                    itemBuilder: (context, index) {
                      return NewsFeedItemView(
                        newsFeed: bloc.newsFeed?[index] ?? NewsFeedVO.normal(),
                        onTapDelete: (postID) {
                          bloc.delete(postID);
                        },
                        onTapEdit: (postID) {
                          Future.delayed(const Duration(milliseconds: 1000))
                              .then((value) {
                            _navigateToEditPostPage(context, postID);
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: MARGIN_XLARGE,
                      );
                    },
                    itemCount: bloc.newsFeed?.length ?? 0,
                  ),
          ),
        ),
      ),
    );
  }
}
