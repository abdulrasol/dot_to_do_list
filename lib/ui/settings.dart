import 'package:dot_to_do_list/controllers/data_controller.dart';
import 'package:dot_to_do_list/controllers/settings_controller.dart';
import 'package:dot_to_do_list/ui/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller for managing state (e.g., notifications, theme, language)
    SettingsController settingsController = Get.put(SettingsController());
    DataController dataController = Get.put(DataController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme and Languages selection
          const Text('Theme and Languages',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            trailing: Obx(() => DropdownButton<String>(
                  value: settingsController.selectedTheme.value,
                  items: ['Light', 'Dark'].map((String theme) {
                    return DropdownMenuItem(
                      value: theme,
                      child: Text(theme),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      settingsController.selectedTheme.value = newValue;
                    }
                  },
                )),
          ),

          // Language selection
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: Obx(() => DropdownButton<String>(
                  value: settingsController.selectedLanguage.value,
                  items: ['English', 'Arabic'].map((String language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      settingsController.selectedLanguage.value = newValue;
                    }
                  },
                )),
          ),
          const Divider(),
          const SizedBox(height: 15),
          // Notifications toggle
          const Text('Reminder', style: TextStyle(fontWeight: FontWeight.bold)),
          Obx(() => SwitchListTile(
                title: const Text('Enable Reminders'),
                value: settingsController.notificationToggle.value,
                onChanged: (bool value) {
                  settingsController.notificationToggle.value = value;
                },
              )),

          // Reminder time setting
          Obx(() => ListTile(
                leading: const Icon(Icons.alarm),
                title: const Text('Default Reminder Time'),
                subtitle: Text(
                    'Set reminder to: ${settingsController.defaultReminderTime.value.format(context)}'),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: settingsController.defaultReminderTime.value,
                  );
                  if (picked != null) {
                    settingsController.defaultReminderTime.value = picked;
                  }
                },
              )),
          const Divider(),
          const SizedBox(height: 15),
          //   Account management & Data sync option
          const Text('Account & sync ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Manage Account'),
            onTap: () async {
              await Get.defaultDialog(
                title: 'Account',
                content: const LoginWidget(),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Data Sync'),
            subtitle: const Text('Manage cloud sync settings'),
            onTap: () async {
              // await dataController.login(
              //     email: 'iraq.rsol@gmail.com', password: '11223344@');
              //await dataController.user.value.deleteSessions();
              //   dataController.user.value =
              //      await dataController.account.value.get();
              // print(s.isBlank);
              //print(await dataController.user.value.client.setSession('value'));
              //print(await dataController.session.value);
              // Handle data sync settings
              dataController.sharedInstance.setBool('login', true);
            },
          ),
          Obx(
            () => dataController.loginState.value
                ? ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    subtitle: const Text('Stop Cloud Sync'),
                    onTap: () async {
                      await dataController.logout();
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
