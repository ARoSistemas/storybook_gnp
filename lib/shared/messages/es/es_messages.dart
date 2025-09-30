import 'dart:ui';

import 'package:storybook_gnp/core/messages/i_messages.dart';
import 'package:storybook_gnp/core/messages/messages.dart';
import 'package:storybook_gnp/shared/messages/i_app_messages.dart';

final esMessages = _ESMessages._();

class _ESMessages {
  _ESMessages._();

  IAppMessages get mx => const _MX._();
}

class _MX extends IAppMessages {
  const _MX._();

  @override
  Locale get locale => const Locale(
    LanguageCodes.es,
    CountryCodes.mx,
  );

  @override
  MsgProperty get welcome => MsgProperty(
    key: 'welcome',
    value: 'Bienvenido @0',
    pValue: 'Bienvenidos @0 y @1',
    eValue: 'No hay bienvenida',
  );

  @override
  MsgProperty get dark => MsgProperty(
    key: 'dark',
    value: 'Obscuro',
  );

  @override
  MsgProperty get light => MsgProperty(
    key: 'light',
    value: 'Claro',
  );

  @override
  MsgProperty get system => MsgProperty(
    key: 'system',
    value: 'Sistema',
  );

  @override
  MsgProperty get settings => MsgProperty(
    key: 'settings',
    value: 'Configuración',
  );

  @override
  MsgProperty get signOut => MsgProperty(
    key: 'signOut',
    value: 'Cerrar sesión',
  );

  @override
  MsgProperty get identify => MsgProperty(
    key: 'identify',
    value: 'Identificate',
  );

  @override
  MsgProperty get welcomeApp => MsgProperty(
    key: 'welcomeApp',
    value: 'Bienvenido',
  );
}
