import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ping_pong/main.dart';
import '../../app/app.dart';
import '../../home/home.dart';


class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(AppLogoutRequest());
              GoRouter.of(context).go('/login');
              return;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          GoRouter.of(context).go('/addmatches');
        },
      ),
      body: const Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:const Alignment(0, -1/3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          AvatarProfile(),
          SizedBox(height: 4),
          EmailOfUser(),
          SizedBox(height: 4.0),
          NameOfUser(),
          FirestoreUser(),
        ],
      ),
    );
  }
}

class AvatarProfile extends StatelessWidget {

  const AvatarProfile({Key? key}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.user.photo != current.user.photo,
      builder: (context,state) {
        return Avatar(photo: state.user.photo,);
      },
    );
  }
}

class EmailOfUser extends StatelessWidget {
  
  const EmailOfUser({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.user.email != current.user.email,
      builder: (context,state) {
        return Text(state.user.email ?? '');
      },
    );
  }

}

class NameOfUser extends StatelessWidget {

  const NameOfUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.user.name != current.user.name,
      builder: (context,state) {
        return Text(state.user.name ?? '');
      },
    );
  }

}

class FirestoreUser extends StatelessWidget {

  const FirestoreUser({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance.collection('users').where('email', isEqualTo: 'xhoi@xhoi.com').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: user,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }
        final data = snapshot.requireData;

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.size,
          itemBuilder: (context, index) {
            return Text('My name is ${data.docs[index]['username']}, my email is ${data.docs[index]['email']}');
          },

        );
      },
    );
  }
}
