import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/presentation/widgets/app_chart_widget.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

class CoinListTileWidget extends StatelessWidget {
  const CoinListTileWidget({
    super.key,
    required this.coin,
    required this.amount, required this.showChart,
  });

  final CoinModel coin;
  final double amount;
  final bool showChart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: Row(
          children: [
            Text(
              coin.marketCapRank.toString(),
              style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(width: 10),
            Image.network(coin.image, width: 30),
            const SizedBox(width: 5),
            Text(
              coin.symbol.toUpperCase(),
              style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.17),
            if (amount != 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (amount * coin.currentPrice).asCurrencyWith2Decimals(),
                    style: subTitleStyle.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    amount.toString(),
                    style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            if (showChart)
            AppChartWidget(
              coin: coin,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.07,
              showDates: false,
              barWidth: 1,
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  coin.currentPrice.asCurrencyWith2Decimals(),
                  style: subTitleStyle.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (coin.priceChangePercentage24H != null)
                  Text(
                    coin.priceChangePercentage24H!.asPercentString(),
                    style: subTitleStyle.copyWith(
                      color: coin.priceChangePercentage24H! > 0 ? greenClr : redClr,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
