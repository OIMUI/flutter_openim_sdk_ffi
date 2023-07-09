/* Code generated by cmd/cgo; DO NOT EDIT. */

/* package command-line-arguments */


#line 1 "cgo-builtin-export-prolog"

#include <stddef.h>

#ifndef GO_CGO_EXPORT_PROLOGUE_H
#define GO_CGO_EXPORT_PROLOGUE_H

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef struct { const char *p; ptrdiff_t n; } _GoString_;
#endif

#endif

/* Start of preamble from import "C" comments.  */


#line 3 "openim_sdk_ffi.go"

#include <stdio.h>
#include "include/dart_api_dl.h"

typedef struct {
    void (*onMethodChannel)(Dart_Port_DL port, char*, char*, char*, double*, char*);
} CGO_OpenIM_Listener;

static void callOnMethodChannel(CGO_OpenIM_Listener *listener, Dart_Port_DL port, char* methodName, char* operationID, char* callMethodName, double* errCode, char* message) {
    listener->onMethodChannel(port, methodName, operationID, callMethodName, errCode, message);
}

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

extern __declspec(dllexport) void RegisterCallback(CGO_OpenIM_Listener* callback, Dart_Port_DL port);
extern __declspec(dllexport) char* GetSdkVersion();
extern __declspec(dllexport) _Bool InitSDK(char* operationID, char* config);
extern __declspec(dllexport) void Login(char* operationID, char* userID, char* token);
extern __declspec(dllexport) void WakeUp(char* operationID);
extern __declspec(dllexport) void NetworkChanged(char* operationID);
extern __declspec(dllexport) void UploadImage(char* operationID, char* filePath, char* token, char* obj);
extern __declspec(dllexport) void UploadFile(char* operationID, char* filePath);
extern __declspec(dllexport) void Logout(char* operationID);
extern __declspec(dllexport) void SetAppBackgroundStatus(char* operationID, _Bool isBackground);
extern __declspec(dllexport) int32_t GetLoginStatus();
extern __declspec(dllexport) char* GetLoginUser();
extern __declspec(dllexport) void GetUsersInfo(char* operationID, char* userIDList);
extern __declspec(dllexport) void SetSelfInfo(char* operationID, char* userInfo);
extern __declspec(dllexport) void GetSelfUserInfo(char* operationID);
extern __declspec(dllexport) void CreateGroup(char* operationID, char* groupBaseInfo, char* memberList);
extern __declspec(dllexport) void JoinGroup(char* operationID, char* groupID, char* reqMsg, int32_t joinSource);
extern __declspec(dllexport) void QuitGroup(char* operationID, char* groupID);
extern __declspec(dllexport) void DismissGroup(char* operationID, char* groupID);
extern __declspec(dllexport) void ChangeGroupMute(char* operationID, char* groupID, _Bool isMute);
extern __declspec(dllexport) void ChangeGroupMemberMute(char* operationID, char* groupID, char* userID, int mutedSeconds);
extern __declspec(dllexport) void SetGroupMemberRoleLevel(char* operationID, char* groupID, char* userID, int roleLevel);
extern __declspec(dllexport) void SetGroupMemberInfo(char* operationID, char* groupMemberInfo);
extern __declspec(dllexport) void GetJoinedGroupList(char* operationID);
extern __declspec(dllexport) void GetGroupsInfo(char* operationID, char* groupIDList);
extern __declspec(dllexport) void SearchGroups(char* operationID, char* searchParam);
extern __declspec(dllexport) void SetGroupInfo(char* operationID, char* groupID, char* groupInfo);
extern __declspec(dllexport) void SetGroupVerification(char* operationID, char* groupID, int32_t verification);
extern __declspec(dllexport) void SetGroupLookMemberInfo(char* operationID, char* groupID, int32_t rule);
extern __declspec(dllexport) void SetGroupApplyMemberFriend(char* operationID, char* groupID, int32_t rule);
extern __declspec(dllexport) void GetGroupMemberList(char* operationID, char* groupID, int32_t filter, int32_t offset, int32_t count);
extern __declspec(dllexport) void GetGroupMemberOwnerAndAdmin(char* operationID, char* groupID);
extern __declspec(dllexport) void GetGroupMemberListByJoinTimeFilter(char* operationID, char* groupID, int32_t offset, int32_t count, int64_t joinTimeBegin, int64_t joinTimeEnd, char* filterUserIDList);
extern __declspec(dllexport) void GetGroupMembersInfo(char* operationID, char* groupID, char* userIDList);
extern __declspec(dllexport) void KickGroupMember(char* operationID, char* groupID, char* reason, char* userIDList);
extern __declspec(dllexport) void TransferGroupOwner(char* operationID, char* groupID, char* newOwnerUserID);
extern __declspec(dllexport) void InviteUserToGroup(char* operationID, char* groupID, char* reason, char* userIDList);
extern __declspec(dllexport) void GetRecvGroupApplicationList(char* operationID);
extern __declspec(dllexport) void GetSendGroupApplicationList(char* operationID);
extern __declspec(dllexport) void AcceptGroupApplication(char* operationID, char* groupID, char* fromUserID, char* handleMsg);
extern __declspec(dllexport) void RefuseGroupApplication(char* operationID, char* groupID, char* fromUserID, char* handleMsg);
extern __declspec(dllexport) void SetGroupMemberNickname(char* operationID, char* groupID, char* userID, char* groupMemberNickname);
extern __declspec(dllexport) void SearchGroupMembers(char* operationID, char* searchParam);

// //////////////////////////friend/////////////////////////////////////
//
extern __declspec(dllexport) void GetDesignatedFriendsInfo(char* operationID, char* userIDList);
extern __declspec(dllexport) void GetFriendList(char* operationID);
extern __declspec(dllexport) void SearchFriends(char* operationID, char* searchParam);
extern __declspec(dllexport) void CheckFriend(char* operationID, char* userIDList);
extern __declspec(dllexport) void AddFriend(char* operationID, char* userIDReqMsg);
extern __declspec(dllexport) void SetFriendRemark(char* operationID, char* userIDRemark);
extern __declspec(dllexport) void DeleteFriend(char* operationID, char* friendUserID);
extern __declspec(dllexport) void GetRecvFriendApplicationList(char* operationID);
extern __declspec(dllexport) void GetSendFriendApplicationList(char* operationID);
extern __declspec(dllexport) void AcceptFriendApplication(char* operationID, char* userIDHandleMsg);
extern __declspec(dllexport) void RefuseFriendApplication(char* operationID, char* userIDHandleMsg);
extern __declspec(dllexport) void AddBlack(char* operationID, char* blackUserID);
extern __declspec(dllexport) void GetBlackList(char* operationID);
extern __declspec(dllexport) void RemoveBlack(char* operationID, char* removeUserID);
extern __declspec(dllexport) void GetAllConversationList(char* operationID);
extern __declspec(dllexport) void GetConversationListSplit(char* operationID, int32_t offset, int32_t count);
extern __declspec(dllexport) void GetOneConversation(char* operationID, int sessionType, char* sourceID);
extern __declspec(dllexport) void GetMultipleConversation(char* operationID, char* conversationIDList);
extern __declspec(dllexport) void SetOneConversationPrivateChat(char* operationID, char* conversationID, _Bool isPrivate);
extern __declspec(dllexport) void SetOneConversationBurnDuration(char* operationID, char* conversationID, int32_t burnDuration);
extern __declspec(dllexport) void SetOneConversationRecvMessageOpt(char* operationID, char* conversationID, int opt);
extern __declspec(dllexport) void SetConversationRecvMessageOpt(char* operationID, char* conversationIDList, int opt);
extern __declspec(dllexport) void SetGlobalRecvMessageOpt(char* operationID, int opt);
extern __declspec(dllexport) void HideConversation(char* operationID, char* conversationID);
extern __declspec(dllexport) void GetConversationRecvMessageOpt(char* operationID, char* conversationIDList);
extern __declspec(dllexport) void DeleteConversation(char* operationID, char* conversationID);
extern __declspec(dllexport) void DeleteAllConversationFromLocal(char* operationID);
extern __declspec(dllexport) void SetConversationDraft(char* operationID, char* conversationID, char* draftText);
extern __declspec(dllexport) void ResetConversationGroupAtType(char* operationID, char* conversationID);
extern __declspec(dllexport) void PinConversation(char* operationID, char* conversationID, _Bool isPinned);
extern __declspec(dllexport) void GetTotalUnreadMsgCount(char* operationID);
extern __declspec(dllexport) char* CreateAdvancedTextMessage(char* operationID, char* text, char* messageEntityList);
extern __declspec(dllexport) char* CreateTextMessage(char* operationID, char* text);
extern __declspec(dllexport) char* CreateTextAtMessage(char* operationID, char* text, char* atUserList, char* atUsersInfo, char* message);
extern __declspec(dllexport) char* CreateLocationMessage(char* operationID, char* description, double longitude, double latitude);
extern __declspec(dllexport) char* CreateCustomMessage(char* operationID, char* data, char* extension, char* description);
extern __declspec(dllexport) char* CreateQuoteMessage(char* operationID, char* text, char* message);
extern __declspec(dllexport) char* CreateAdvancedQuoteMessage(char* operationID, char* text, char* message, char* messageEntityList);
extern __declspec(dllexport) char* CreateCardMessage(char* operationID, char* cardInfo);
extern __declspec(dllexport) char* CreateVideoMessageFromFullPath(char* operationID, char* videoFullPath, char* videoType, int64_t duration, char* snapshotFullPath);
extern __declspec(dllexport) char* CreateImageMessageFromFullPath(char* operationID, char* imageFullPath);
extern __declspec(dllexport) char* CreateSoundMessageFromFullPath(char* operationID, char* soundPath, int64_t duration);
extern __declspec(dllexport) char* CreateFileMessageFromFullPath(char* operationID, char* fileFullPath, char* fileName);
extern __declspec(dllexport) char* CreateImageMessage(char* operationID, char* imagePath);
extern __declspec(dllexport) char* CreateImageMessageByURL(char* operationID, char* sourcePicture, char* bigPicture, char* snapshotPicture);
extern __declspec(dllexport) char* CreateSoundMessageByURL(char* operationID, char* soundBaseInfo);
extern __declspec(dllexport) char* CreateSoundMessage(char* operationID, char* soundPath, int64_t duration);
extern __declspec(dllexport) char* CreateVideoMessageByURL(char* operationID, char* videoBaseInfo);
extern __declspec(dllexport) char* CreateVideoMessage(char* operationID, char* videoPath, char* videoType, int64_t duration, char* snapshotPath);
extern __declspec(dllexport) char* CreateFileMessageByURL(char* operationID, char* fileBaseInfo);
extern __declspec(dllexport) char* CreateFileMessage(char* operationID, char* filePath, char* fileName);
extern __declspec(dllexport) char* CreateMergerMessage(char* operationID, char* mergerElemList, char* title, char* summaryList);
extern __declspec(dllexport) char* CreateFaceMessage(char* operationID, int index, char* data);
extern __declspec(dllexport) char* CreateForwardMessage(char* operationID, char* message);
extern __declspec(dllexport) void SendMessage(char* operationID, char* message, char* recvID, char* groupID, char* offlinePushInfo, char* clientMsgID);
extern __declspec(dllexport) void SendMessageNotOss(char* operationID, char* message, char* recvID, char* groupID, char* offlinePushInfo, char* clientMsgID);
extern __declspec(dllexport) void FindMessageList(char* operationID, char* findMessageOptions);
extern __declspec(dllexport) void GetHistoryMessageList(char* operationID, char* getMessageOptions);
extern __declspec(dllexport) void GetAdvancedHistoryMessageList(char* operationID, char* getMessageOptions);
extern __declspec(dllexport) void GetAdvancedHistoryMessageListReverse(char* operationID, char* getMessageOptions);
extern __declspec(dllexport) void GetHistoryMessageListReverse(char* operationID, char* getMessageOptions);
extern __declspec(dllexport) void RevokeMessage(char* operationID, char* message);
extern __declspec(dllexport) void NewRevokeMessage(char* operationID, char* message);
extern __declspec(dllexport) void TypingStatusUpdate(char* operationID, char* recvID, char* msgTip);
extern __declspec(dllexport) void MarkC2CMessageAsRead(char* operationID, char* userID, char* msgIDList);
extern __declspec(dllexport) void MarkMessageAsReadByConID(char* operationID, char* conversationID, char* msgIDList);
extern __declspec(dllexport) void MarkGroupMessageHasRead(char* operationID, char* groupID);
extern __declspec(dllexport) void MarkGroupMessageAsRead(char* operationID, char* groupID, char* msgIDList);
extern __declspec(dllexport) void DeleteMessageFromLocalStorage(char* operationID, char* message);
extern __declspec(dllexport) void DeleteMessageFromLocalAndSvr(char* operationID, char* message);
extern __declspec(dllexport) void DeleteConversationFromLocalAndSvr(char* operationID, char* conversationID);
extern __declspec(dllexport) void DeleteAllMsgFromLocalAndSvr(char* operationID);
extern __declspec(dllexport) void DeleteAllMsgFromLocal(char* operationID);
extern __declspec(dllexport) void ClearC2CHistoryMessage(char* operationID, char* userID);
extern __declspec(dllexport) void ClearC2CHistoryMessageFromLocalAndSvr(char* operationID, char* userID);
extern __declspec(dllexport) void ClearGroupHistoryMessage(char* operationID, char* groupID);
extern __declspec(dllexport) void ClearGroupHistoryMessageFromLocalAndSvr(char* operationID, char* groupID);
extern __declspec(dllexport) void InsertSingleMessageToLocalStorage(char* operationID, char* message, char* recvID, char* sendID);
extern __declspec(dllexport) void InsertGroupMessageToLocalStorage(char* operationID, char* message, char* groupID, char* senderID);
extern __declspec(dllexport) void SearchLocalMessages(char* operationID, char* searchParam);
extern __declspec(dllexport) char* GetConversationIDBySessionType(char* sourceID, int sessionType);
extern __declspec(dllexport) char* GetAtAllTag();
extern __declspec(dllexport) void SetMessageReactionExtensions(char* operationID, char* message, char* reactionExtensionList);
extern __declspec(dllexport) void AddMessageReactionExtensions(char* operationID, char* message, char* reactionExtensionList);
extern __declspec(dllexport) void DeleteMessageReactionExtensions(char* operationID, char* message, char* reactionExtensionList);
extern __declspec(dllexport) void GetMessageListReactionExtensions(char* operationID, char* messageList);
extern __declspec(dllexport) void GetMessageListSomeReactionExtensions(char* operationID, char* messageList, char* reactionExtensionList);
extern __declspec(dllexport) void SetTypeKeyInfo(char* operationID, char* message, char* typeKey, char* ex, _Bool isCanRepeat);
extern __declspec(dllexport) void GetTypeKeyListInfo(char* operationID, char* messageList, char* typeKeyList);
extern __declspec(dllexport) void GetAllTypeKeyInfo(char* operationID, char* message);
extern __declspec(dllexport) void SignalingInviteInGroup(char* operationID, char* signalInviteInGroupReq);
extern __declspec(dllexport) void SignalingInvite(char* operationID, char* signalInviteReq);
extern __declspec(dllexport) void SignalingAccept(char* operationID, char* signalAcceptReq);
extern __declspec(dllexport) void SignalingReject(char* operationID, char* signalRejectReq);
extern __declspec(dllexport) void SignalingCancel(char* operationID, char* signalCancelReq);
extern __declspec(dllexport) void SignalingHungUp(char* operationID, char* signalHungUpReq);
extern __declspec(dllexport) void SignalingGetRoomByGroupID(char* operationID, char* groupID);
extern __declspec(dllexport) void SignalingGetTokenByRoomID(char* operationID, char* groupID);
extern __declspec(dllexport) void GetSubDepartment(char* operationID, char* departmentID, int offset, int size);
extern __declspec(dllexport) void GetDepartmentMember(char* operationID, char* departmentID, int offset, int size);
extern __declspec(dllexport) void GetUserInDepartment(char* operationID, char* userID);
extern __declspec(dllexport) void GetDepartmentMemberAndSubDepartment(char* operationID, char* departmentID);
extern __declspec(dllexport) void GetParentDepartmentList(char* operationID, char* departmentID);
extern __declspec(dllexport) void GetDepartmentInfo(char* operationID, char* departmentID);
extern __declspec(dllexport) void SearchOrganization(char* operationID, char* input, int offset, int count);
extern __declspec(dllexport) void GetWorkMomentsUnReadCount(char* operationID);
extern __declspec(dllexport) void GetWorkMomentsNotification(char* operationID, int offset, int count);
extern __declspec(dllexport) void ClearWorkMomentsNotification(char* operationID);
extern __declspec(dllexport) void UpdateFcmToken(char* operationID, char* fmcToken);
extern __declspec(dllexport) void SetAppBadge(char* operationID, int32_t appUnreadCount);

#ifdef __cplusplus
}
#endif
