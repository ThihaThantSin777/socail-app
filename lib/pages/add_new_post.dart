import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_application/bloc/add_new_post_bloc.dart';
import 'package:social_media_application/resources/dimens.dart';
import 'package:social_media_application/viewitems/add_new_post_item_view.dart';
import 'package:social_media_application/widgets/loading_view_widget.dart';

class AddNewPostPage extends StatelessWidget {
   AddNewPostPage({Key? key,this.newsFeedID}) : super(key: key);
  final int ?newsFeedID;
  final _key = GlobalKey<FormState>();


  void back(context){
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddNewPostBloc>(
      create: (context) => AddNewPostBloc(newsFeedID: newsFeedID),
      child: Selector<AddNewPostBloc,bool>(
        selector: (context,bloc)=>bloc.isLoading,
        builder: (context,isLoading,child)=> Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () =>back(context),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                ),
                centerTitle: false,
                title:  Text(
                  newsFeedID==null?'Add New Post':'Edit New Post',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_3, vertical: MARGIN_MEDIUM_1X),
                child: ListView(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const ProfileImageAndNameView(),
                    const SizedBox(
                      height: MARGIN_MEDIUM_3,
                    ),
                    PostTextFieldView(
                      formKey: _key,
                    ),
                    const SizedBox(
                      height: MARGIN_MEDIUM_3,
                    ),
                    const PostImageView(),
                    const SizedBox(
                      height: MARGIN_MEDIUM_3,
                    ),
                    PostButtonView(
                      formSate: _key,
                      newsFeedID: newsFeedID??-1,
                    )
                  ],
                ),
              ),

            ),
            Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                      child: LoadingViewWidget()
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}








