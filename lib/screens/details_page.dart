import 'package:flutter/material.dart';

import '../models/pet_model.dart';


class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required Pet pet});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
