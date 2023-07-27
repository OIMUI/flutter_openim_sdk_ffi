/* Code generated by cmd/cgo; DO NOT EDIT. */

/* package open_im_sdk/main */


#line 1 "cgo-builtin-export-prolog"

#include <stddef.h>

#ifndef GO_CGO_EXPORT_PROLOGUE_H
#define GO_CGO_EXPORT_PROLOGUE_H

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef struct { const char *p; ptrdiff_t n; } _GoString_;
#endif

#endif

/* Start of preamble from import "C" comments.  */


#line 3 "conversation_msg.go"

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#line 1 "cgo-generated-wrapper"


#line 3 "friend.go"

#include <stdio.h>
#include <stdint.h>

#line 1 "cgo-generated-wrapper"

#line 3 "group.go"

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#line 1 "cgo-generated-wrapper"

#line 3 "openim_sdk_ffi.go"

#include <stdio.h>
#include "include/dart_api_dl.h"

typedef struct {
    void (*onMethodChannel)(Dart_Port_DL port, char*, char*, char*, double*, char*);
	void (*onNativeMethodChannel)(char*, char*, char*, double*, char*);
} CGO_OpenIM_Listener;

static void callOnMethodChannel(CGO_OpenIM_Listener *listener, Dart_Port_DL port, char* methodName, char* operationID, char* callMethodName, double* errCode, char* message) {
	if (listener->onMethodChannel != NULL) {
		listener->onMethodChannel(port, methodName, operationID, callMethodName, errCode, message);
	}
}
static void callOnNativeMethodChannel(CGO_OpenIM_Listener *listener, char* methodName, char* operationID, char* callMethodName, double* errCode, char* message) {
	if (listener->onNativeMethodChannel != NULL) {
		listener->onNativeMethodChannel(methodName, operationID, callMethodName, errCode, message);
	}
}

#line 1 "cgo-generated-wrapper"

#line 3 "third.go"

#include <stdio.h>
#include <stdint.h>

#line 1 "cgo-generated-wrapper"

#line 3 "user.go"

#include <stdio.h>

#line 1 "cgo-generated-wrapper"


/* End of preamble from import "C" comments.  */


/* Start of boilerplate cgo prologue.  */
#line 1 "cgo-gcc-export-header-prolog"

#ifndef GO_CGO_PROLOGUE_H
#define GO_CGO_PROLOGUE_H

typedef signed char GoInt8;
typedef unsigned char GoUint8;
typedef short GoInt16;
typedef unsigned short GoUint16;
typedef int GoInt32;
typedef unsigned int GoUint32;
typedef long long GoInt64;
typedef unsigned long long GoUint64;
typedef GoInt64 GoInt;
typedef GoUint64 GoUint;
typedef size_t GoUintptr;
typedef float GoFloat32;
typedef double GoFloat64;
#ifdef _MSC_VER
#include <complex.h>
typedef _Fcomplex GoComplex64;
typedef _Dcomplex GoComplex128;
#else
typedef float _Complex GoComplex64;
typedef double _Complex GoComplex128;
#endif

/*
  static assertion to make sure the file is being used on architecture
  at least with matching size of GoInt.
*/
typedef char _check_for_64_bit_pointer_matching_GoInt[sizeof(void*)==64/8 ? 1:-1];

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef _GoString_ GoString;
#endif
typedef void *GoMap;
typedef void *GoChan;
typedef struct { void *t; void *v; } GoInterface;
typedef struct { void *data; GoInt len; GoInt cap; } GoSlice;

#endif

/* End of boilerplate cgo prologue.  */

#ifdef __cplusplus
extern "C" {
#endif

extern __declspec(dllexport) void GetAllConversationList(char* operationID);
extern __declspec(dllexport) void GetConversationListSplit(char* operationID, int offset, int count);
extern __declspec(dllexport) void GetOneConversation(char* operationID, int32_t sessionType, char* sourceID);
extern __declspec(dllexport) void GetMultipleConversation(char* operationID, char* conversationIDList);
extern __declspec(dllexport) void SetGlobalRecvMessageOpt(char* operationID, int opt);
extern __declspec(dllexport) void SetConversationMsgDestructTime(char* operationID, char* conversationID, int64_t msgDestructTime);
extern __declspec(dllexport) void SetConversationIsMsgDestruct(char* operationID, char* conversationID, _Bool isMsgDestruct);
extern __declspec(dllexport) void HideConversation(char* operationID, char* conversationID);
extern __declspec(dllexport) void GetConversationRecvMessageOpt(char* operationID, char* conversationIDList);
extern __declspec(dllexport) void DeleteAllConversationFromLocal(char* operationID);
extern __declspec(dllexport) void SetConversationDraft(char* operationID, char* conversationID, char* draftText);
extern __declspec(dllexport) void ResetConversationGroupAtType(char* operationID, char* conversationID);
extern __declspec(dllexport) void PinConversation(char* operationID, char* conversationID, _Bool isPinned);
extern __declspec(dllexport) void SetConversationPrivateChat(char* operationID, char* conversationID, _Bool isPrivate);
extern __declspec(dllexport) void SetConversationBurnDuration(char* operationID, char* conversationID, int32_t duration);
extern __declspec(dllexport) void SetConversationRecvMessageOpt(char* operationID, char* conversationID, int opt);
extern __declspec(dllexport) void GetTotalUnreadMsgCount(char* operationID);
extern __declspec(dllexport) char* GetAtAllTag(char* operationID);
extern __declspec(dllexport) char* CreateAdvancedTextMessage(char* operationID, char* text, char* messageEntityList);
extern __declspec(dllexport) char* CreateTextAtMessage(char* operationID, char* text, char* atUserList, char* atUsersInfo, char* message);
extern __declspec(dllexport) char* CreateTextMessage(char* operationID, char* text);
extern __declspec(dllexport) char* CreateLocationMessage(char* operationID, char* description, double longitude, double latitude);
extern __declspec(dllexport) char* CreateCustomMessage(char* operationID, char* data, char* extension, char* description);
extern __declspec(dllexport) char* CreateQuoteMessage(char* operationID, char* text, char* message);
extern __declspec(dllexport) char* CreateAdvancedQuoteMessage(char* operationID, char* text, char* message, char* messageEntityList);
extern __declspec(dllexport) char* CreateCardMessage(char* operationID, char* cardInfo);
extern __declspec(dllexport) char* CreateVideoMessageFromFullPath(char* operationID, char* videoFullPath, char* videoType, int64_t duration, char* snapshotFullPath);
extern __declspec(dllexport) char* CreateImageMessageFromFullPath(char* operationID, char* imageFullPath);
extern __declspec(dllexport) char* CreateSoundMessageFromFullPath(char* operationID, char* soundFullPath, int64_t duration);
extern __declspec(dllexport) char* CreateFileMessageFromFullPath(char* operationID, char* fileFullPath, char* fileName);
extern __declspec(dllexport) char* CreateImageMessage(char* operationID, char* imagePath);
extern __declspec(dllexport) char* CreateImageMessageByURL(char* operationID, char* sourcePicture, char* bigPicture, char* snapshotPicture);
extern __declspec(dllexport) char* CreateSoundMessageByURL(char* operationID, char* soundBaseInfo);
extern __declspec(dllexport) char* CreateSoundMessage(char* operationID, char* soundPath, int64_t duration);
extern __declspec(dllexport) char* CreateVideoMessageByURL(char* operationID, char* videoBaseInfo);
extern __declspec(dllexport) char* CreateVideoMessage(char* operationID, char* videoPath, char* videoType, int64_t duration, char* snapshotPath);
extern __declspec(dllexport) char* CreateFileMessageByURL(char* operationID, char* fileBaseInfo);
extern __declspec(dllexport) char* CreateFileMessage(char* operationID, char* filePath, char* fileName);
extern __declspec(dllexport) char* CreateMergerMessage(char* operationID, char* messageList, char* title, char* summaryList);
extern __declspec(dllexport) char* CreateFaceMessage(char* operationID, int index, char* data);
extern __declspec(dllexport) char* CreateForwardMessage(char* operationID, char* m);
extern __declspec(dllexport) GoString GetConversationIDBySessionType(char* operationID, char* sourceID, int sessionType);
extern __declspec(dllexport) void SendMessage(char* operationID, char* message, char* recvID, char* groupID, char* offlinePushInfo);
extern __declspec(dllexport) void SendMessageNotOss(char* operationID, char* message, char* recvID, char* groupID, char* offlinePushInfo);
extern __declspec(dllexport) void FindMessageList(char* operationID, char* findMessageOptions);
extern __declspec(dllexport) void RevokeMessage(char* operationID, char* conversationID, char* clientMsgID);
extern __declspec(dllexport) void TypingStatusUpdate(char* operationID, char* recvID, char* msgTip);

// mark as read
//
extern __declspec(dllexport) void MarkConversationMessageAsRead(char* operationID, char* conversationID);
extern __declspec(dllexport) void MarkMessagesAsReadByMsgID(char* operationID, char* conversationID, char* clientMsgIDs);
extern __declspec(dllexport) void DeleteMessageFromLocalStorage(char* operationID, char* conversationID, char* clientMsgID);
extern __declspec(dllexport) void DeleteMessage(char* operationID, char* conversationID, char* clientMsgID);
extern __declspec(dllexport) void DeleteConversationFromLocal(char* operationID, char* conversationID);
extern __declspec(dllexport) void DeleteAllMsgFromLocalAndSvr(char* operationID);
extern __declspec(dllexport) void DeleteAllMsgFromLocal(char* operationID);
extern __declspec(dllexport) void ClearConversationAndDeleteAllMsg(char* operationID, char* conversationID);
extern __declspec(dllexport) void DeleteConversationAndDeleteAllMsg(char* operationID, char* conversationID);
extern __declspec(dllexport) void InsertSingleMessageToLocalStorage(char* operationID, char* message, char* recvID, char* sendID);
extern __declspec(dllexport) void InsertGroupMessageToLocalStorage(char* operationID, char* message, char* groupID, char* sendID);
extern __declspec(dllexport) void SearchLocalMessages(char* operationID, char* searchParam);
extern __declspec(dllexport) void SetMessageLocalEx(char* operationID, char* conversationID, char* clientMsgID, char* localEx);
extern __declspec(dllexport) void UploadFile(char* operationID, char* req);
extern __declspec(dllexport) void GetSpecifiedFriendsInfo(char* operationID, char* userIDList);
extern __declspec(dllexport) void GetFriendList(char* operationID);
extern __declspec(dllexport) void GetFriendListPage(char* operationID, int32_t offset, int32_t count);
extern __declspec(dllexport) void SearchFriends(char* operationID, char* searchParam);
extern __declspec(dllexport) void CheckFriend(char* operationID, char* userIDList);
extern __declspec(dllexport) void AddFriend(char* operationID, char* userIDReqMsg);
extern __declspec(dllexport) void SetFriendRemark(char* operationID, char* userIDRemark);
extern __declspec(dllexport) void DeleteFriend(char* operationID, char* friendUserID);
extern __declspec(dllexport) void GetFriendApplicationListAsRecipient(char* operationID);
extern __declspec(dllexport) void GetFriendApplicationListAsApplicant(char* operationID);
extern __declspec(dllexport) void AcceptFriendApplication(char* operationID, char* userIDHandleMsg);
extern __declspec(dllexport) void RefuseFriendApplication(char* operationID, char* userIDHandleMsg);
extern __declspec(dllexport) void AddBlack(char* operationID, char* blackUserID);
extern __declspec(dllexport) void GetBlackList(char* operationID);
extern __declspec(dllexport) void RemoveBlack(char* operationID, char* removeUserID);
extern __declspec(dllexport) void CreateGroup(char* operationID, char* groupReqInfo);
extern __declspec(dllexport) void JoinGroup(char* operationID, char* groupID, char* reqMsg, int32_t joinSource);
extern __declspec(dllexport) void QuitGroup(char* operationID, char* groupID);
extern __declspec(dllexport) void DismissGroup(char* operationID, char* groupID);
extern __declspec(dllexport) void ChangeGroupMute(char* operationID, char* groupID, _Bool isMute);
extern __declspec(dllexport) void ChangeGroupMemberMute(char* operationID, char* groupID, char* userID, int mutedSeconds);
extern __declspec(dllexport) void SetGroupMemberRoleLevel(char* operationID, char* groupID, char* userID, int roleLevel);
extern __declspec(dllexport) void SetGroupMemberInfo(char* operationID, char* groupMemberInfo);
extern __declspec(dllexport) void GetJoinedGroupList(char* operationID);
extern __declspec(dllexport) void GetSpecifiedGroupsInfo(char* operationID, char* groupIDList);
extern __declspec(dllexport) void SearchGroups(char* operationID, char* searchParam);
extern __declspec(dllexport) void SetGroupInfo(char* operationID, char* groupInfo);
extern __declspec(dllexport) void SetGroupVerification(char* operationID, char* groupID, int32_t verification);
extern __declspec(dllexport) void SetGroupLookMemberInfo(char* operationID, char* groupID, int32_t rule);
extern __declspec(dllexport) void SetGroupApplyMemberFriend(char* operationID, char* groupID, int32_t rule);
extern __declspec(dllexport) void GetGroupMemberList(char* operationID, char* groupID, int32_t filter, int32_t offset, int32_t count);
extern __declspec(dllexport) void GetGroupMemberOwnerAndAdmin(char* operationID, char* groupID);
extern __declspec(dllexport) void GetGroupMemberListByJoinTimeFilter(char* operationID, char* groupID, int32_t offset, int32_t count, int64_t joinTimeBegin, int64_t joinTimeEnd, char* filterUserIDList);
extern __declspec(dllexport) void GetSpecifiedGroupMembersInfo(char* operationID, char* groupID, char* userIDList);
extern __declspec(dllexport) void KickGroupMember(char* operationID, char* groupID, char* reason, char* userIDList);
extern __declspec(dllexport) void TransferGroupOwner(char* operationID, char* groupID, char* newOwnerUserID);
extern __declspec(dllexport) void InviteUserToGroup(char* operationID, char* groupID, char* reason, char* userIDList);
extern __declspec(dllexport) void GetGroupApplicationListAsRecipient(char* operationID);
extern __declspec(dllexport) void GetGroupApplicationListAsApplicant(char* operationID);
extern __declspec(dllexport) void AcceptGroupApplication(char* operationID, char* groupID, char* fromUserID, char* handleMsg);
extern __declspec(dllexport) void RefuseGroupApplication(char* operationID, char* groupID, char* fromUserID, char* handleMsg);
extern __declspec(dllexport) void SetGroupMemberNickname(char* operationID, char* groupID, char* userID, char* groupMemberNickname);
extern __declspec(dllexport) void SearchGroupMembers(char* operationID, char* searchParam);
extern __declspec(dllexport) void IsJoinGroup(char* operationID, char* groupID);
extern __declspec(dllexport) void RegisterCallback(CGO_OpenIM_Listener* callback, Dart_Port_DL port);
extern __declspec(dllexport) char* GetSdkVersion();
extern __declspec(dllexport) _Bool InitSDK(char* operationID, char* config);
extern __declspec(dllexport) void Login(char* operationID, char* userID, char* token);
extern __declspec(dllexport) void Logout(char* operationID);
extern __declspec(dllexport) void SetAppBackgroundStatus(char* operationID, _Bool isBackground);
extern __declspec(dllexport) void NetworkStatusChanged(char* operationID);
extern __declspec(dllexport) int GetLoginStatus(char* operationID);
extern __declspec(dllexport) char* GetLoginUserID();
extern __declspec(dllexport) void UpdateFcmToken(char* operationID, char* userIDList);
extern __declspec(dllexport) void SetAppBadge(char* operationID, int32_t appUnreadCount);
extern __declspec(dllexport) void GetUsersInfo(char* operationID, char* userIDList);
extern __declspec(dllexport) void GetUsersInfoFromSrv(char* operationID, char* userIDList);
extern __declspec(dllexport) void SetSelfInfo(char* operationID, char* userInfo);
extern __declspec(dllexport) void GetSelfUserInfo(char* operationID);
extern __declspec(dllexport) void UpdateMsgSenderInfo(char* operationID, char* nickname, char* faceURL);

#ifdef __cplusplus
}
#endif
