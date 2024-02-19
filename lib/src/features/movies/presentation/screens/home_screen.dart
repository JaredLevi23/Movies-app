import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/auth/auth_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/counter_view/counter_view_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/counter_view/counter_view_state.dart';
import 'package:pagination/src/features/movies/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/movies/movies_bloc.dart';
import 'package:pagination/src/features/movies/presentation/views/account_view.dart';
import 'package:pagination/src/features/movies/presentation/views/explore_view.dart';
import 'package:pagination/src/features/movies/presentation/views/favorite_view.dart';
import 'package:pagination/src/features/movies/presentation/views/home_view.dart';
import 'package:pagination/src/features/movies/presentation/views/login_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).loadCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, userState) {
          if( userState.authStatus == AuthStatus.logged ){
            favoritesBloc.add( LoadFavoritesEvent(uid:  userState.user!.uid ));
            moviesBloc.add( LoadReviews(uid: userState.user!.uid) );
          }
        },
        builder: (context, userState) {
          return Stack(
              children: [
                BlocBuilder<CounterViewBloc, CounterViewState>(
                  builder: (context, state) {
                    return PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          switch (state.currentView) {
                            case 0:
                              return const HomeView();
                            case 1:
                              return const ExploreView();
                            case 2:
                              return const FavoriteView();
                            case 3:
                              return userState.user != null 
                              ? const AccountView()
                              : const LoginView();
                            default:
                              return const HomeView();
                          }
                        });
                  },
                ),
                BlocBuilder<CounterViewBloc, CounterViewState>(
                  builder: (context, state) {
                    return Positioned(
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: AnimatedOpacity(
                          opacity: state.showBar ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.black),
                            child: const CustomBottomNavigationBar(),
                          ),
                        ));
                  },
                )
              ],
            );
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counterViewBloc = BlocProvider.of<CounterViewBloc>(context);

    return BlocBuilder<CounterViewBloc, CounterViewState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _button(
                isSelected: state.currentView == 0,
                icon: Icons.home,
                onPressed: () {
                  counterViewBloc.add(const ChangeViewEvent(index: 0));
                }),
            _button(
                isSelected: state.currentView == 1,
                icon: Icons.explore,
                onPressed: () {
                  counterViewBloc.add(const ChangeViewEvent(index: 1));
                }),
            _button(
                isSelected: state.currentView == 2,
                icon: Icons.favorite,
                onPressed: () {
                  counterViewBloc.add(const ChangeViewEvent(index: 2));
                }),
            _button(
                isSelected: state.currentView == 3,
                icon: Icons.person,
                onPressed: () {
                  counterViewBloc.add(const ChangeViewEvent(index: 3));
                }),
          ],
        );
      },
    );
  }

  IconButton _button(
      {required IconData icon,
      required Function()? onPressed,
      required bool isSelected}) {
    return IconButton(
        color: Colors.white,
        style: isSelected
            ? const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red))
            : null,
        onPressed: onPressed,
        icon: Icon(icon));
  }
}
