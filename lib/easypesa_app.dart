import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cross_file/cross_file.dart';
import 'package:gal/gal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class AppColors {
  static const background = Color(0xFFF6F6F7);
  static const surface = Colors.white;
  static const surfaceSoft = Color(0xFFF9FAFB);
  static const textPrimary = Color(0xFF3C3850);
  static const textSecondary = Color(0xFF8B8795);
  static const textMuted = Color(0xFFB9B8C0);
  static const brandGreen = Color(0xFF12C36A);
  static const brandGreenDark = Color(0xFF0A8B60);
  static const tealCard = Color(0xFF0A7666);
  static const tealCardDark = Color(0xFF006B5D);
  static const mint = Color(0xFFBBEEC4);
  static const mint2 = Color(0xFFD8F0B0);
  static const yellow = Color(0xFFE8E596);
  static const divider = Color(0xFFE7E7EA);
  static const shadow = Color(0x14000000);
  static const successBlue = Color(0xFFE2F2FF);
  static const successBlueText = Color(0xFF3E465B);
  static const danger = Color(0xFFE63B3B);
  static const warning = Color(0xFFF4C542);
}

class AppAssets {
  static const digitalBankLogo = 'assets/logos/Header digital bank logo .png';
  static const easypaisaLogo = 'assets/logos/easypaisa_logo.png';
  static const easypaisaWordmark = 'assets/logos/easypaisa_wordmark.png';
  static const easypaisaJpg = 'assets/logos/easypaisa.jpg';
  static const jazzCashBankLogo = 'assets/icons/jazzCash bank logo.jpg';
  static const easypisaBankLogo = 'assets/icons/easypisa bank logo.jpg';
  static const profileAvatar = 'assets/images/profile_avatar.png';
  static const jazzCash = 'assets/brands/jazzcash.png';
  static const easypaisaWallet = 'assets/brands/easypaisa_wallet.png';
  static const moneyBag = 'assets/icons/money_bag.jpg';
  static const sendMoney = 'assets/icons/Send Money icon.png';
  static const billPayment = 'assets/icons/Bill Payment.png';
  static const mobilePackages = 'assets/icons/Mobile Packages .png';
  static const easypaisaTransfer = 'assets/icons/easy paisa trasfer.png';
  static const bankTransfer = 'assets/icons/Bank trasfer.png';
  static const cnicTransfer = 'assets/icons/CNIC Tranfer.png';
  static const raast = 'assets/icons/Raast transfer.png';
  static const wallet = 'assets/icons/wallet.png';
  static const otherWallets = 'assets/icons/Other wallets.png';
  static const scanQr = 'assets/icons/Scan QR.png';
  static const quickCard = 'assets/icons/quick_card.png';
  static const onlineCard = 'assets/icons/online_card.png';
  static const plasticCard = 'assets/icons/plastic_card.png';
  static const walletIcon = 'assets/icons/wallet_icon.png';
  static const easyload = 'assets/icons/Easyload.png';
  static const easycashLoan = 'assets/icons/Easycash Loan.png';
  static const savingsPocket = 'assets/icons/Savings Pocket.png';
  static const inviteAndEarn = 'assets/icons/Invite & Earn.png';
  static const donations = 'assets/icons/Donations.png';
  static const termDeposit = 'assets/icons/Term Deposit.png';
  static const dailyRewards = 'assets/icons/Daily Rewards.png';
  static const buyNowPayLater = 'assets/icons/Buy Now Pay Later.png';
  static const insuranceMarketplace = 'assets/icons/Insurance Marketplace.png';
  static const mTag = 'assets/icons/M-Tag.png';
  static const rsOneGame = 'assets/icons/Rs .1 Game.png';
  static const abhiMicrofinanceBank =
      'assets/logos/abhli micro finance bank.png';
  static const alBarakaIslamicBank = 'assets/logos/Al Baraka islami Bank.jpg';
  static const alfaPay = 'assets/logos/Alfhpla pay.png';
  static const alliedBank = 'assets/logos/allied bank limited logo.jpg';
  static const apnaMicrofinanceBank = 'assets/logos/Apna microfinance bank.jpg';
  static const askariBank = 'assets/logos/Askri bank limited.png';
  static const bankAlHabib = 'assets/logos/Bank Al Habib.jpg';
  static const bankIslami = 'assets/logos/Bank al islami.png';
  static const bankAlfalah = 'assets/logos/Bank Alflah.png';
  static const uMicrofinanceBank = 'assets/logos/u bank.jpg';
  static const habibBank = 'assets/logos/HBL.png';
  static const habibMetropolitanBank =
      'assets/logos/habib metropolin limited.jpg';
  static const mcbBank = 'assets/logos/MCB_Bank_Limited_logo.jpg';
  static const mcbIslamicBank = 'assets/logos/mcb islamic bank.png';
  static const meezanBank = 'assets/logos/Meezan bank.png';
  static const unitedBank = 'assets/logos/ubl digital.png';
  static const nationalBank = 'assets/logos/NBP-Logo.png';
  static const jsBank = 'assets/logos/js bank.png';
}

String formatRs(double value) => value.toStringAsFixed(2);

String initialsFor(String input) {
  final parts = input.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) return '?';
  if (parts.length == 1) {
    final word = parts.first;
    return word.isEmpty ? '?' : word.substring(0, 1).toUpperCase();
  }
  return (parts.first[0] + parts.last[0]).toUpperCase();
}

class AppScale {
  static const double factor = 0.75;

  static double v(num value) => value.toDouble() * factor;
}

extension AppScaleNum on num {
  double get ui => toDouble() * AppScale.factor;
}

/// Additional sizing used only by the home screen.
class HomeScale {
  static const double factor = 1.08;
}

class BankOption {
  const BankOption({
    required this.name,
    required this.asset,
    required this.fallbackColor,
  });

  final String name;
  final String asset;
  final Color fallbackColor;
}

class TransactionRecord {
  const TransactionRecord({
    required this.title,
    required this.time,
    required this.amount,
    required this.isCredit,
    required this.dateLabel,
    this.showRepeat = false,
  });

  final String title;
  final String time;
  final double amount;
  final bool isCredit;
  final String dateLabel;
  final bool showRepeat;
}

class EasyPesaApp extends StatelessWidget {
  const EasyPesaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EasyPesa',
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: const TextScaler.linear(AppScale.factor),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.compact,
          iconTheme: IconThemeData(
            color: AppColors.textPrimary,
            size: AppScale.v(22),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brandGreen),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: AppColors.textPrimary,
              size: AppScale.v(22),
            ),
            titleTextStyle: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppScale.v(22),
              fontWeight: FontWeight.w600,
            ),
          ),
          textTheme: Typography.blackMountainView.apply(
            bodyColor: AppColors.textPrimary,
            displayColor: AppColors.textPrimary,
          ),
          cardTheme: const CardThemeData(
            color: Colors.white,
            surfaceTintColor: Colors.white,
          ),
        ),
        home: const AppShell(),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _pageIndex = 0;

  void _setNavIndex(int navIndex) {
    if (navIndex == 2) {
      _showQrScanner();
      return;
    }

    setState(() {
      _pageIndex = navIndex > 2 ? navIndex - 1 : navIndex;
    });
  }

  Future<void> _showQrScanner() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 64,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: AppColors.brandGreen,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandGreen.withValues(alpha: 0.25),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    color: Colors.white,
                    size: 54,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'QR Scanner',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This can be wired to the live scanner flow next.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.brandGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        onSendMoney: () => showSendMoneySheet(context),
        onOpenPlaceholder: _openPlaceholder,
        onOpenMyAccount: () => setState(() => _pageIndex = 3),
      ),
      const CashPointsScreen(),
      const PromotionsScreen(),
      const MyAccountScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _pageIndex, children: pages),
      bottomNavigationBar: EasyPesaBottomNav(
        selectedIndex: _pageIndex,
        onTap: _setNavIndex,
      ),
    );
  }

  void _openPlaceholder(String title) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ComingSoonScreen(title: title)),
    );
  }
}

void showSendMoneySheet(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.92,
          height: MediaQuery.of(context).size.height * 0.374,
          child: SendMoneySheet(
            onBankTransfer: () {
              final navigator = Navigator.of(context);
              Navigator.of(dialogContext).pop();
              navigator.push(
                MaterialPageRoute<void>(
                  builder: (_) => const BankTransferScreen(),
                ),
              );
            },
            onPlaceholder: (title) {
              final navigator = Navigator.of(context);
              Navigator.of(dialogContext).pop();
              navigator.push(
                MaterialPageRoute<void>(
                  builder: (_) => ComingSoonScreen(title: title),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

class EasyPesaBottomNav extends StatelessWidget {
  const EasyPesaBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 14,
      shadowColor: Colors.black26,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.ui,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _NavItem(
                        index: 0,
                        selectedIndex: selectedIndex,
                        label: 'Home',
                        icon: Icons.home_rounded,
                        onTap: onTap,
                      ),
                    ),
                    Expanded(
                      child: _NavItem(
                        index: 1,
                        selectedIndex: selectedIndex,
                        label: 'Cash Points',
                        icon: Icons.location_on_outlined,
                        onTap: onTap,
                      ),
                    ),
                    SizedBox(width: 54.ui),
                    Expanded(
                      child: _NavItem(
                        index: 3,
                        selectedIndex: selectedIndex,
                        label: 'Promotions',
                        icon: Icons.campaign_outlined,
                        onTap: onTap,
                      ),
                    ),
                    Expanded(
                      child: _NavItem(
                        index: 4,
                        selectedIndex: selectedIndex,
                        label: 'My Account',
                        icon: Icons.person_outline_rounded,
                        onTap: onTap,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -13.5.ui,
                child: GestureDetector(
                  onTap: () => onTap(2),
                  child: Container(
                    width: 51.ui,
                    height: 51.ui,
                    decoration: BoxDecoration(
                      color: AppColors.brandGreen,
                      borderRadius: BorderRadius.circular(13.5.ui),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brandGreen.withValues(alpha: 0.45),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.qr_code_2_rounded,
                      color: Colors.white,
                      size: 25.5.ui,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final String label;
  final IconData icon;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final selected = selectedIndex == index;
    final color = selected ? AppColors.brandGreen : const Color(0xFFB7B7BC);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 46.5.ui,
            height: 3.ui,
            decoration: BoxDecoration(
              color: selected ? AppColors.brandGreen : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          SizedBox(height: 4.5.ui),
          Icon(icon, color: color, size: 22.5.ui),
          SizedBox(height: 3.75.ui),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
          SizedBox(height: 5.25.ui),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onSendMoney,
    required this.onOpenPlaceholder,
    required this.onOpenMyAccount,
  });

  final VoidCallback onSendMoney;
  final ValueChanged<String> onOpenPlaceholder;
  final VoidCallback onOpenMyAccount;

  @override
  Widget build(BuildContext context) {
    final homeMediaQuery = MediaQuery.of(context).copyWith(
      textScaler: TextScaler.linear(AppScale.factor * HomeScale.factor),
    );

    return MediaQuery(
      data: homeMediaQuery,
      child: SafeArea(
        bottom: false,
        child: ListView(
          key: const PageStorageKey<String>('home-page'),
          padding: EdgeInsets.only(bottom: 112.ui),
          children: [
            _HomeHeaderCluster(
              onSearch: () => onOpenPlaceholder('Search'),
              onNotifications: () => onOpenPlaceholder('Notifications'),
              onLogout: () => onOpenPlaceholder('Logout'),
              onSignIn: onSendMoney,
            ),
            SizedBox(height: 18.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ui),
              child: Row(
                children: [
                  Expanded(
                    child: QuickActionCard(
                      title: 'Send Money',
                      asset: AppAssets.sendMoney,
                      fallbackIcon: Icons.send_outlined,
                      onTap: onSendMoney,
                    ),
                  ),
                  SizedBox(width: 16.ui),
                  Expanded(
                    child: QuickActionCard(
                      title: 'Bill Payment',
                      asset: AppAssets.billPayment,
                      fallbackIcon: Icons.receipt_long_outlined,
                      onTap: () => onOpenPlaceholder('Bill Payment'),
                    ),
                  ),
                  SizedBox(width: 16.ui),
                  Expanded(
                    child: QuickActionCard(
                      title: 'Mobile\nPackages',
                      asset: AppAssets.mobilePackages,
                      fallbackIcon: Icons.phone_iphone_outlined,
                      onTap: () => onOpenPlaceholder('Mobile Packages'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ui),
              child: const Text(
                'More with easypaisa',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            SizedBox(height: 12.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ui),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.ui),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 26,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(12.ui, 16.ui, 12.ui, 14.ui),
                child: Column(
                  children: [
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.92,
                      children: [
                        FeatureTile(
                          title: 'Easyload',
                          asset: AppAssets.easyload,
                          fallbackIcon: Icons.add_card_outlined,
                          onTap: () => onOpenPlaceholder('Easyload'),
                        ),
                        FeatureTile(
                          title: 'Easycash\nLoan',
                          asset: AppAssets.easycashLoan,
                          fallbackIcon: Icons.volunteer_activism_outlined,
                          onTap: () => onOpenPlaceholder('Easycash Loan'),
                        ),
                        FeatureTile(
                          title: 'Savings\nPocket',
                          asset: AppAssets.savingsPocket,
                          fallbackIcon: Icons.savings_outlined,
                          onTap: () => onOpenPlaceholder('Savings Pocket'),
                        ),
                        FeatureTile(
                          title: 'Invite\n& Earn',
                          asset: AppAssets.inviteAndEarn,
                          fallbackIcon: Icons.people_outline_rounded,
                          onTap: () => onOpenPlaceholder('Invite & Earn'),
                        ),
                        FeatureTile(
                          title: 'Donations',
                          asset: AppAssets.donations,
                          fallbackIcon: Icons.volunteer_activism_outlined,
                          onTap: () => onOpenPlaceholder('Donations'),
                        ),
                        FeatureTile(
                          title: 'Term\nDeposit',
                          asset: AppAssets.termDeposit,
                          fallbackIcon: Icons.account_balance_wallet_outlined,
                          onTap: () => onOpenPlaceholder('Term Deposit'),
                        ),
                        FeatureTile(
                          title: 'Daily\nRewards',
                          asset: AppAssets.dailyRewards,
                          fallbackIcon: Icons.card_giftcard_outlined,
                          onTap: () => onOpenPlaceholder('Daily Rewards'),
                        ),
                        FeatureTile(
                          title: 'Buy Now\nPay Later',
                          asset: AppAssets.buyNowPayLater,
                          fallbackIcon: Icons.calendar_month_outlined,
                          onTap: () => onOpenPlaceholder('Buy Now Pay Later'),
                        ),
                        FeatureTile(
                          title: 'Insurance\nMarketplace',
                          asset: AppAssets.insuranceMarketplace,
                          fallbackIcon: Icons.umbrella_outlined,
                          onTap: () =>
                              onOpenPlaceholder('Insurance Marketplace'),
                        ),
                        FeatureTile(
                          title: 'M-Tag',
                          asset: AppAssets.mTag,
                          fallbackIcon: Icons.route_outlined,
                          onTap: () => onOpenPlaceholder('M-Tag'),
                        ),
                        FeatureTile(
                          title: 'Rs.1 Game',
                          asset: AppAssets.rsOneGame,
                          fallbackIcon: Icons.celebration_outlined,
                          onTap: () => onOpenPlaceholder('Rs.1 Game'),
                        ),
                        FeatureTile(
                          title: 'See All',
                          asset: AppAssets.quickCard,
                          fallbackIcon: Icons.more_horiz_rounded,
                          onTap: () => onOpenPlaceholder('More services'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.ui),
                    const _DotsIndicator(activeIndex: 0, count: 2),
                  ],
                ),
              ),
            ),
            SizedBox(height: 22.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ui),
              child: const Text(
                'Get your easypaisa Debit Card',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            SizedBox(height: 12.ui),
            SizedBox(
              height: 196.ui,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.ui),
                scrollDirection: Axis.horizontal,
                children: [
                  DebitCardTile(
                    title: 'Online Card',
                    subtitle: 'Only for Online\nPayments in Pakistan',
                    backgroundColor: const Color(0xFF438E83),
                    accentColor: const Color(0xFFF9D780),
                    asset: AppAssets.onlineCard,
                    onTap: () => onOpenPlaceholder('Online Card'),
                  ),
                  SizedBox(width: 18.ui),
                  DebitCardTile(
                    title: 'Plastic Card',
                    subtitle: 'Use at any ATM or\nShop in Pakistan',
                    backgroundColor: const Color(0xFF3C3D4D),
                    accentColor: const Color(0xFFF9D780),
                    asset: AppAssets.plasticCard,
                    onTap: () => onOpenPlaceholder('Plastic Card'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.ui),
          ],
        ),
      ),
    );
  }
}

class _HomeHeaderCluster extends StatelessWidget {
  const _HomeHeaderCluster({
    required this.onSearch,
    required this.onNotifications,
    required this.onLogout,
    required this.onSignIn,
  });

  final VoidCallback onSearch;
  final VoidCallback onNotifications;
  final VoidCallback onLogout;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    const headerBoost = 1.18;
    const heroBoost = 1.1;
    const cardBoost = 1.12;

    final headerHeight = AppScale.v(122) * headerBoost;
    final lowerPanelHeight = AppScale.v(88) * headerBoost;
    final cardTop = AppScale.v(82) * headerBoost;

    return SizedBox(
      height: headerHeight + lowerPanelHeight + AppScale.v(96) * headerBoost,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              _HomeHero(
                height: headerHeight,
                scale: heroBoost,
                onSearch: onSearch,
                onNotifications: onNotifications,
                onLogout: onLogout,
              ),
              Container(
                height: lowerPanelHeight,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFFF0FAF0)),
              ),
            ],
          ),
          Positioned(
            left: 14.ui,
            right: 14.ui,
            top: cardTop,
            child: _AccountCard(onSignIn: onSignIn, scale: cardBoost),
          ),
        ],
      ),
    );
  }
}

class _HomeHero extends StatelessWidget {
  const _HomeHero({
    required this.height,
    required this.scale,
    required this.onSearch,
    required this.onNotifications,
    required this.onLogout,
  });

  final double height;
  final double scale;
  final VoidCallback onSearch;
  final VoidCallback onNotifications;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.mint, AppColors.yellow, Color(0xFFA8E5BE)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16.ui,
            left: 16.ui,
            child: SizedBox(
              width: 42.ui * scale * HomeScale.factor,
              height: 42.ui * scale * HomeScale.factor,
              child: ClipOval(
                child: Image.asset(
                  AppAssets.profileAvatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF5B5C69), Color(0xFFB3B7B9)],
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28.ui * scale * HomeScale.factor,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.ui,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 96.ui * scale * HomeScale.factor,
                child: Image.asset(
                  AppAssets.digitalBankLogo,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const _DigitalBankFallback();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 20.ui,
            right: 96.ui,
            child: IconButton(
              onPressed: onSearch,
              icon: Icon(
                Icons.search_rounded,
                color: AppColors.textPrimary,
                size: 27.3.ui * scale * HomeScale.factor,
              ),
            ),
          ),
          Positioned(
            top: 20.ui,
            right: 52.ui,
            child: IconButton(
              onPressed: onNotifications,
              icon: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textPrimary,
                size: 27.3.ui * scale * HomeScale.factor,
              ),
            ),
          ),
          Positioned(
            top: 20.ui,
            right: 8.ui,
            child: IconButton(
              onPressed: onLogout,
              icon: Icon(
                Icons.logout_rounded,
                color: AppColors.danger,
                size: 27.3.ui * scale * HomeScale.factor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DigitalBankFallback extends StatelessWidget {
  const _DigitalBankFallback();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 39.ui,
          height: 39.ui,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 21.ui,
                height: 21.ui,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.textPrimary,
                    width: 4.5.ui,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                bottom: 6.75.ui,
                child: Container(
                  width: 21.ui,
                  height: 10.5.ui,
                  decoration: const BoxDecoration(
                    color: AppColors.brandGreen,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 6.ui),
        const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'digital',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 0.92,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'bank',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 0.92,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.onSignIn, required this.scale});

  final VoidCallback onSignIn;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.tealCard,
        borderRadius: BorderRadius.circular(18.ui * scale),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        16.ui * scale,
        14.ui * scale,
        16.ui * scale,
        16.ui * scale,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 9.ui * scale,
                  vertical: 6.ui * scale,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6.ui * scale),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.white,
                      size: 16.ui * scale * HomeScale.factor,
                    ),
                    SizedBox(width: 6.ui * scale),
                    Text(
                      'easypaisa Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12 * scale,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'My Rewards',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8.ui * scale),
                  Container(
                    width: 28.ui * scale,
                    height: 28.ui * scale,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFE082),
                      size: 18.ui * scale,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18.ui * scale),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.ui * scale),
                    Row(
                      children: [
                        Text(
                          'Rs. 24,590',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.ui * scale),
                        Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.white,
                          size: 23.ui * scale,
                        ),
                      ],
                    ),
                    SizedBox(height: 3.ui * scale),
                    Text(
                      'Tap to hide balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12 * scale,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.ui * scale),
              Column(
                children: [
                  SizedBox(
                    width: 110.ui * scale,
                    child: OutlinedButton(
                      onPressed: onSignIn,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: AppColors.brandGreen,
                          width: 1.5.ui * scale,
                        ),
                        minimumSize: Size.fromHeight(30.ui * scale),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.ui * scale),
                        ),
                      ),
                      child: Text(
                        'Upgrade Account',
                        style: TextStyle(
                          fontSize: 10.5 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.ui * scale),
                  SizedBox(
                    width: 110.ui * scale,
                    child: FilledButton(
                      onPressed: onSignIn,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.brandGreen,
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(30.ui * scale),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.ui * scale),
                        ),
                      ),
                      child: Text(
                        'Add Cash',
                        style: TextStyle(
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.title,
    required this.asset,
    required this.fallbackIcon,
    required this.onTap,
  });

  final String title;
  final String asset;
  final IconData fallbackIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.ui),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(18.ui),
        onTap: onTap,
        child: Container(
          height: 93.ui,
          padding: EdgeInsets.fromLTRB(6.ui, 9.ui, 6.ui, 7.5.ui),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.ui),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: AssetOrIcon(
                    asset: asset,
                    fallbackIcon: fallbackIcon,
                    size: 63.ui * HomeScale.factor,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 4.5.ui),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.05,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  const FeatureTile({
    super.key,
    required this.title,
    required this.asset,
    required this.fallbackIcon,
    required this.onTap,
  });

  final String title;
  final String asset;
  final IconData fallbackIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13.5.ui),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AssetOrIcon(
            asset: asset,
            fallbackIcon: fallbackIcon,
            size: 60.ui * HomeScale.factor,
            color: AppColors.textPrimary,
          ),
          SizedBox(height: 4.5.ui),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 11,
              height: 1.05,
              fontWeight: FontWeight.w500,
              color: Color(0xFF403B4C),
            ),
          ),
        ],
      ),
    );
  }
}

class DebitCardTile extends StatelessWidget {
  const DebitCardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.accentColor,
    required this.asset,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color accentColor;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(19.5.ui),
      child: InkWell(
        borderRadius: BorderRadius.circular(19.5.ui),
        onTap: onTap,
        child: Container(
          width: 247.5.ui,
          padding: EdgeInsets.fromLTRB(16.5.ui, 22.5.ui, 16.5.ui, 16.5.ui),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.5.ui),
            color: backgroundColor,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      height: 1.05,
                    ),
                  ),
                  SizedBox(height: 10.5.ui),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 18.5,
                      height: 1.15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 4,
                child: AssetOrIcon(
                  asset: asset,
                  fallbackIcon: Icons.credit_card_rounded,
                  size: 57.ui * HomeScale.factor,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssetOrIcon extends StatelessWidget {
  const AssetOrIcon({
    super.key,
    required this.asset,
    required this.fallbackIcon,
    required this.size,
    this.color,
  });

  final String asset;
  final IconData fallbackIcon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(fallbackIcon, size: size, color: color);
      },
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({required this.activeIndex, required this.count});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final active = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: index == count - 1 ? 0 : 10),
          width: active ? 12 : 12,
          height: 12,
          decoration: BoxDecoration(
            color: active ? AppColors.brandGreen : const Color(0xFFD8D8D8),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

class SendMoneySheet extends StatelessWidget {
  const SendMoneySheet({
    super.key,
    required this.onBankTransfer,
    required this.onPlaceholder,
  });

  final VoidCallback onBankTransfer;
  final ValueChanged<String> onPlaceholder;

  @override
  Widget build(BuildContext context) {
    final options = <_SheetOption>[
      _SheetOption(
        'easypaisa\nTransfer',
        AppAssets.easypaisaTransfer,
        Icons.currency_exchange_rounded,
        AppColors.textPrimary,
        () => onPlaceholder('easypaisa Transfer'),
      ),
      _SheetOption(
        'Bank\nTransfer',
        AppAssets.bankTransfer,
        Icons.account_balance_outlined,
        AppColors.textPrimary,
        onBankTransfer,
      ),
      _SheetOption(
        'CNIC\nTransfer',
        AppAssets.cnicTransfer,
        Icons.badge_outlined,
        AppColors.textPrimary,
        () => onPlaceholder('CNIC Transfer'),
      ),
      _SheetOption(
        'Raast\nPayment',
        AppAssets.raast,
        Icons.account_balance_outlined,
        AppColors.textPrimary,
        () => onPlaceholder('Raast Payment'),
      ),
      _SheetOption(
        'Other\nWallets',
        AppAssets.otherWallets,
        Icons.account_balance_wallet_outlined,
        AppColors.textPrimary,
        () => onPlaceholder('Other Wallets'),
      ),
      _SheetOption(
        'Scan QR',
        AppAssets.scanQr,
        Icons.qr_code_scanner_rounded,
        AppColors.textPrimary,
        () => onPlaceholder('Scan QR'),
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Send Money To',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 22),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 0.93,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                children: options
                    .map(
                      (option) => _SheetActionCard(
                        title: option.title,
                        asset: option.asset,
                        fallbackIcon: option.fallbackIcon,
                        color: option.color,
                        onTap: option.onTap,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetOption {
  const _SheetOption(
    this.title,
    this.asset,
    this.fallbackIcon,
    this.color,
    this.onTap,
  );

  final String title;
  final String asset;
  final IconData fallbackIcon;
  final Color color;
  final VoidCallback onTap;
}

class _SheetActionCard extends StatelessWidget {
  const _SheetActionCard({
    required this.title,
    required this.asset,
    required this.fallbackIcon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String asset;
  final IconData fallbackIcon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.ui),
        side: const BorderSide(color: Color(0xFFE4E4E8)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.ui),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(7.5.ui, 10.5.ui, 7.5.ui, 9.ui),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: AssetOrIcon(
                    asset: asset,
                    fallbackIcon: fallbackIcon,
                    size: 50.625.ui,
                    color: color,
                  ),
                ),
              ),
              SizedBox(height: 4.5.ui),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({super.key});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late final TabController _tabController;

  final List<BankOption> _banks = const [
    BankOption(
      name: 'JazzCash',
      asset: AppAssets.jazzCashBankLogo,
      fallbackColor: AppColors.brandGreen,
    ),
    BankOption(
      name: 'Easypaisa  Bank',
      asset: AppAssets.easypisaBankLogo,
      fallbackColor: AppColors.brandGreen,
    ),
    BankOption(
      name: 'ABHI Microfinance Bank',
      asset: AppAssets.abhiMicrofinanceBank,
      fallbackColor: Color(0xFF273A53),
    ),
    BankOption(
      name: 'Al Baraka Islamic Bank Limited',
      asset: AppAssets.alBarakaIslamicBank,
      fallbackColor: Color(0xFFEF4C6F),
    ),
    BankOption(
      name: 'Alfa Pay',
      asset: AppAssets.alfaPay,
      fallbackColor: Color(0xFFE8492E),
    ),
    BankOption(
      name: 'Allied Bank Limited',
      asset: AppAssets.alliedBank,
      fallbackColor: Color(0xFF3474C6),
    ),
    BankOption(
      name: 'Apna Microfinance Bank',
      asset: AppAssets.apnaMicrofinanceBank,
      fallbackColor: Color(0xFF7DAD2C),
    ),
    BankOption(
      name: 'Askari Commercial Bank Limited',
      asset: AppAssets.askariBank,
      fallbackColor: Color(0xFF2C8BC8),
    ),
    BankOption(
      name: 'Bank Al Habib Limited',
      asset: AppAssets.bankAlHabib,
      fallbackColor: Color(0xFF20794F),
    ),
    BankOption(
      name: 'Bank Alfalah',
      asset: AppAssets.bankAlfalah,
      fallbackColor: Color(0xFFF3683B),
    ),
    BankOption(
      name: 'BankIslami',
      asset: AppAssets.bankIslami,
      fallbackColor: Color(0xFF0D7F4F),
    ),
    BankOption(
      name: 'U Microfinance Bank',
      asset: AppAssets.uMicrofinanceBank,
      fallbackColor: Color(0xFF1D6C91),
    ),
    BankOption(
      name: 'Habib Bank Limited (HBL)',
      asset: AppAssets.habibBank,
      fallbackColor: Color(0xFF0A5B9A),
    ),
    BankOption(
      name: 'Habib Metropolitan Bank Limited',
      asset: AppAssets.habibMetropolitanBank,
      fallbackColor: Color(0xFF1E3A8A),
    ),
    BankOption(
      name: 'MCB Bank Limited',
      asset: AppAssets.mcbBank,
      fallbackColor: Color(0xFF00529B),
    ),
    BankOption(
      name: 'MCB Islamic Bank Limited',
      asset: AppAssets.mcbIslamicBank,
      fallbackColor: Color(0xFF008B62),
    ),
    BankOption(
      name: 'Meezan Bank Limited',
      asset: AppAssets.meezanBank,
      fallbackColor: Color(0xFF008B62),
    ),
    BankOption(
      name: 'United Bank Limited (UBL)',
      asset: AppAssets.unitedBank,
      fallbackColor: Color(0xFF008A5B),
    ),
    BankOption(
      name: 'National Bank of Pakistan (NBP)',
      asset: AppAssets.nationalBank,
      fallbackColor: Color(0xFF005B4F),
    ),
    BankOption(
      name: 'JS Bank Limited',
      asset: AppAssets.jsBank,
      fallbackColor: Color(0xFF1E3A8A),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<BankOption> get _filteredBanks {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _banks;
    return _banks
        .where((bank) => bank.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SimpleAppBar(
              title: 'Bank Transfer',
              rightText: 'Help',
              onBack: () => Navigator.of(context).pop(),
            ),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.brandGreen,
              unselectedLabelColor: const Color(0xFF9E9E9E),
              labelStyle: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
              indicatorColor: AppColors.brandGreen,
              indicatorWeight: 4,
              tabs: const [
                Tab(text: 'Send Money'),
                Tab(text: 'History'),
              ],
            ),
            SizedBox(height: 10.5.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.ui),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F6),
                  borderRadius: BorderRadius.circular(25.5.ui),
                ),
                padding: EdgeInsets.symmetric(horizontal: 13.5.ui),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Bank by Name',
                    hintStyle: const TextStyle(
                      fontSize: 23,
                      color: Color(0xFF5F5C6E),
                    ),
                    suffixIcon: Icon(
                      Icons.search_rounded,
                      size: 24.ui,
                      color: const Color(0xFFB6B6B8),
                    ),
                  ),
                  style: const TextStyle(fontSize: 23),
                ),
              ),
            ),
            SizedBox(height: 13.5.ui),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.separated(
                    padding: EdgeInsets.fromLTRB(9.ui, 3.ui, 9.ui, 13.5.ui),
                    itemCount: _filteredBanks.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: Color(0xFFEDEDF1)),
                    itemBuilder: (context, index) {
                      final bank = _filteredBanks[index];
                      return BankTile(
                        bank: bank,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => TransferFormScreen(
                                bankName: bank.name,
                                logoAsset: bank.asset,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const Center(
                    child: Text(
                      'History will be wired here next.',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BankTile extends StatelessWidget {
  const BankTile({super.key, required this.bank, required this.onTap});

  final BankOption bank;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.5.ui, vertical: 22.ui),
        child: Row(
          children: [
            BankLogo(
              name: bank.name,
              asset: bank.asset,
              fallbackColor: bank.fallbackColor,
              size: 80.ui,
            ),
            SizedBox(width: 15.ui),
            Expanded(
              child: Text(
                bank.name,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 7.5.ui),
            Icon(
              Icons.chevron_right_rounded,
              size: 28.5.ui,
              color: const Color(0xFF454054),
            ),
          ],
        ),
      ),
    );
  }
}

class BankLogo extends StatelessWidget {
  const BankLogo({
    super.key,
    required this.name,
    required this.asset,
    required this.fallbackColor,
    required this.size,
    this.circle = false,
  });

  final String name;
  final String asset;
  final Color fallbackColor;
  final double size;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    final fallback = circle
        ? _BrandInitialsCircle(
            initials: initialsFor(name),
            size: size,
            backgroundColor: fallbackColor.withValues(alpha: 0.12),
            foregroundColor: fallbackColor,
          )
        : _BrandInitialsBox(
            initials: initialsFor(name),
            size: size,
            backgroundColor: fallbackColor.withValues(alpha: 0.10),
            foregroundColor: fallbackColor,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(circle ? 999 : 9.ui),
      child: Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => fallback,
      ),
    );
  }
}

class _BrandInitialsBox extends StatelessWidget {
  const _BrandInitialsBox({
    required this.initials,
    required this.size,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String initials;
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9.ui),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: foregroundColor,
          fontSize: size * 0.24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _BrandInitialsCircle extends StatelessWidget {
  const _BrandInitialsCircle({
    required this.initials,
    required this.size,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String initials;
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Text(
        initials,
        style: TextStyle(
          color: foregroundColor,
          fontSize: size * 0.24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class TransferFormScreen extends StatefulWidget {
  const TransferFormScreen({
    super.key,
    required this.bankName,
    required this.logoAsset,
  });

  final String bankName;
  final String logoAsset;

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _purposeController = TextEditingController(
    text: 'Others',
  );
  final int _selectedReceiverDetail = 0;

  @override
  void dispose() {
    _accountController.dispose();
    _recipientNameController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _accountController.text.trim().isNotEmpty &&
      _recipientNameController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SimpleAppBar(
              title: 'Send Money',
              onBack: () => Navigator.of(context).pop(),
            ),
            Container(
              width: double.infinity,
              color: const Color(0xFFF3FBF4),
              padding: EdgeInsets.fromLTRB(15.ui, 13.5.ui, 15.ui, 25.5.ui),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sending to Bank Account',
                    style: TextStyle(
                      color: Color(0xFF4B4218),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      BankLogo(
                        name: widget.bankName,
                        asset: widget.logoAsset,
                        fallbackColor: AppColors.brandGreen,
                        size: 82.5.ui,
                        circle: true,
                      ),
                      SizedBox(width: 13.5.ui),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.bankName,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 7.5.ui),
                            Icon(
                              Icons.account_balance_outlined,
                              color: AppColors.brandGreen,
                              size: 28.5.ui,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(18.ui, 31.5.ui, 18.ui, 21.ui),
                children: [
                  const Text(
                    "Select Receiver's Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 19.5.ui),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: _RadioRow(
                  //         selected: _selectedReceiverDetail == 0,
                  //         label: 'Account Number',
                  //         onTap: () => setState(() => _selectedReceiverDetail = 0),
                  //       ),
                  //     ),
                  //     SizedBox(width: 18.ui),
                  //     Expanded(
                  //       child: _RadioRow(
                  //         selected: _selectedReceiverDetail == 1,
                  //         label: 'IBAN',
                  //         onTap: () => setState(() => _selectedReceiverDetail = 1),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 43.5.ui),
                  const Text(
                    'Enter Account Number',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 12.ui),
                  Container(
                    height: 66.ui,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.5.ui),
                      border: Border.all(
                        color: const Color(0xFFE0E0E4),
                        width: 1.6,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4.5.ui,
                          margin: EdgeInsets.symmetric(vertical: 7.5.ui),
                          decoration: BoxDecoration(
                            color: AppColors.brandGreen,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _accountController,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 13.5,
                                vertical: 18,
                              ),
                              hintText: 'Enter Account Number',
                              hintStyle: TextStyle(
                                color: Color(0xFFC7C7CD),
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21.ui),
                  const Text(
                    'Enter Recipient Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 12.ui),
                  Container(
                    height: 66.ui,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.5.ui),
                      border: Border.all(
                        color: const Color(0xFFE0E0E4),
                        width: 1.6,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4.5.ui,
                          margin: EdgeInsets.symmetric(vertical: 7.5.ui),
                          decoration: BoxDecoration(
                            color: AppColors.brandGreen,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _recipientNameController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 13.5,
                                vertical: 18,
                              ),
                              hintText: 'Enter Recipient Name',
                              hintStyle: TextStyle(
                                color: Color(0xFFC7C7CD),
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21.ui),
                  const Text(
                    'Select Purpose of Payment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 12.ui),
                  InkWell(
                    onTap: () => setState(() {}),
                    borderRadius: BorderRadius.circular(13.5.ui),
                    child: Container(
                      height: 61.5.ui,
                      padding: EdgeInsets.symmetric(horizontal: 15.ui),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13.5.ui),
                        border: Border.all(
                          color: const Color(0xFFE0E0E4),
                          width: 1.6,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Others',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 33,
                            color: Color(0xFF454054),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 36.ui),
                  SizedBox(
                    height: 51.ui,
                    child: FilledButton(
                      onPressed: _canContinue
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => AmountEntryScreen(
                                    bankName: widget.bankName,
                                    logoAsset: widget.logoAsset,
                                    accountNumber: _accountController.text
                                        .trim(),
                                    recipientName: _recipientNameController.text
                                        .trim(),
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.brandGreen,
                        disabledBackgroundColor: const Color(0xFFD9DDE1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.5.ui),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: _canContinue ? Colors.white : Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioRow extends StatelessWidget {
  const _RadioRow({
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? AppColors.brandGreen
                    : const Color(0xFF6D6881),
                width: 2.2,
              ),
            ),
            padding: const EdgeInsets.all(5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: selected ? AppColors.brandGreen : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class AmountEntryScreen extends StatefulWidget {
  const AmountEntryScreen({
    super.key,
    required this.bankName,
    required this.logoAsset,
    required this.accountNumber,
    required this.recipientName,
  });

  final String bankName;
  final String logoAsset;
  final String accountNumber;
  final String recipientName;

  @override
  State<AmountEntryScreen> createState() => _AmountEntryScreenState();
}

class _AmountEntryScreenState extends State<AmountEntryScreen> {
  late final TextEditingController _amountController;

  int get _amount => int.tryParse(_amountController.text) ?? 0;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '0');
    _amountController.selection = const TextSelection(
      baseOffset: 0,
      extentOffset: 1,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SimpleAppBar(
              title: 'Send Money',
              onBack: () => Navigator.of(context).pop(),
            ),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 251, 254, 252),
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sending to Bank Account',
                    style: TextStyle(
                      color: Color.fromARGB(255, 37, 37, 37),
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      BankLogo(
                        name: widget.bankName,
                        asset: widget.logoAsset,
                        fallbackColor: AppColors.brandGreen,
                        size: 70,
                        circle: true,
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.bankName,
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.account_balance_outlined,
                                  color: AppColors.brandGreen,
                                  size: 21,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.accountNumber,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter Amount',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 54),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Rs. ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 14, 13, 15),
                          ),
                        ),
                        SizedBox(
                          width: 230,
                          child: TextField(
                            controller: _amountController,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (_) => setState(() {}),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(
                              fontSize: 54,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 62),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: _amount > 0
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => ReviewTransferScreen(
                                      amount: _amount.toDouble(),
                                      bankName: widget.bankName,
                                      logoAsset: widget.logoAsset,
                                      accountNumber: widget.accountNumber,
                                      recipientName: widget.recipientName,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.brandGreen,
                          disabledBackgroundColor: const Color(0xFFD9DDE1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewTransferScreen extends StatefulWidget {
  const ReviewTransferScreen({
    super.key,
    required this.amount,
    required this.bankName,
    required this.logoAsset,
    required this.accountNumber,
    required this.recipientName,
  });

  final double amount;
  final String bankName;
  final String logoAsset;
  final String accountNumber;
  final String recipientName;

  @override
  State<ReviewTransferScreen> createState() => _ReviewTransferScreenState();
}

class _ReviewTransferScreenState extends State<ReviewTransferScreen> {
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        title: const Text(
          'Send Money',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 30),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
        children: [
          const Text(
            'Pay From',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          _ReviewCard(
            child: Row(
              children: [
                BankLogo(
                  name: 'easypaisa',
                  asset: AppAssets.moneyBag,
                  fallbackColor: AppColors.brandGreen,
                  size: 44,
                  circle: true,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'easypaisa Account:\n',
                          style: TextStyle(
                            fontSize: 23,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: 'Balance Rs. 25000.44',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Pay To',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _ReviewCard(
            child: Column(
              children: [
                _ReviewRow(label: 'Account Title', value: widget.recipientName),
                const SizedBox(height: 24),
                _ReviewRow(
                  label: 'Account Number',
                  value: widget.accountNumber,
                ),
                const SizedBox(height: 24),
                _ReviewRow(
                  label: 'IBAN',
                  value: 'PK41JCMA0604923191981267',
                  valueStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Payment Summary',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _ReviewCard(
            child: Column(
              children: [
                _ReviewRow(
                  label: 'Transfer Amount',
                  value: 'Rs. ${widget.amount.toStringAsFixed(0)}',
                ),
                const SizedBox(height: 24),
                _ReviewRow(label: 'Fee (including tax)', value: 'Free'),
                const SizedBox(height: 24),
                _ReviewRow(
                  label: 'Total Amount',
                  value: 'Rs. ${widget.amount.toStringAsFixed(2)}',
                  valueStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _FavoriteContactCard(
            selected: _favorite,
            onTap: () => setState(() => _favorite = !_favorite),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF3F3E52), width: 2),
            ),
            child: const Row(
              children: [
                Icon(Icons.info, color: Color(0xFF3F3E52), size: 24),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Please review the details carefully before sending money.',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 6, 24, 24),
          child: SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => SendingScreen(
                      amount: widget.amount,
                      bankName: widget.bankName,
                      logoAsset: widget.logoAsset,
                      recipientAccount: widget.accountNumber,
                      recipientName: widget.recipientName,
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brandGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
              ),
              child: Text(
                'Send Rs. ${widget.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            label,
            style:
                labelStyle ??
                const TextStyle(fontSize: 24, color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style:
                valueStyle ??
                const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
          ),
        ),
      ],
    );
  }
}

class _FavoriteContactCard extends StatelessWidget {
  const _FavoriteContactCard({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                border: Border.all(
                  color: selected
                      ? AppColors.brandGreen
                      : const Color(0xFFBDBDC4),
                  width: 2.4,
                ),
                color: selected ? AppColors.brandGreen : Colors.white,
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 10,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Favourite Contact',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Add this recipient as a favourite for easypayments in the future.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFABA7B1),
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendingScreen extends StatefulWidget {
  const SendingScreen({
    super.key,
    required this.amount,
    required this.bankName,
    required this.logoAsset,
    required this.recipientAccount,
    required this.recipientName,
  });

  final double amount;
  final String bankName;
  final String logoAsset;
  final String recipientAccount;
  final String recipientName;

  @override
  State<SendingScreen> createState() => _SendingScreenState();
}

class _SendingScreenState extends State<SendingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => TransferSuccessScreen(
            amount: widget.amount,
            bankName: widget.bankName,
            logoAsset: widget.logoAsset,
            recipientAccount: widget.recipientAccount,
            recipientName: widget.recipientName,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 18),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.close_rounded,
                  size: 44,
                  color: Color(0xFFBBBBBB),
                ),
              ),
              const Spacer(flex: 2),
              Column(
                children: [
                  const Text(
                    'Sending',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Rs.${widget.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 34),
                  Text(
                    'to ${widget.recipientName}\n${widget.recipientAccount}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 1.14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(flex: 2),
              SizedBox(
                height: 140,
                child: Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.rotate(
                            angle: value * 2 * math.pi,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: AppColors.brandGreen,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 22,
                            child: Icon(
                              Icons.account_balance_wallet_outlined,
                              color: AppColors.brandGreen,
                              size: 84,
                            ),
                          ),
                          const Positioned(
                            right: 18,
                            child: Icon(
                              Icons.account_balance_outlined,
                              color: AppColors.brandGreen,
                              size: 78,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const Spacer(flex: 2),
              const Text(
                'Please wait',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class TransferSuccessScreen extends StatelessWidget {
  const TransferSuccessScreen({
    super.key,
    required this.amount,
    required this.bankName,
    required this.logoAsset,
    required this.recipientAccount,
    required this.recipientName,
  });

  final double amount;
  final String bankName;
  final String logoAsset;
  final String recipientAccount;
  final String recipientName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 38,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 17, 219, 118),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 56),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 22.0),
                        child: const Text(
                          'Rs ',
                          style: TextStyle(
                            fontFamily: 'Google Sans',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 14, 14, 15),
                          ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: amount.toStringAsFixed(0),
                      style: const TextStyle(
                        fontFamily: 'Google Sanssf',
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                    const TextSpan(
                      text: '.00',
                      style: TextStyle(
                        fontFamily: 'Google Sans',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                'Successfully Sent to',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 14, 14, 15),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      2,
                    ), // Space between logo and border
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.brandGreen, width: 2),
                    ),
                    child: BankLogo(
                      name: bankName,
                      asset: logoAsset,
                      fallbackColor: AppColors.brandGreen,
                      size: 55,
                      circle: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: Text(
                recipientName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 15, 14, 15),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                recipientAccount,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // const SizedBox(height: 26),
            const SizedBox(height: 26),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Text(
                'Important Details for you',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(height: 1, color: const Color(0xFFEDEDF1)),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Text(
                "Money has been sent from easypaisa to receiver's bank account. To confirm check with the receiver",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 1.15,
                ),
              ),
            ),
            const SizedBox(height: 18),
            _SuccessActionRow(
              icon: Icons.receipt_long_outlined,
              label: 'View Receipt',
              onTap: () => showReceiptDialog(
                context,
                amount: amount,
                bankName: bankName,
                recipientName: recipientName,
                recipientAccount: recipientAccount,
              ),
            ),
            _SuccessActionRow(
              icon: Icons.share_outlined,
              label: 'Share',
              onTap: () => showReceiptDialog(
                context,
                amount: amount,
                bankName: bankName,
                recipientName: recipientName,
                recipientAccount: recipientAccount,
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}

class _SuccessActionRow extends StatelessWidget {
  const _SuccessActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1, color: Color(0xFFEDEDF1)),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 29,
                  color: const Color.fromARGB(255, 53, 52, 53),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 42,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _formatReceiptDateTime(DateTime dateTime) {
  const monthNames = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';
  return '${dateTime.day} ${monthNames[dateTime.month - 1]} ${dateTime.year} '
      '${hour.toString().padLeft(2, '0')}:$minute $period';
}

class _TornReceiptClipper extends CustomClipper<Path> {
  const _TornReceiptClipper();

  static const double tearDepth = 2;
  static const double toothWidth = 3;

  @override
  Path getClip(Size size) {
    final path = Path()..moveTo(0, tearDepth);

    var index = 0;
    for (double x = 0; x <= size.width; x += toothWidth) {
      path.lineTo(x, index.isEven ? 0 : tearDepth);
      index++;
    }

    path.lineTo(size.width, size.height - tearDepth);

    index = 0;
    for (double x = size.width; x >= 0; x -= toothWidth) {
      path.lineTo(x, index.isEven ? size.height : size.height - tearDepth);
      index++;
    }

    path.lineTo(0, tearDepth);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _TornReceiptClipper oldClipper) => false;
}

Future<void> showReceiptDialog(
  BuildContext context, {
  required double amount,
  String? bankName,
  required String recipientName,
  required String recipientAccount,
}) {
  final receiptDateTime = _formatReceiptDateTime(DateTime.now());
  final receiptKey = GlobalKey();
  var isProcessing = false;

  Future<Uint8List> captureReceipt() async {
    await WidgetsBinding.instance.endOfFrame;
    final renderObject = receiptKey.currentContext?.findRenderObject();
    if (renderObject is! RenderRepaintBoundary) {
      throw StateError('The receipt is not ready to capture.');
    }

    final image = await renderObject.toImage(pixelRatio: 3);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) {
        throw StateError('Unable to create the receipt image.');
      }
      return data.buffer.asUint8List();
    } finally {
      image.dispose();
    }
  }

  void showResultMessage(String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> runReceiptAction(
    VoidCallback refresh,
    Future<void> Function(Uint8List bytes) action,
  ) async {
    if (isProcessing) return;
    isProcessing = true;
    refresh();
    try {
      await action(await captureReceipt());
    } catch (_) {
      showResultMessage('Unable to process the receipt. Please try again.');
    } finally {
      isProcessing = false;
      refresh();
    }
  }

  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Transaction Successful',
    barrierColor: Colors.black45,
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return StatefulBuilder(
        builder: (dialogContext, setState) => Center(
          child: Material(
            color: Colors.transparent,
            child: RepaintBoundary(
              key: receiptKey,
              child: ClipPath(
                clipper: const _TornReceiptClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: MediaQuery.of(context).size.height * 0.88,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(28, 36, 28, 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 18),
                            const Center(
                              child: Icon(
                                Icons.check_circle,
                                size: 52,
                                color: AppColors.brandGreen,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Center(
                              child: SizedBox(
                                width: 150,
                                height: 40,
                                child: Image(
                                  image: AssetImage(AppAssets.easypaisaJpg),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Center(
                              child: Text(
                                'Transaction Successful',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.brandGreen,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Money has been sent.',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),
                            Text(
                              receiptDateTime,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color(0xFF9A9A9A),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'ID#515320532390',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF9A9A9A),
                              ),
                            ),
                            const SizedBox(height: 26),
                            const Text(
                              'Sent to',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              recipientName,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              recipientAccount,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              bankName ?? 'Bank transfer',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 26),
                            const Text(
                              'Sent By',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Muhammad Junaid Hamza',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '03144231975',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 26),
                            const Text(
                              'Amount',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              amount.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              'Fee / Charge',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF8E8E8E),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF66C2FF),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text(
                                'Free',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.brandGreen,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Rs. ${amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 67, 65, 73),
                              ),
                            ),
                            const SizedBox(height: 28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _ReceiptAction(
                                  icon: Icons.share_outlined,
                                  label: 'Share',
                                  busy: isProcessing,
                                  onTap: () => runReceiptAction(
                                    () => setState(() {}),
                                    (bytes) async {
                                      final result = await Share.shareXFiles(
                                        [
                                          XFile.fromData(
                                            bytes,
                                            mimeType: 'image/png',
                                          ),
                                        ],
                                        subject:
                                            'easypaisa Transaction Receipt',
                                        fileNameOverrides: const [
                                          'easypaisa_transaction_receipt.png',
                                        ],
                                      );
                                      if (result.status ==
                                          ShareResultStatus.success) {
                                        showResultMessage(
                                          'Receipt shared successfully.',
                                        );
                                      }
                                    },
                                  ),
                                ),
                                _ReceiptAction(
                                  icon: Icons.photo_outlined,
                                  label: 'Save to Photos',
                                  busy: isProcessing,
                                  onTap: () => runReceiptAction(
                                    () => setState(() {}),
                                    (bytes) async {
                                      var hasAccess = await Gal.hasAccess();
                                      if (!hasAccess) {
                                        hasAccess = await Gal.requestAccess();
                                      }
                                      if (!hasAccess) {
                                        throw StateError(
                                          'Gallery permission was denied.',
                                        );
                                      }
                                      await Gal.putImageBytes(
                                        bytes,
                                        name: 'easypaisa_transaction_receipt',
                                      );
                                      showResultMessage(
                                        'Receipt saved to Photos.',
                                      );
                                    },
                                  ),
                                ),
                                _ReceiptAction(
                                  icon: Icons.picture_as_pdf_outlined,
                                  label: 'Save as PDF',
                                  busy: false,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 18,
                        top: 14,
                        child: IconButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          icon: const Icon(Icons.close_rounded, size: 34),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _ReceiptAction extends StatelessWidget {
  const _ReceiptAction({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.busy,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            busy ? Icons.hourglass_top_rounded : icon,
            size: 16,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 14),
          Text(
            label,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16, color: Color(0xFF8D8D8D)),
          ),
        ],
      ),
    );
  }
}

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<TransactionRecord> _transactions = const [
    TransactionRecord(
      dateLabel: 'Today, 19 June',
      title: 'Money Transfer via Raast - MUHAMMAD SUFIYAN RAFEEQ',
      time: '02:04 PM',
      amount: 10.00,
      isCredit: false,
    ),
    TransactionRecord(
      dateLabel: 'Today, 19 June',
      title: 'Money Transfer via Raast - Muhammad Sufian Rafiq',
      time: '02:03 PM',
      amount: 10.00,
      isCredit: true,
    ),
    TransactionRecord(
      dateLabel: '18 June 2026',
      title: 'Money Transfer via Raast - MUHAMMAD JUNAID RAMZAN',
      time: '02:30 AM',
      amount: 30.00,
      isCredit: false,
    ),
    TransactionRecord(
      dateLabel: '18 June 2026',
      title: 'Money Transfer - ABDUL WAKEEL',
      time: '02:18 AM',
      amount: 140.00,
      isCredit: false,
      showRepeat: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SimpleAppBar(
              title: 'My Account',
              onBack: () => Navigator.of(context).pop(),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFD6D6DB), width: 2),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: const Color(0xFFB4B4B8),
                indicatorColor: AppColors.brandGreen,
                indicatorWeight: 4,
                labelStyle: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
                tabs: const [
                  Tab(text: 'Summary'),
                  Tab(text: 'Transaction History'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 40,
                              color: AppColors.brandGreen,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                'Account summary coming next.',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _TransactionHistoryTab(records: _transactions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionHistoryTab extends StatelessWidget {
  const _TransactionHistoryTab({required this.records});

  final List<TransactionRecord> records;

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<TransactionRecord>>{};
    for (final record in records) {
      grouped
          .putIfAbsent(record.dateLabel, () => <TransactionRecord>[])
          .add(record);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/pdf_download.png',
                width: 34,
                height: 34,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: Color(0xFFEA6E6E),
                  size: 34,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Download e-statement',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 34),
        const _SyncRow(),
        const SizedBox(height: 14),
        ...grouped.entries.expand(
          (entry) => [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 14),
              child: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 23,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            ...entry.value.map(
              (record) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TransactionCard(record: record),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SyncRow extends StatelessWidget {
  const _SyncRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Text(
            'Today, 19 June',
            style: TextStyle(fontSize: 22, color: AppColors.textPrimary),
          ),
        ),
        Text(
          'last sync: 19-Jun-2026',
          style: TextStyle(fontSize: 16, color: Color(0xFF8B8B91)),
        ),
        SizedBox(width: 6),
        Icon(Icons.refresh_rounded, size: 22, color: Color(0xFF8B8B91)),
      ],
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.record});

  final TransactionRecord record;

  @override
  Widget build(BuildContext context) {
    final amountColor = record.isCredit
        ? AppColors.brandGreen
        : AppColors.danger;
    return InkWell(
      onTap: () => showReceiptDialog(
        context,
        amount: record.amount,
        recipientName: 'MUHAMMAD SUFIYAN RAFEEQ',
        recipientAccount: '03191981267',
      ),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 14, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD7D7DC)),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BankLogo(
                  name: 'Money',
                  asset: AppAssets.moneyBag,
                  fallbackColor: AppColors.brandGreen,
                  size: 46,
                  circle: true,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.title,
                        style: const TextStyle(
                          fontSize: 23,
                          height: 1.06,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        record.time,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF8B8B91),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Rs. ${record.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    color: amountColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 32,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
            if (record.showRepeat)
              Positioned(
                right: 30,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E2E2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Repeat',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SimpleLogoLine extends StatelessWidget {
  const _SimpleLogoLine({
    required this.asset,
    required this.fallback,
    required this.height,
  });

  final String asset;
  final Widget fallback;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => fallback,
    );
  }
}

class EasyPaisaWordmark extends StatelessWidget {
  const EasyPaisaWordmark({super.key, this.height = 42});

  final double height;

  @override
  Widget build(BuildContext context) {
    return _SimpleLogoLine(
      asset: AppAssets.easypaisaWordmark,
      height: height,
      fallback: const _EasyPaisaFallback(),
    );
  }
}

class _EasyPaisaFallback extends StatelessWidget {
  const _EasyPaisaFallback();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 22.5.ui,
              height: 22.5.ui,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.textPrimary,
                  width: 5.25.ui,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Positioned(
              bottom: 2.25.ui,
              child: Container(
                width: 22.5.ui,
                height: 10.5.ui,
                decoration: const BoxDecoration(
                  color: AppColors.brandGreen,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 6.ui),
        const Text(
          'easypaisa',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.0,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class DigitalBankWordmark extends StatelessWidget {
  const DigitalBankWordmark({super.key, this.height = 152});

  final double height;

  @override
  Widget build(BuildContext context) {
    return _SimpleLogoLine(
      asset: AppAssets.digitalBankLogo,
      height: height,
      fallback: const _DigitalBankFallback(),
    );
  }
}

class SimpleAppBar extends StatelessWidget {
  const SimpleAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.rightText,
    this.rightWidget,
    this.backgroundColor = Colors.white,
    this.titleColor = AppColors.textPrimary,
  });

  final String title;
  final VoidCallback? onBack;
  final String? rightText;
  final Widget? rightWidget;
  final Color backgroundColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 54.ui,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 3.ui,
                child: IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 25.5.ui,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.5,
                    fontWeight: FontWeight.w500,
                    color: titleColor,
                  ),
                ),
              ),
              Positioned(
                right: 13.5.ui,
                child:
                    rightWidget ??
                    (rightText == null
                        ? SizedBox(width: 36.ui, height: 36.ui)
                        : Text(
                            rightText!,
                            style: const TextStyle(
                              fontSize: 19.5,
                              color: AppColors.textPrimary,
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CashPointsScreen extends StatelessWidget {
  const CashPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Cash Points',
      subtitle: 'This tab is ready for the next screen we wire up.',
      icon: Icons.location_on_outlined,
    );
  }
}

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Promotions',
      subtitle: 'This area is reserved for promotional cards and offers.',
      icon: Icons.campaign_outlined,
    );
  }
}

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: const Center(
        child: Text(
          'Coming soon',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                  color: AppColors.brandGreen.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 72, color: AppColors.brandGreen),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
