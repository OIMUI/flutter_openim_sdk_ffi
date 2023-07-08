/* Code generated by cmd/cgo; DO NOT EDIT. */

/* package command-line-arguments */


#line 1 "cgo-builtin-export-prolog"

#include <stddef.h> /* for ptrdiff_t below */

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
typedef __SIZE_TYPE__ GoUintptr;
typedef float GoFloat32;
typedef double GoFloat64;
typedef float _Complex GoComplex64;
typedef double _Complex GoComplex128;

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

extern void RegisterCallback(CGO_OpenIM_Listener* callback, Dart_Port_DL port);
extern char* GetSdkVersion();
extern _Bool InitSDK(char* operationID, char* config);
extern void Login(char* operationID, char* userID, char* token);
extern void WakeUp(char* operationID);
extern void NetworkChanged(char* operationID);
extern void UploadImage(char* operationID, char* filePath, char* token, char* obj);
extern void UploadFile(char* operationID, char* filePath);
extern void Logout(char* operationID);
extern void SetAppBackgroundStatus(char* operationID, _Bool isBackground);
extern int32_t GetLoginStatus();
extern char* GetLoginUser();
extern void GetUsersInfo(char* operationID, char* userIDList);
extern void SetSelfInfo(char* operationID, char* userInfo);
extern void GetSelfUserInfo(char* operationID);
extern void CreateGroup(char* operationID, char* groupBaseInfo, char* memberList);
extern void JoinGroup(char* operationID, char* groupID, char* reqMsg, int32_t joinSource);
extern void QuitGroup(char* operationID, char* groupID);
extern void DismissGroup(char* operationID, char* groupID);
extern void ChangeGroupMute(char* operationID, char* groupID, _Bool isMute);
extern void ChangeGroupMemberMute(char* operationID, char* groupID, char* userID, int mutedSeconds);
extern void SetGroupMemberRoleLevel(char* operationID, char* groupID, char* userID, int roleLevel);
extern void SetGroupMemberInfo(char* operationID, char* groupMemberInfo);
extern void GetJoinedGroupList(char* operationID);
extern void GetGroupsInfo(char* operationID, char* groupIDList);
extern void SearchGroups(char* operationID, char* searchParam);
extern void SetGroupInfo(char* operationID, char* groupID, char* groupInfo);
extern void SetGroupVerification(char* operationID, char* groupID, int32_t verification);
extern void SetGroupLookMemberInfo(char* operationID, char* groupID, int32_t rule);
extern void SetGroupApplyMemberFriend(char* operationID, char* groupID, int32_t rule);
extern void GetGroupMemberList(char* operationID, char* groupID, int32_t filter, int32_t offset, int32_t count);
extern void GetGroupMemberOwnerAndAdmin(char* operationID, char* groupID);
extern void GetGroupMemberListByJoinTimeFilter(char* operationID, char* groupID, int32_t offset, int32_t count, int64_t joinTimeBegin, int64_t joinTimeEnd, char* filterUserIDList);
extern void GetGroupMembersInfo(char* operationID, char* groupID, char* userIDList);
extern void KickGroupMember(char* operationID, char* groupID, char* reason, char* userIDList);
extern void TransferGroupOwner(char* operationID, char* groupID, char* newOwnerUserID);
extern void InviteUserToGroup(char* operationID, char* groupID, char* reason, char* userIDList);
extern void GetRecvGroupApplicationList(char* operationID);
extern void GetSendGroupApplicationList(char* operationID);
extern void AcceptGroupApplication(char* operationID, char* groupID, char* fromUserID, char* handleMsg);
extern void RefuseGroupApplication(char* operationID, char* groupID, char* fromUserID, char* handleMsg);
extern void SetGroupMemberNickname(char* operationID, char* groupID, char* userID, char* groupMemberNickname);
extern void SearchGroupMembers(char* operationID, char* searchParam);

// //////////////////////////friend/////////////////////////////////////
//
extern void GetDesignatedFriendsInfo(char* operationID, char* userIDList);
extern void GetFriendList(char* operationID);
extern void SearchFriends(char* operationID, char* searchParam);
extern void CheckFriend(char* operationID, char* userIDList);
extern void AddFriend(char* operationID, char* userIDReqMsg);
extern void SetFriendRemark(char* operationID, char* userIDRemark);
extern void DeleteFriend(char* operationID, char* friendUserID);
extern void GetRecvFriendApplicationList(char* operationID);
extern void GetSendFriendApplicationList(char* operationID);
extern void AcceptFriendApplication(char* operationID, char* userIDHandleMsg);
extern void RefuseFriendApplication(char* operationID, char* userIDHandleMsg);
extern void AddBlack(char* operationID, char* blackUserID);
extern void GetBlackList(char* operationID);
extern void RemoveBlack(char* operationID, char* removeUserID);
extern void GetAllConversationList(char* operationID);
extern void GetConversationListSplit(char* operationID, int32_t offset, int32_t count);
extern void GetOneConversation(char* operationID, int sessionType, char* sourceID);
extern void GetMultipleConversation(char* operationID, char* conversationIDList);
extern void SetOneConversationPrivateChat(char* operationID, char* conversationID, _Bool isPrivate);
extern void SetOneConversationBurnDuration(char* operationID, char* conversationID, int32_t burnDuration);
extern void SetOneConversationRecvMessageOpt(char* operationID, char* conversationID, int opt);
extern void SetConversationRecvMessageOpt(char* operationID, char* conversationIDList, int opt);
extern void SetGlobalRecvMessageOpt(char* operationID, int opt);
extern void HideConversation(char* operationID, char* conversationID);
extern void GetConversationRecvMessageOpt(char* operationID, char* conversationIDList);
extern void DeleteConversation(char* operationID, char* conversationID);
extern void DeleteAllConversationFromLocal(char* operationID);
extern void SetConversationDraft(char* operationID, char* conversationID, char* draftText);
extern void ResetConversationGroupAtType(char* operationID, char* conversationID);
extern void PinConversation(char* operationID, char* conversationID, _Bool isPinned);
extern void GetTotalUnreadMsgCount(char* operationID);
extern char* CreateAdvancedTextMessage(char* operationID, char* text, char* messageEntityList);
extern char* CreateTextMessage(char* operationID, char* text);
extern char* CreateTextAtMessage(char* operationID, char* text, char* atUserList, char* atUsersInfo, char* message);
extern char* CreateLocationMessage(char* operationID, char* description, double longitude, double latitude);
extern char* CreateCustomMessage(char* operationID, char* data, char* extension, char* description);
extern char* CreateQuoteMessage(char* operationID, char* text, char* message);
extern char* CreateAdvancedQuoteMessage(char* operationID, char* text, char* message, char* messageEntityList);
extern char* CreateCardMessage(char* operationID, char* cardInfo);
extern char* CreateVideoMessageFromFullPath(char* operationID, char* videoFullPath, char* videoType, int64_t duration, char* snapshotFullPath);
extern char* CreateImageMessageFromFullPath(char* operationID, char* imageFullPath);
extern char* CreateSoundMessageFromFullPath(char* operationID, char* soundPath, int64_t duration);
extern char* CreateFileMessageFromFullPath(char* operationID, char* fileFullPath, char* fileName);
extern char* CreateImageMessage(char* operationID, char* imagePath);
extern char* CreateImageMessageByURL(char* operationID, char* sourcePicture, char* bigPicture, char* snapshotPicture);
extern char* CreateSoundMessageByURL(char* operationID, char* soundBaseInfo);
extern char* CreateSoundMessage(char* operationID, char* soundPath, int64_t duration);
extern char* CreateVideoMessageByURL(char* operationID, char* videoBaseInfo);
extern char* CreateVideoMessage(char* operationID, char* videoPath, char* videoType, int64_t duration, char* snapshotPath);
extern char* CreateFileMessageByURL(char* operationID, char* fileBaseInfo);
extern char* CreateFileMessage(char* operationID, char* filePath, char* fileName);
extern char* CreateMergerMessage(char* operationID, char* mergerElemList, char* title, char* summaryList);
extern char* CreateFaceMessage(char* operationID, int index, char* data);
extern char* CreateForwardMessage(char* operationID, char* message);
extern void SendMessage(char* operationID, char* message, char* recvID, char* groupID, char* offlinePushInfo, char* clientMsgID);
extern void SendMessageNotOss(char* operationID, char* message, char* recvID, char* groupID, char* offlinePushInfo, char* clientMsgID);
extern void FindMessageList(char* operationID, char* findMessageOptions);
extern void GetHistoryMessageList(char* operationID, char* getMessageOptions);
extern void GetAdvancedHistoryMessageList(char* operationID, char* getMessageOptions);
extern void GetAdvancedHistoryMessageListReverse(char* operationID, char* getMessageOptions);
extern void GetHistoryMessageListReverse(char* operationID, char* getMessageOptions);
extern void RevokeMessage(char* operationID, char* message);
extern void NewRevokeMessage(char* operationID, char* message);
extern void TypingStatusUpdate(char* operationID, char* recvID, char* msgTip);
extern void MarkC2CMessageAsRead(char* operationID, char* userID, char* msgIDList);
extern void MarkMessageAsReadByConID(char* operationID, char* conversationID, char* msgIDList);
extern void MarkGroupMessageHasRead(char* operationID, char* groupID);
extern void MarkGroupMessageAsRead(char* operationID, char* groupID, char* msgIDList);
extern void DeleteMessageFromLocalStorage(char* operationID, char* message);
extern void DeleteMessageFromLocalAndSvr(char* operationID, char* message);
extern void DeleteConversationFromLocalAndSvr(char* operationID, char* conversationID);
extern void DeleteAllMsgFromLocalAndSvr(char* operationID);
extern void DeleteAllMsgFromLocal(char* operationID);
extern void ClearC2CHistoryMessage(char* operationID, char* userID);
extern void ClearC2CHistoryMessageFromLocalAndSvr(char* operationID, char* userID);
extern void ClearGroupHistoryMessage(char* operationID, char* groupID);
extern void ClearGroupHistoryMessageFromLocalAndSvr(char* operationID, char* groupID);
extern void InsertSingleMessageToLocalStorage(char* operationID, char* message, char* recvID, char* sendID);
extern void InsertGroupMessageToLocalStorage(char* operationID, char* message, char* groupID, char* senderID);
extern void SearchLocalMessages(char* operationID, char* searchParam);
extern char* GetConversationIDBySessionType(char* sourceID, int sessionType);
extern char* GetAtAllTag();
extern void SetMessageReactionExtensions(char* operationID, char* message, char* reactionExtensionList);
extern void AddMessageReactionExtensions(char* operationID, char* message, char* reactionExtensionList);
extern void DeleteMessageReactionExtensions(char* operationID, char* message, char* reactionExtensionList);
extern void GetMessageListReactionExtensions(char* operationID, char* messageList);
extern void GetMessageListSomeReactionExtensions(char* operationID, char* messageList, char* reactionExtensionList);
extern void SetTypeKeyInfo(char* operationID, char* message, char* typeKey, char* ex, _Bool isCanRepeat);
extern void GetTypeKeyListInfo(char* operationID, char* messageList, char* typeKeyList);
extern void GetAllTypeKeyInfo(char* operationID, char* message);
extern void SignalingInviteInGroup(char* operationID, char* signalInviteInGroupReq);
extern void SignalingInvite(char* operationID, char* signalInviteReq);
extern void SignalingAccept(char* operationID, char* signalAcceptReq);
extern void SignalingReject(char* operationID, char* signalRejectReq);
extern void SignalingCancel(char* operationID, char* signalCancelReq);
extern void SignalingHungUp(char* operationID, char* signalHungUpReq);
extern void SignalingGetRoomByGroupID(char* operationID, char* groupID);
extern void SignalingGetTokenByRoomID(char* operationID, char* groupID);
extern void GetSubDepartment(char* operationID, char* departmentID, int offset, int size);
extern void GetDepartmentMember(char* operationID, char* departmentID, int offset, int size);
extern void GetUserInDepartment(char* operationID, char* userID);
extern void GetDepartmentMemberAndSubDepartment(char* operationID, char* departmentID);
extern void GetParentDepartmentList(char* operationID, char* departmentID);
extern void GetDepartmentInfo(char* operationID, char* departmentID);
extern void SearchOrganization(char* operationID, char* input, int offset, int count);
extern void GetWorkMomentsUnReadCount(char* operationID);
extern void GetWorkMomentsNotification(char* operationID, int offset, int count);
extern void ClearWorkMomentsNotification(char* operationID);
extern void UpdateFcmToken(char* operationID, char* fmcToken);
extern void SetAppBadge(char* operationID, int32_t appUnreadCount);

#ifdef __cplusplus
}
#endif
