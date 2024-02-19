import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/auth/auth_bloc.dart';

class LoginView extends StatelessWidget {
const LoginView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text(
              'Inicia sesión con Google',
              style: TextStyle(
                fontSize: 18
              ),
            ),

            Container(
              margin: const EdgeInsets.all( 16 ),
              width: double.infinity,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular( 16 )
                ),
                color: Colors.red.shade500,
                onPressed: (){
                  BlocProvider.of<AuthBloc>(context, listen: false ).signIn();
                }, 
                child: const Text('Continuar con Google')
              ),
            )

          ],
        )
    );
  }
}