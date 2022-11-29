import 'package:flutter/material.dart';
import 'package:myapp/features/account/widgets/account_button.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);
  @override
  _TopButtonsState createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              onTap: () {},
              text: 'Your Orders',
            ),
            AccountButton(
              onTap: () {},
              text: 'Turn Seller',
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              onTap: () {},
              text: 'Log Out',
            ),
            AccountButton(
              onTap: () {},
              text: 'Your Wishlist',
            ),
          ],
        )
      ],
    );
  }
}
