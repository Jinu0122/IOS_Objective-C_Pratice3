//
//  ViewController.m
//  SecondTask
//
//  Created by Jinwoo on 2023/06/22.
//

#import "ViewController.h"


@interface ViewController ()  < UITableViewDelegate , UITableViewDataSource, ViewUserInfoDelefate >
{
    ViewUserInfo *openView; // view
    UserInfo *userInfo; // 객체
    
    NSMutableArray *mutableArray; // 정보가 담겨있는 리스트
    
    UITableView *tableView;
    
    UILabel *nameBox;
    UILabel *jenderBox;
    UILabel *numBox;
    
    NSInteger selectTableindex;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self f_viewDraw];
    
}

- (void)f_viewDraw;{
    
    // 추가버튼 그리기
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) - 155, CGRectGetMinY(self.view.frame) + 100, 150, 50)];
    [btnAdd setBackgroundColor:[UIColor redColor]];
    [btnAdd setTitle:@"추가" forState:UIControlStateNormal]; // 텍스트
    [btnAdd addTarget:self action:@selector(onBtnAddTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
    UIButton *btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 5, CGRectGetMinY(self.view.frame) + 100, 150, 50)];
    
    [btnEdit setBackgroundColor:[UIColor purpleColor]];
    [btnEdit setTitle:@"수정" forState:UIControlStateNormal]; // 텍스트
    [btnEdit addTarget:self action:@selector(onBtnEditTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEdit];
    
    
    nameBox = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 5, CGRectGetMinY(self.view.frame) + 180, 100, 45)];
    [nameBox.layer setBorderColor : UIColor.grayColor.CGColor];
    [nameBox.layer setBorderWidth: 3.0];
    [nameBox setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:nameBox];
    
    jenderBox = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 110, CGRectGetMinY(self.view.frame) + 180, 50, 45)];
    [jenderBox.layer setBorderColor : UIColor.grayColor.CGColor];
    [jenderBox.layer setBorderWidth: 3.0];
    [jenderBox setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:jenderBox];
    
    numBox = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 165, CGRectGetMinY(self.view.frame) + 180, CGRectGetWidth(self.view.frame) - 170, 45)];
    [numBox.layer setBorderColor : UIColor.grayColor.CGColor];
    [numBox.layer setBorderWidth: 3.0];
    [numBox setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:numBox];
    
    tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, CGRectGetMinY(self.view.frame) + 240, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 170)];
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [tableView setRowHeight:50];
    [self.view addSubview:tableView];
    
    mutableArray = [[NSMutableArray alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return [mutableArray count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UILabel *lblName = nil;
    UILabel *lblGender = nil;
    UILabel *lblNumber = nil;
    
    UITableViewCell* cellTable = [tableView dequeueReusableCellWithIdentifier:@"CALENDAR_TEST"];
    if (cellTable == nil) {
        cellTable = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CALENDAR_TEST"];
        cellTable.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cellTable setClipsToBounds:YES];
        
        lblName = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 45)];
        [lblName setBackgroundColor:[UIColor lightGrayColor]];
        [lblName setTextAlignment:NSTextAlignmentCenter];
        [lblName setTag:1];
        [cellTable addSubview:lblName];
        
        
        
        lblGender = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 50, 45)];
        [lblGender setBackgroundColor:[UIColor lightGrayColor]];
        [lblGender setTextAlignment:NSTextAlignmentCenter];
        [lblGender setTag:2];
        [cellTable addSubview:lblGender];
        

        lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(165, 0, CGRectGetWidth(tableView.frame) - 170, 45)];
        [lblNumber setBackgroundColor:[UIColor lightGrayColor]];
        [lblNumber setTextAlignment:NSTextAlignmentCenter];
        [lblNumber setTag:3];
        [cellTable addSubview:lblNumber];
        
        
    }else{
        
        lblName = [cellTable viewWithTag:1];
        lblGender = [cellTable viewWithTag:2];
        lblNumber = [cellTable viewWithTag:3];

    }
    
    NSString *sName = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString *sJender = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:1];
    NSString *sNum = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:2];

    NSString *sMaskingNum = [self MaskingPhoneNum:sNum];
    
    [lblName setText:sName];
    [lblGender setText:sJender];
    [lblNumber setText:sMaskingNum];
    
    return cellTable;
    
    
}

- (void)onBtnAddTouch:(UIButton*)sender // 추가버튼 클릭시
{
    
    openView = [[ViewUserInfo alloc] init];
    openView.delegate = self;
    
    [self addChildViewController:openView];
    [self.view addSubview:openView.view];
    [openView didMoveToParentViewController:self];
    
}

- (void)onBtnEditTouch:(UIButton*)sender // 수정버튼 클릭시
{
    
    if (userInfo.name == nil && userInfo.phoneNum == nil && userInfo.jender == nil ) {
        [self ShowAlert:@"테이블 데이터를 클릭해주세요."];
        return;
    }
    
    openView = [[ViewUserInfo alloc] init];
    openView.delegate = self;
    
    [openView setUserInfo:userInfo];
    
    [self addChildViewController:openView];
    [self.view addSubview:openView.view];
    [openView didMoveToParentViewController:self];
    
}

- (void)getData:(NSString*)value1 gender:(NSString*)value2 numnber:(NSString*)value3;

{
    
    [openView.view removeFromSuperview];
    [openView removeFromParentViewController];
    openView = nil;
    
    [mutableArray addObject:@[value1,value2,value3]];

    [tableView reloadData];
}

- (void)getEditData:(NSString*)value1 gender:(NSString*)value2 numnber:(NSString*)value3;

{
    
    [openView.view removeFromSuperview];
    [openView removeFromParentViewController];
    openView = nil;
    
    
//    [mutableArray insertObject:@[value1,value2,value3] atIndex:selectTableindex];
    [mutableArray replaceObjectAtIndex:selectTableindex withObject:@[value1,value2,value3]];
    
    [numBox setText:@""];
    [nameBox setText:@""];
    [jenderBox setText:@""];
    
    userInfo = nil;
    
    [tableView reloadData];
}
    
    - (void)CloseScreen{
        [openView.view removeFromSuperview];
        [openView removeFromParentViewController];
        openView = nil;
    }
    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *sName = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString *sJender = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:1];
    NSString *sNum = [[mutableArray objectAtIndex:indexPath.row] objectAtIndex:2];
    
    selectTableindex = indexPath.row;
    
    [nameBox setText:sName];
    [jenderBox setText:sJender];
    [numBox setText: [self MaskingPhoneNum:sNum]];
    
    userInfo = [[UserInfo alloc]init];
    
    [userInfo setName:sName];
    [userInfo setJender:sJender];
    [userInfo setPhoneNum:sNum];
    
}

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

-(NSString*) MaskingPhoneNum:sNum{
    // 마스킹을 시작하자 뚝딱 뚝딱
    
    NSString *sFrontNum;
    NSString *sMidNum;
    NSString *sEndNum;
    NSString *sMaskingNum;
    
    NSInteger nCnt = [sNum length];
    
    if (nCnt == 11) {
        sFrontNum = [sNum substringToIndex : 3];
        sMidNum = [[sNum substringFromIndex : 3] substringToIndex : 4];
        sEndNum = [sNum substringFromIndex : 7];

        sMaskingNum = [NSString stringWithFormat:@"%@ - %@ - %@", sFrontNum,sMidNum,sEndNum];
    }
    else{
        sFrontNum = [sNum substringToIndex : 3];
        sMidNum = [[sNum substringFromIndex : 3] substringToIndex : 3];
        sEndNum = [sNum substringFromIndex : 6];
        
        sMaskingNum = [NSString stringWithFormat:@"%@ - %@ - %@", sFrontNum,sMidNum,sEndNum];
    }
    
    return sMaskingNum;
}

@end
