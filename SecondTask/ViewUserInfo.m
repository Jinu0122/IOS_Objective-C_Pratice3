///
//  ViewUserInfo.m
//  SecondTask
//
//  Created by Jinwoo on 2023/06/22.
//

#import "ViewUserInfo.h"

@interface ViewUserInfo ()
{
    UIView *infoView;
    
    UILabel *lblWhiteView;
    
    UIImageView *imgRdoLeft;
    UIImageView *imgRdoRight;
    
    UITextField *eidtPhoneNum;
    UITextField *editName;
    
    UIButton *btnRdoLeft;
    UIButton *btnRdoRight;
    UIButton *btnAddClick;
    
    NSString *name;
    NSString *phoneNum;
    NSString *jenderName;
    
}
@end

@implementation ViewUserInfo

@synthesize delegate;
@synthesize userInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self f_viewDraw]; // 그리기
    [self f_InitSetting]; // ViewController 에서 넘어온 값이 있으면 셋팅

}

- (void)f_viewDraw;{
    UIColor *bgAlpha = [[UIColor blackColor] colorWithAlphaComponent:0.5]; // bg alpha
    UIColor *transparentAlpha = [[UIColor blackColor] colorWithAlphaComponent:0.0]; // 버튼위에 올라갈 알파값
    
    infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [infoView setBackgroundColor : bgAlpha];
    [self.view addSubview:infoView];
    
    lblWhiteView = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoView.frame) -300,
                                                                    CGRectGetWidth(infoView.frame), 300)];
    [lblWhiteView setBackgroundColor:[UIColor whiteColor]];
    [infoView addSubview:lblWhiteView];
    
    editName = [[UITextField alloc] initWithFrame:CGRectMake(24 , CGRectGetMaxY(infoView.frame) -270, 200, 50)];
    [editName setBorderStyle:UITextBorderStyleLine];
    [editName setFont:[UIFont fontWithName:@"Arial" size:20]];
    [editName setPlaceholder:@" 이름"];
    [editName addTarget:self action:@selector(onTextFiledNameChange:) forControlEvents:UIControlEventEditingDidEnd];
    [editName setDelegate:self];
    [infoView addSubview:editName];
    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(24, CGRectGetMaxY(infoView.frame) -203, 200, 50)];
    [lblText setText:@"성별 : "];
    [infoView addSubview:lblText];
    
    UILabel *lblMan = [[UILabel alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(infoView.frame) -203, 200, 50)];
    [lblMan setText:@"남"];
    [infoView addSubview:lblMan];
    
    UILabel *lblWoman = [[UILabel alloc] initWithFrame:CGRectMake(230, CGRectGetMaxY(infoView.frame) -203, 200, 50)];
    [lblWoman setText:@"여"];
    [infoView addSubview:lblWoman];

    imgRdoLeft = [[UIImageView alloc] initWithFrame:CGRectMake(105, CGRectGetMaxY(infoView.frame) -193, 32, 32)];
    [imgRdoLeft setBackgroundColor:[UIColor whiteColor]];
    [imgRdoLeft setImage:[UIImage imageNamed:@"ic_radio2_n.png"]];
    [infoView addSubview:imgRdoLeft];
    
    jenderName = @"여";
    
    btnRdoLeft = [[UIButton alloc] initWithFrame:CGRectMake(105, CGRectGetMaxY(infoView.frame) -193, 32, 32)];;
    [btnRdoLeft setBackgroundColor:transparentAlpha];

    [infoView addSubview:btnRdoLeft];
    [btnRdoLeft addTarget:self action:@selector(onBtnLeftTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    imgRdoRight = [[UIImageView alloc] initWithFrame:CGRectMake(255, CGRectGetMaxY(infoView.frame) -193, 32, 32)];
    [imgRdoRight setBackgroundColor:[UIColor whiteColor]];
    [imgRdoRight setImage:[UIImage imageNamed:@"ic_radio2_o.png"]];
    [infoView addSubview:imgRdoRight];

    btnRdoRight = [[UIButton alloc] initWithFrame:CGRectMake(255, CGRectGetMaxY(infoView.frame) -193, 32, 32)];;
    [btnRdoRight setBackgroundColor:transparentAlpha];

    [infoView addSubview:btnRdoRight];
    [btnRdoRight addTarget:self action:@selector(onBtnRightTouch:) forControlEvents:UIControlEventTouchUpInside];

    eidtPhoneNum = [[UITextField alloc] initWithFrame:CGRectMake(24 , CGRectGetMaxY(infoView.frame) -150, 200, 50)];
    [eidtPhoneNum setBorderStyle:UITextBorderStyleLine];
    [eidtPhoneNum setFont:[UIFont fontWithName:@"Arial" size:20]];
    [eidtPhoneNum setPlaceholder:@" 전화번호"];
    [eidtPhoneNum setDelegate:self];
    [eidtPhoneNum addTarget:self action:@selector(onTextFiledNumChange:) forControlEvents:UIControlEventEditingDidEnd];

    
    [infoView addSubview:eidtPhoneNum];
    
    btnAddClick = [[UIButton alloc] initWithFrame:CGRectMake(24 , CGRectGetMaxY(infoView.frame) -90, 200, 50)];;
    [btnAddClick setTitle:@"추가" forState:UIControlStateNormal]; // 텍스트
    [btnAddClick setBackgroundColor:[UIColor blueColor]];
    [infoView addSubview:btnAddClick];
    
    [btnAddClick addTarget:self action:@selector(onBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)f_InitSetting;{
    
    if (userInfo.name != nil) {
        name = userInfo.name;
        [editName setText:name];
    }
    else{
        return;
    }
    
    if (userInfo.phoneNum != nil){
        phoneNum = userInfo.phoneNum;
        [eidtPhoneNum setText:phoneNum];
    }
    else{
        return;
    }
    
    if (userInfo.jender != nil){
        jenderName = userInfo.jender;
        
        if ([jenderName isEqualToString:@"남"]){
            [self onBtnLeftTouch:btnRdoLeft];
        }
        else{
            [self onBtnRightTouch:btnRdoRight];
        }
    }
    else{
        return;
    }
    
    [btnAddClick setTitle:@"변경" forState:UIControlStateNormal]; // 텍스트
}

// 추가 버튼을 클릭시
- (void)onBtnTouch:(UIButton*)sender // 버튼 클릭시
{

    [eidtPhoneNum resignFirstResponder];
    [editName resignFirstResponder];
    
    bool bReturnValue = [self PhoneNumValidCheck:[eidtPhoneNum text]];
//    NSLog(@"%hhd",bReturnValue);
    if (bReturnValue == NO){
        return;
    }
    
    NSString *sName = name;
    NSString *sJender = jenderName;
    NSString *sNumber = phoneNum;
    
    if ([sName length] == 0 || [sJender length] == 0 || [sNumber length] == 0)
    {
        [self ShowAlert:@"빈값없이 입력해주세요"];
        
        return;
    }
    
    if ([[btnAddClick currentTitle] isEqualToString:@"추가"]){
        [self.delegate getData:sName gender:sJender numnber:sNumber];
    }
    else{
        [self.delegate getEditData:sName gender:sJender numnber:sNumber];
    }
  
    // 20230705 오픈팝업 해주는 ViewController 으로 옮김
//    [self.view removeFromSuperview];
//    [self removeFromParentViewController];
    
}

// 알파된 버튼을 클릭시 이미지를 바꿔주자
- (void)onBtnLeftTouch:(UIButton*)sender // 버튼 클릭시
{
    
    [imgRdoLeft setImage:[UIImage imageNamed:@"ic_radio2_o.png"]];
    [imgRdoRight setImage:[UIImage imageNamed:@"ic_radio2_n.png"]];
    jenderName = @"남";
    
}

// 알파된 버튼을 클릭시 이미지를 바꿔주자
- (void)onBtnRightTouch:(UIButton*)sender // 버튼 클릭시
{
    [imgRdoLeft setImage:[UIImage imageNamed:@"ic_radio2_n.png"]];
    [imgRdoRight setImage:[UIImage imageNamed:@"ic_radio2_o.png"]];
    jenderName = @"여";
}

- (void)onTextFiledNameChange:(UITextField*)sender // 텍스트필드가 변환될 시
{
    name = editName.text;
    NSLog(@"onTextFiledNameChange");
}

// 전화번호 에디트값이 바뀌었을때
- (void)onTextFiledNumChange:(UITextField*)sender // 텍스트필드가 변환될 시
{
    NSLog(@"onTextFiledNumChange");
//    [self performSelector:@selector(onBtnTouch:) withObject:nil afterDelay:1.0];
    
}

// 텍스트필트 클릭시 초기화
- (BOOL)textFieldShouldBeginEditing:(UITextField *)eidtPhoneNum;
{
    [eidtPhoneNum resignFirstResponder];
    [eidtPhoneNum setText:@""];
    
    return YES;
}

// 전화번호 형식이 맞지않을때 띄울 얼럿
-(void)ShowAlert:(NSString*)sContent;
{
    //팝업구현을 하는 클래스

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"알림" message:sContent preferredStyle:UIAlertControllerStyleAlert];
    //팝업 버튼 구현하는 클래스

    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"닫기" style:UIAlertActionStyleCancel handler:nil];
    //팝업 클래스에 버튼을 넣는 메소드 호출
    [alert addAction:closeAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(BOOL)PhoneNumValidCheck:sNum{
    
    sNum = [[sNum componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet]invertedSet]]componentsJoinedByString:@""];
    NSString *someRegexp = @"^0\\d{9,10}$";
//    NSString *someRegexp = @"(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})";
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", someRegexp];

    // 전화번호 형식일때
    if ([myTest evaluateWithObject: sNum]){

        NSLog(@"it is a phone number");
        
        phoneNum = [eidtPhoneNum text];
        
        NSInteger nCnt = [[eidtPhoneNum text]length];

        NSString *sFrontNum;
        NSString *sMidNum;
        NSString *sEndNum;
        
        // 마스킹을 시작하자 뚝딱 뚝딱
        if (nCnt == 11) {
            sFrontNum = [phoneNum substringToIndex : 3];
            sMidNum = [[phoneNum substringFromIndex : 3] substringToIndex : 4];
            sEndNum = [phoneNum substringFromIndex : 7];
            
            NSString *sTemp =  [NSString stringWithFormat:@"%@ - %@ - %@", sFrontNum,sMidNum,sEndNum];
            [eidtPhoneNum setText:sTemp];
        }
            
        else{
            sFrontNum = [phoneNum substringToIndex : 3];
            sMidNum = [[phoneNum substringFromIndex : 3] substringToIndex : 3];
            sEndNum = [phoneNum substringFromIndex : 6];
            
            NSString *sTemp =  [NSString stringWithFormat:@"%@ - %@ - %@", sFrontNum,sMidNum,sEndNum];
            [eidtPhoneNum setText:sTemp];
            
        }
        
    // 전화번호 형식이 아닐때
    }else{

        if ([[eidtPhoneNum text]length] == 0)
        {

        }else{
            [self ShowAlert:@"전화번호를 다시 입력해주세요."];
            return NO;
        }

    }
    
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    if (!CGRectContainsPoint(lblWhiteView.frame , [touch locationInView:infoView]))
    {
        [self.delegate CloseScreen];
    }
}

-(void) dealloc{
    NSLog(@"ViewUserInfo Screen dealloc");
    
    [infoView removeFromSuperview];
    [lblWhiteView removeFromSuperview];
    
    [imgRdoLeft removeFromSuperview];
    [imgRdoRight removeFromSuperview];
    [editName removeFromSuperview];
    [eidtPhoneNum removeFromSuperview];
    
    [btnRdoLeft removeFromSuperview];
    [btnRdoRight removeFromSuperview];
    [btnAddClick removeFromSuperview];
    
    [self CloseNilProc:infoView];
    
    [self CloseNilProc:lblWhiteView];
    
    [self CloseNilProc:imgRdoLeft];
    [self CloseNilProc:imgRdoRight];
    
    [self CloseNilProc:editName];
    [self CloseNilProc:eidtPhoneNum];
    
    [self CloseNilProc:btnRdoLeft];
    [self CloseNilProc:btnRdoRight];
    [self CloseNilProc:btnAddClick];
    
    [self CloseNilProc:name];
    [self CloseNilProc:phoneNum];
    [self CloseNilProc:jenderName];
    
    [self CloseNilProc:userInfo];
    
}

-(void)CloseNilProc:sObject{
    if (sObject != nil) {
        sObject = nil;
    }
}

@end
