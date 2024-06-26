import 'package:components/dashboard_toggle/dasboard_toggle.dart';
import 'package:components/nav_menu_inner/nav_menu_inner.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:components/totp_card/totp_card.dart';
import 'package:presentation/views/totp/totp_viewmodel.dart';
import 'package:shared/base_component_toggle.dart';
import 'package:stacked/stacked.dart';

class TotpView extends StatelessWidget {
  const TotpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TotpViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.theme.primary300,
        child: Column(
          children: [
            SafeArea(
              child: NavMenuInner(
                location: "TOTP/OTP",
                callback: () => viewModel.router.backToPrevious(context),
              ),
            ),
            Expanded(
              child: Container(
                color: ThemeStyles.theme.background300,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: DashboardToggle(
                              height: 100,
                              viewModel: BaseComponentToggle(
                                context,
                                "assets/images/scan.svg",
                                "Scan QR Code",
                                viewModel.onScanPressed,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: DashboardToggle(
                              height: 100,
                              viewModel: BaseComponentToggle(
                                context,
                                "assets/images/add-square.svg",
                                "Add Secret",
                                viewModel.onAddPressed,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: viewModel.secrets.length,
                        itemBuilder: (context, index) => TotpCard(
                          canDelete: true,
                          otpCode: viewModel.secrets.elementAt(index),
                          onDelete: () => viewModel.onDeletePressed(
                            viewModel.secrets.elementAt(index),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
