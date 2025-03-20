// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/granja_provider.dart';

class ListExpdteMedView extends StatefulWidget {
  const ListExpdteMedView({super.key});

  @override
  State<ListExpdteMedView> createState() => _ListExpdteMedViewState();
}

class _ListExpdteMedViewState extends State<ListExpdteMedView> {
  @override
  Widget build(BuildContext context) {
    final ProvGranja = Provider.of<GranjaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Expediente médico",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            Text(
              ProvGranja.granjaUsuario["nombre"],
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
