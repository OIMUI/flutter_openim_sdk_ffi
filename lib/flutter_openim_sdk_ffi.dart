library flutter_openim_sdk_ffi;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'flutter_openim_sdk_ffi_bindings_generated.dart';
import 'openim_sdk_ffi_bindings_generated.dart';
import 'src/utils.dart';

part './src/openim.dart';
part './src/models/workmoments_info.dart';
part './src/models/conversation_info.dart';
part './src/models/group_info.dart';
part './src/models/meeting_info.dart';
part './src/models/message.dart';
part './src/models/notification_info.dart';
part './src/models/organization_info.dart';
part './src/models/search_info.dart';
part './src/models/signaling_info.dart';
part './src/models/user_info.dart';

part './src/enum/conversation_type.dart';
part './src/enum/group_at_type.dart';
part './src/enum/group_role_level.dart';
part './src/enum/group_type.dart';
part './src/enum/group_verification.dart';
part './src/enum/message_status.dart';
part './src/enum/im_platform.dart';
part './src/enum/listener_type.dart';
part './src/enum/message_type.dart';
part './src/enum/sdk_error_code.dart';

part './src/openim_manager.dart';
part './src/openim_listener.dart';

part './src/logger.dart';

part './src/manager/im_conversation_manager.dart';
part './src/manager/im_friendship_manager.dart';
part './src/manager/im_group_manager.dart';
part './src/manager/im_manager.dart';
part './src/manager/im_message_manager.dart';
part './src/manager/im_organization_manager.dart';
part './src/manager/im_signaling_manager.dart';
part './src/manager/im_user_manager.dart';
part './src/manager/im_workmoments_manager.dart';

part './src/openim_error.dart';

part './src/struct/struct.dart';
part 'src/callback/callback.dart';
