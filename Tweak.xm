
#import <rocketbootstrap.h>

#import "interface.h"








%hook SMSApplication
-(id)init
{
    id ret = %orig;

    CPDistributedMessagingCenter *center_sms = [CPDistributedMessagingCenter centerNamed:@"com.lw.server_sms"] ;
    ////////////////////////////7.0+////////////////////////////////////
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){

        rocketbootstrap_distributedmessagingcenter_apply(center_sms);
    }
    ////////////////////////////////////////////////////////////////////
    [center_sms runServerOnCurrentThread];
    [center_sms registerForMessageName:@"sendsms" target:self selector:@selector(sendsms:userInfo:)];




    CPDistributedMessagingCenter *center_mms = [CPDistributedMessagingCenter centerNamed:@"com.lw.server_mms"] ;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){

        rocketbootstrap_distributedmessagingcenter_apply(center_mms);
    }
    [center_mms runServerOnCurrentThread];
    [center_mms registerForMessageName:@"sendmms" target:self selector:@selector(sendmms:userInfo:)];
    return ret;
}



%new
- (void)sendsms:(NSString *)name userInfo:(NSDictionary *)userInfo
{
    


//sendSMS
    
    NSString *body = [userInfo objectForKey:@"body"];
    NSString *recipient = [userInfo objectForKey:@"recipient"];
    

//Get the shared conversation list
    CKConversationList* conversationList = [CKConversationList sharedConversationList];


//Get the conversation for an address


    CKEntity *entity = [CKEntity copyEntityForAddressString:recipient];
    CKConversation* conversation = [conversationList conversationForRecipients:[NSArray arrayWithObjects:entity,nil] create:YES];
    



//Make a new composition
    NSAttributedString* text = [[NSAttributedString alloc] initWithString:body];
    CKComposition* composition = [[CKComposition alloc] initWithText:text subject:nil];


//A new message
    CKIMMessage* smsMessage = [conversation newMessageWithComposition:composition addToConversation:YES];


//send the message
    [conversation sendMessage:smsMessage newComposition:YES];

}


%new
- (void)sendmms:(NSString *)name userInfo:(NSDictionary *)userInfo
{

    NSData *data = nil;
    CKMediaObject *mediaObject = nil;
    CKMediaObjectMessagePart *messagePart = nil;

    NSString *recipient = @"1234567890";[userInfo objectForKey:@"recipient"];
    NSString *ImagePath = @"/Applications/MobileSMS.app/mmstest.png";


//make entities
    CKEntity *imentity = [CKEntity copyEntityForAddressString:recipient];
    NSArray *recipient_arra = [[NSArray alloc]initWithObjects:imentity, nil];

//make composition from an address
    data = [NSData dataWithContentsOfFile:ImagePath];
    mediaObject = [[CKMediaObjectManager sharedInstance]mediaObjectWithData:data UTIType:[[IMFileManager defaultHFSFileManager] UTITypeOfPath:ImagePath] filename:nil transcoderUserInfo:nil];
    messagePart = [[CKMediaObjectMessagePart alloc] initWithMediaObject:mediaObject];
    CKComposition *composition = [CKComposition compositionForMessageParts:[NSArray arrayWithObjects:messagePart,nil]];

//make conversation
    CKConversationList *conversationList = [CKConversationList sharedConversationList];
    CKConversation *conversation = [conversationList conversationForRecipients:recipient_arra create:YES];

//new message
    CKIMMessage *message = [conversation newMessageWithComposition:composition addToConversation:YES];
    [conversation addMessage:message];
    
//send message
    [conversation sendMessage:message newComposition:YES];

}

%end


