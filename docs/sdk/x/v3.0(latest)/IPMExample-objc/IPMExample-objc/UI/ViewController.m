//
//  ViewController.m
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import "ViewController.h"
#import "IPMChannelClient.h"
#import "IPMSecurityManager.h"
#import "IPMSecureMessage.h"
#import "LoadingViewController.h"
#import "IPMConstants.h"

@import VirgilSDK;
@import XAsync;

static NSString * _Nonnull const kIPMChatCell = @"IPMChatCell";

static NSString * _Nonnull const kIPMMessageText = @"text";
static NSString * _Nonnull const kIPMMessageSender = @"sender";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tvChat;
@property (nonatomic, weak) IBOutlet UILabel *lTitle;
@property (nonatomic, weak) IBOutlet UILabel *lIdentity;
@property (nonatomic, weak) IBOutlet UITextField *tfMessage;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcBottom;

@property (nonatomic, strong) IPMSecurityManager *ipmSecurity;
@property (nonatomic, strong) IPMChannelClient *ipmClient;

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) LoadingViewController *loadingController;

@end

@implementation ViewController

@synthesize tvChat = _tvChat;
@synthesize lTitle = _lTitle;
@synthesize lIdentity = _lIdentity;
@synthesize tfMessage = _tfMessage;

@synthesize lcBottom = _lcBottom;

@synthesize ipmSecurity = _ipmSecurity;
@synthesize ipmClient = _ipmClient;
@synthesize messages = _messages;
@synthesize loadingController = _loadingController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.messages == nil) {
        self.messages = [[NSMutableArray alloc] init];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.loadingController = [main instantiateViewControllerWithIdentifier:@"LoadingViewController"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    IPMDataSourceListener listener = ^(IPMSecureMessage * _Nonnull content, NSString * _Nonnull sender) {
        if (content != nil) {
            BOOL ok = [self.ipmSecurity checkSignature:content.signature data:content.message identity:sender];
            if (!ok) {
                NSLog(@"Error verifying sender's signature");
                return;
            }
            
            NSData *plainData = [self.ipmSecurity decryptData:content.message];
            if (plainData.length == 0) {
                NSLog(@"Error decrypting message!");
                return;
            }
            
            NSString *text = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
            NSDictionary *dict = @{ kIPMMessageText: text, kIPMMessageSender: sender };
            [self.messages addObject:dict];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tvChat reloadData];
            });
        }
    };
    
    void (^IPMChannelSetup)(void) = ^(void) {
        self.ipmClient = [[IPMChannelClient alloc] initWithUserId:self.ipmSecurity.identity];
        NSError *joinError = [self.ipmClient joinChannelWithName:kAppChannelName channelListener:listener];
        if (joinError != nil) {
            NSLog(@"Error joining the channel: %@", [joinError localizedDescription]);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:NO completion:nil];
            self.lIdentity.text = self.ipmClient.userId;
        });
    };
    
    UIAlertController *introduce = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"Enter your email.", @"Enter your email") preferredStyle:UIAlertControllerStyleAlert];
    [introduce addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        textField.returnKeyType = UIReturnKeyDone;
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *tf = introduce.textFields[0];
        if (tf.text.length > 0) {
            [self presentViewController:self.loadingController animated:NO completion:nil];
            self.ipmSecurity = [[IPMSecurityManager alloc] initWithIdentity:tf.text];
            [self dismissViewControllerAnimated:NO completion:nil];
            
            NSError *signError = [self.ipmSecurity signin];
            if (signError != nil) {
                if (signError.code == -5555) {
                    /// There is no card found. Need to sign up.
                    NSError *signupError = [self.ipmSecurity signup];
                    if (signupError != nil) {
                        [self dismissViewControllerAnimated:NO completion:nil];
                        NSLog(@"Error: %@", [signupError localizedDescription]);
                        return;
                    }
                    
                    IPMChannelSetup();
                    return;
                }
                
                [self dismissViewControllerAnimated:NO completion:nil];
                NSLog(@"Error: %@", [signError localizedDescription]);
                return;
            }
            
            IPMChannelSetup();
        }
    }];
    [introduce addAction:ok];
    [self presentViewController:introduce animated:YES completion:nil];
}

#pragma mark - Private class logic

- (void)sendMessage:(NSString *)message {
    [self presentViewController:self.loadingController animated:NO completion:nil];
    NSArray *participants = [self.ipmClient.channel getParticipants];
    if (participants.count == 0) {
        [self dismissViewControllerAnimated:NO completion:nil];
        NSLog(@"There is no participants on the channel.");
        return;
    }
    
    NSData *encrypted = [self.ipmSecurity encryptData:[message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO] identities:participants];
    if (encrypted.length == 0) {
        [self dismissViewControllerAnimated:NO completion:nil];
        NSLog(@"Error encrypting message.");
        return;
    }
    
    NSData *signature = [self.ipmSecurity composeSignatureOnData:encrypted];
    if (signature.length == 0) {
        [self dismissViewControllerAnimated:NO completion:nil];
        NSLog(@"Error composing the signature.");
        return;
    }
    
    IPMSecureMessage *sm = [[IPMSecureMessage alloc] initWithMessage:encrypted signature:signature];
    NSError *sendError = [self.ipmClient.channel sendMessage:sm];
    if (sendError != nil) {
        [self dismissViewControllerAnimated:NO completion:nil];
        NSLog(@"Error sending the message: %@", [sendError localizedDescription]);
        return;
    }
    
    self.tfMessage.text = @"";
    [self dismissViewControllerAnimated:NO completion:nil];
//
//    
//    BOOL ok = [self.ipmSecurity checkSignature:signature data:encrypted identity:self.ipmSecurity.identity];
//    if (!ok) {
//        NSLog(@"<<<<<<<<<<<<<Error verifying sender's signature");
//        return;
//    }
//    NSData *plainData = [self.ipmSecurity decryptData:encrypted];
//    if (plainData.length == 0) {
//        NSLog(@"<<<<<<<<<<<<Error decrypting message!");
//        return;
//    }
//    NSString *text = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
//    if (![text isEqualToString:message]) {
//        NSLog(@">>>>>>>>>>>>>>FUCKED!");
//    }
//    self.tfMessage.text = @"";
//    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIPMChatCell];
    
    NSDictionary *content = [self.messages[indexPath.row] as:[NSDictionary class]];
    cell.textLabel.text = content[kIPMMessageText];
    cell.detailTextLabel.text = content[kIPMMessageSender];
    return cell;
}

#pragma mark - UITableViewDelegate



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0) {
        [self sendMessage:textField.text];
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIKeyboard notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect endFrame = [([userInfo[UIKeyboardFrameEndUserInfoKey] as:[NSValue class]]) CGRectValue];
    CGRect convertedFrame = [self.view convertRect:endFrame fromView:self.view.window];
    
    self.lcBottom.constant = convertedFrame.size.height;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    self.lcBottom.constant = 20.0;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

@end
