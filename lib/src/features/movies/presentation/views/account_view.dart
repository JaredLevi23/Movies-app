import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/auth/auth_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/counter_view/counter_view_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/movies/movies_bloc.dart';
import 'package:pagination/src/features/movies/presentation/widgets/widgets.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final controller = ScrollController();
  double lastScroll = 0;

  @override
  void initState() {
    final counterViewBloc =
        BlocProvider.of<CounterViewBloc>(context, listen: false);

    controller.addListener(() {
      if (controller.offset > lastScroll) {
        counterViewBloc.add(const ShowBarEvent(showBar: false));
      } else {
        counterViewBloc.add(const ShowBarEvent(showBar: true));
      }
      lastScroll = controller.offset;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                  child: TextButton(
                child: const Text('Cerrar sesión'),
                onPressed: () {
                  authBloc.add(const AuthAddUser(user: null));
                  authBloc.singOut();
                  Navigator.pop(context);
                },
              ))
            ];
          })
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state.user?.photoURL != null)
                        LoadImage(path: state.user?.photoURL ?? '')
                      else
                        const CircleAvatar(
                          radius: 40,
                          child: Icon(
                            Icons.person,
                            size: 30,
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Correo electronico',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(state.user?.email ?? 'Sin correo electronico'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Nombre',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(state.user?.displayName ?? 'Sin nombre'),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
              const Divider(),
              const Center(
                  child: Text(
                'Mis reseñas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
            ])),

            BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state.reviews.isNotEmpty) {
                  return SliverGrid(
                    gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5

                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final review = state.reviews[ index ];
                        return GestureDetector(
                          onTap: (){
                            showModalBottomSheet(context: context, builder: (context){
                              return SingleChildScrollView(
                                padding: const EdgeInsets.all( 16 ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox( width: double.infinity ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text( review.author ?? 'Sin nombre', style: const TextStyle( fontSize: 20 ), ),
                                              Text( review.createdAt.toString().split('.')[0] , style: const TextStyle( fontSize: 12 ), ),
                                            ],
                                          ),
                                        ),
                                        if( review.url != null && review.url!.startsWith('http') )
                                        SizedBox(
                                          width: 100,
                                          height: 150,
                                          child: LoadImage(path: review.url ?? '' )
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(  review.content ?? ''),
                                  ],
                                ),
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(flex: 4, child: LoadImage(path: review.url ?? '' )),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    review.content ?? '',
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: state.reviews.length,
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 0,
                    ),
                  );
                }
              },
            ),

            // SliverGrid.builder(
            //   itemCount: 10,
            //   gridDelegate:
            //       const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 3,
            //     childAspectRatio: 0.5,
            //   ),
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         children: [
            //           Expanded(flex: 4, child: MovieLoader()),
            //           Expanded(
            //             flex: 2,
            //             child: Text(
            //               'Hola esta es una resela de prueba asdasdas da dasd asd asd as da s',
            //               maxLines: 3,
            //               textAlign: TextAlign.left,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   }),
          ],
        ),
      ),
    );
  }
}
