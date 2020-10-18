import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/ButtonWithBorder.dart';
import 'package:puzzility/components/GradientButton.dart';
import 'package:puzzility/components/RemainingCoin.dart';
import 'package:puzzility/service/PlayerRepository.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool isSoundOn = true;
  bool isNotificationOn = true;

  Widget _buildShareSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              "Share the game",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 24),
          Text(
              "If you enjoy this game, consider sharing your experience to your friends and family. Invite them to try and crack these marvellous puzzles!",
              style: Theme.of(context).textTheme.bodyText1),
          SizedBox(height: 24),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: GradientButton("Share",
                icon: Icons.share,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  toggleSound(bool value) async {
    await Provider.of<PlayerRepository>(context, listen: false)
        .updateSoundSetting(value);
  }

  toggleNotification(bool value) async {
    await Provider.of<PlayerRepository>(context, listen: false)
        .updateNotificationSetting(value);
  }

  Widget _switchCell(String title) {
    return Consumer<PlayerRepository>(
      builder: (context, playerRepo, child) {
        return Row(
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headline1),
            Spacer(),
            Platform.isIOS
                ? CupertinoSwitch(
                    value: title == "Sound" ? playerRepo.player.isSoundOn : playerRepo.player.isNotificationOn,
                    onChanged: (bool value) {
                      setState(() {
                        if (title == "Sound") {
                          setState(() {
                            isSoundOn = value;
                          });
                          toggleSound(value);
                        } else {
                          setState(() {
                            isNotificationOn = value;
                          });
                          toggleNotification(value);
                        }
                      });
                    },
                    activeColor: ThemeProvider().teal(),
                  )
                : Switch(
                    value: playerRepo.player.isNotificationOn,
                    onChanged: (value) {
                      setState(() {
                        if (title == "Sound") {
                          setState(() {
                            isSoundOn = value;
                          });
                        } else {
                          setState(() {
                            isNotificationOn = value;
                          });
                        }
                      });
                    },
                    activeTrackColor: ThemeProvider().teal(),
                    activeColor: Colors.white,
                    // activeColor: Colors.white,
                  ),
          ],
        );
      },
    );
  }

  Widget _buildSwitchSection() {
    return Container(
      child: Column(
        children: <Widget>[
          _switchCell("Sound"),
          SizedBox(height: 8),
          _switchCell("Notification"),
        ],
      ),
    );
  }

  _onProvideFeedbackButtonTapped() {}
  _onRestorePurchaseTapped() {}

  Widget _buildButtonSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: ButtonWithBorder(
                "Provide Feedback",
                onTap: _onProvideFeedbackButtonTapped,
              )),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: ButtonWithBorder(
              "Restore Purchase",
              onTap: _onRestorePurchaseTapped,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Consumer<PlayerRepository>(builder: (context, playerRepo, child) {
            return RemainingCoin(playerRepo.player.coins);
          })
        ],
        backgroundColor: ThemeProvider().darkBlue(),
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                _buildShareSection(),
                SizedBox(height: 24),
                _buildSwitchSection(),
                SizedBox(height: 24),
                _buildButtonSection()
              ],
            )),
      ),
    );
  }
}
