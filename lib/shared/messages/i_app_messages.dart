import 'package:storybook_gnp/core/messages/i_messages.dart';
import 'package:storybook_gnp/shared/messages/es/es_messages.dart';

final IAppMessages msg = esMessages.mx;

abstract class IAppMessages extends IMessages {
  const IAppMessages();

  abstract final MsgProperty welcome;
  abstract final MsgProperty light;
  abstract final MsgProperty dark;
  abstract final MsgProperty system;
  abstract final MsgProperty settings;
  abstract final MsgProperty signOut;
  abstract final MsgProperty identify;
  abstract final MsgProperty welcomeApp;

  @override
  Map<String, String> toJson() => {
    ...welcome.msgMap,
    ...light.msgMap,
    ...dark.msgMap,
    ...system.msgMap,
    ...settings.msgMap,
    ...signOut.msgMap,
    ...identify.msgMap,
    ...welcomeApp.msgMap,
  };
}
