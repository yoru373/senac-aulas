import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {

  final String title;
  final IconData icon;
  final String subtitle;

  const CustomTitle({super.key, required this.title,
  required this.icon,
  required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
Row(
                  children: [
                    Icon(
                      icon,
                      color: const Color.fromARGB(233, 13, 37, 250),
                    ),
                    SizedBox(width: 5),
                    Text(
                     title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(subtitle), // Nome fixo (poderia vir de um banco de dados)

    ],);
  }
}