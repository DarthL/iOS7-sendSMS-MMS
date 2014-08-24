//
//  Tweak.h
//  SMS_dylib
//
//  Created by 梁伟 on 13-9-18.
//
//

//////ChatKit IM///////
@class CKIMMessage,CKMediaObject;

@interface CKConversation : NSObject
- (id)newMessageWithComposition:(id)arg1 addToConversation:(_Bool)arg2;
-(void)addMessage:(id)message;
-(void)sendMessage:(id)message newComposition:(BOOL)composition;
@end

@interface CKConversationList : NSObject
+(id)sharedConversationList;
-(id)conversationForRecipients:(id)recipients create:(BOOL)create;
@end

@interface CKEntity : NSObject {
}
+(id)copyEntityForAddressString:(id)arg1;
@end

@interface CKComposition : NSObject
- (id)initWithText:(id)arg1 subject:(id)arg2;
+ (id)compositionForMessageParts:(id)arg1;
@property(copy, nonatomic) NSAttributedString *subject; // @synthesize subject=_subject;
@property(copy, nonatomic) NSAttributedString *text; // @synthesize text=_text;
@end



@interface CKMediaObjectManager : NSObject{
}
+ (id)sharedInstance;
- (id)mediaObjectWithData:(id)arg1 UTIType:(id)arg2 filename:(id)arg3 transcoderUserInfo:(id)arg4;
@end

@interface IMFileManager : NSFileManager{
}
+ (id)defaultHFSFileManager;
- (id)UTITypeOfPath:(id)arg1;
@end


@interface CKMediaObjectMessagePart : NSObject{
}
- (id)initWithMediaObject:(id)arg1;
@end


///CPDistributedMessagingCenter////
@interface CPDistributedMessagingCenter : NSObject
+ (id)centerNamed:(id)arg1;
- (void)runServerOnCurrentThread;
- (void)registerForMessageName:(id)arg1 target:(id)arg2 selector:(SEL)arg3;
- (BOOL)sendMessageName:(id)arg1 userInfo:(id)arg2;
@end
