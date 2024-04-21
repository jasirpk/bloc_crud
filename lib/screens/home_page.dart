import 'package:bloc_crud/bloc/logic_bloc.dart';
import 'package:bloc_crud/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogicBloc, LogicState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: ElevatedButton(
            onPressed: () {
              final id = state.users.length + 1;
              showBottomSheet(context: context, id: id);
            },
            child: Text('Add User'),
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: Text(
              'MY Bloc',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 20,
              ),
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, LogicState state) {
    if (state is LogicUpdated && state.users.isNotEmpty) {
      final users = state.users;
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _buildUserTile(context, user);
        },
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Text('No User Found'),
        ),
      );
    }
  }

  Widget _buildUserTile(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read<LogicBloc>().add(DelteUser(user: user));
            },
            icon: Icon(
              Icons.delete,
              size: 30,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              // Set the text fields with the user's name and email
              name.text = user.name;
              email.text = user.email;
              // Show the bottom sheet to edit the user's details
              showBottomSheet(context: context, id: user.id, isEdit: true);
            },
            icon: Icon(
              Icons.edit,
              size: 30,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet({
    required BuildContext context,
    bool isEdit = false,
    required int id,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(controller: name, hint: 'Enter Name'),
                _buildTextField(controller: email, hint: 'Enter Email'),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      final user =
                          User(id: id, name: name.text, email: email.text);
                      if (isEdit) {
                        context.read<LogicBloc>().add(UpdateUser(user: user));
                      } else {
                        context.read<LogicBloc>().add(AddUser(user: user));
                      }
                      Navigator.pop(context);
                      name.clear();
                      email.clear();
                    },
                    child: Text(isEdit ? 'Update' : 'Add User'),
                  ),
                )
              ],
            ),
          );
        },
      );

  static Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) =>
      Padding(
        padding: EdgeInsets.all(12),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
}
