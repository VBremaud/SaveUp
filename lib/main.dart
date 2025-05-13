import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MonBudgetApp());
}

class MonBudgetApp extends StatelessWidget {
  const MonBudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suivi Financier',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const AccueilPage(),
    );
  }
}

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  double solde = 1250.50;
  final List<Transaction> transactions = [
    Transaction(
      date: DateTime.now(),
      libelle: 'CAF',
      montant: 150.0,
      categorie: 'Revenus',
    ),
    Transaction(
      date: DateTime.now().subtract(const Duration(days: 1)),
      libelle: 'Loyer',
      montant: -700.0,
      categorie: 'Charges fixes',
    ),
    Transaction(
      date: DateTime.now().subtract(const Duration(days: 2)),
      libelle: 'Courses',
      montant: -85.20,
      categorie: 'Alimentation',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💶 Mon Budget'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Solde actuel : ${solde.toStringAsFixed(2)} €',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Dernières transactions :', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return ListTile(
                    title: Text(tx.libelle),
                    subtitle: Text(DateFormat('dd/MM/yyyy').format(tx.date)),
                    trailing: Text(
                      '${tx.montant >= 0 ? '+' : ''}${tx.montant.toStringAsFixed(2)} €',
                      style: TextStyle(
                        color: tx.montant >= 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final DateTime date;
  final String libelle;
  final double montant;
  final String categorie;

  Transaction({
    required this.date,
    required this.libelle,
    required this.montant,
    required this.categorie,
  });
}