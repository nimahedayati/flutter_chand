import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../models/currency.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyBloc()..add(FetchCurrencies()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chand?!'),
        ),
        body: BlocBuilder<CurrencyBloc, CurrencyState>(
          builder: (context, state) {
            if (state is CurrencyLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CurrencyError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<CurrencyBloc>().add(FetchCurrencies()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is CurrencyLoaded) {
              return RefreshIndicator(
                onRefresh: (){
                  context.read<CurrencyBloc>().add(FetchCurrencies());
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.15,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state.currencies.length,
                  itemBuilder: (context, index) {
                    final currency = state.currencies[index];
                    return CurrencyCard(currency: currency);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class CurrencyCard extends StatelessWidget {
  final Currency currency;

  const CurrencyCard({
    super.key,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final priceChange = currency.currentPrice - currency.previousPrice;

    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xff1c1c1e),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(48.0),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                currency.imageUrl,
                fit: BoxFit.contain,
                width: 32.0,
                height: 32.0,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currency.name,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.notoSansArabic(fontSize: 14.0, fontWeight: FontWeight.w500),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      currency.title,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (priceChange >= 0)
                const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.green,
                  size: 18.0,
                )
              else
                const Icon(
                  Icons.arrow_downward_rounded,
                  color: Colors.red,
                  size: 18.0,
                ),
              const SizedBox(width: 2.0),
              Text(
                priceChange.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    ),
                style: TextStyle(
                  color: priceChange >= 0 ? Colors.green : Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            currency.currentPrice >= 1000000
                ? '${(currency.currentPrice / 1000000).toStringAsFixed(2)}M'
                : currency.currentPrice.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    ),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
