import 'package:flutter/material.dart';

class ChartBarWidget extends StatelessWidget {
  final String label;
  final double value;
  final double percente;
  final bool dayActual;

  const ChartBarWidget({
    super.key,
    required this.label,
    required this.value,
    required this.percente,
    required this.dayActual,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              "R\$ ${value.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 50,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percente,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
                color: dayActual ? Colors.blue[600] : Colors.red,
                fontWeight: dayActual ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
