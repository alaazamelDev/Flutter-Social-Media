import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/futures/presentation/bloc/user/user_bloc.dart';
import 'package:flutter_social_app/futures/presentation/bloc/user/user_state.dart';
import 'package:flutter_social_app/futures/presentation/widgets/single_item_user_story_widget.dart';

class AllUsersPage extends StatefulWidget {
  final String uid;
  final String? query;
  const AllUsersPage({Key? key, required this.uid, this.query})
      : super(key: key);

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            final users = state.users
                .where((element) => element.uid != widget.uid)
                .toList();
            final filteredUsers = users
                .where((user) =>
                    user.name.startsWith(widget.query!) ||
                    user.name.startsWith(widget.query!.toLowerCase()))
                .toList();
            return Column(
              children: [
                Expanded(
                  child: filteredUsers.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_box,
                                size: 40,
                                color: Colors.black.withOpacity(.4),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "No Users Found yet",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.2),
                                ),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (_, index) {
                            return SingleItemStoriesStatusWidget(
                              user: filteredUsers[index],
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}