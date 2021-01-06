import 'package:flutter/material.dart';
import 'package:passdown/authentication_service.dart';
import 'package:passdown/theme/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final List<Map> myProducts =
      List.generate(6, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: Text('PASSDOWN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                alignment: Alignment.center,
                child: Text(myProducts[index]["name"]),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            }),
      ),
      persistentFooterButtons: [
          Padding(
           padding: const EdgeInsets.only(right: 150.0),
           child: RaisedButton(
            onPressed: () {
              context.read<AuthenticationService>().SignOut();
              Navigator.of(context).pushNamed(AppRoutes.authLogin);
            },
            child: Text('Sign Out'),
          ),
        ),
      ],
    );
  }
}
