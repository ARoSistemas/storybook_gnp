import 'dart:ui';

import 'package:storybook_gnp/core/messages/i_messages.dart';
import 'package:storybook_gnp/core/messages/messages.dart';
import 'package:storybook_gnp/shared/messages/es/es_messages.dart';
import 'package:storybook_gnp/shared/messages/i_app_messages.dart';

final enMessages = _ENMessages._();

class _ENMessages {
  _ENMessages._();

  IAppMessages get us => const _US._();
}

class _US extends IAppMessages {
  const _US._();

  @override
  Locale get locale => const Locale(
    LanguageCodes.en,
    CountryCodes.us,
  );

  @override
  MsgProperty get welcome => msg.welcome.copyWith(
    value: 'Welcome @0',
    pValue: 'Welcome @0 and @1 and @1 and @0',
    eValue: 'There is no welcome',
  );

  @override
  MsgProperty get dark => esMessages.mx.dark.copyWith(
    value: 'Dark',
  );

  @override
  MsgProperty get light => esMessages.mx.light.copyWith(
    value: 'Claro',
  );

  @override
  MsgProperty get system => esMessages.mx.system.copyWith(
    value: 'System',
  );

  @override
  MsgProperty get settings => esMessages.mx.settings.copyWith(
    value: 'Settings',
  );

  @override
  MsgProperty get signOut => esMessages.mx.signOut.copyWith(
    value: 'Sign out',
  );

  @override
  MsgProperty get identify => esMessages.mx.identify.copyWith(
    value: 'Identify',
  );

  @override
  MsgProperty get welcomeApp => esMessages.mx.welcomeApp.copyWith(
    value: 'welcomeApp',
  );
}
