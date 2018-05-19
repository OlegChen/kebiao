

#import "TabBarController.h"
#import "BarButton.h"
#import "Navigation.h"
#import "ViewController.h"

#import "XMGTabBar.h"
#import "UIImage+Image.h"

#import "TeacherVC.h"

#import "UIImage+Common.h"


#import "HomeVC.h"
#import "MeVC.h"
#import "RKSwipeBetweenViewControllers.h"
#import "CalendarClassTableVC.h"

@interface TabBarController ()<UITabBarControllerDelegate>


//@property (nonatomic ,strong) MidVideo *midVideo;


@end

@implementation TabBarController


// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor myColorWithHexString:@"#333333"];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];

    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrsNor[NSForegroundColorAttributeName] = [UIColor myColorWithHexString:@"#888888"];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    
    // Do any additional setup after loading the view.
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    // 2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    
    // 3.自定义tabBar
    [self setupTabBar];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginedSuccess) name:loginFromMyClassBaseTabbar object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midVideoBtnClick) name:midBtnClik object:nil];
}

#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    XMGTabBar *tabBar = [[XMGTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    //修改背景颜色 （还可以加view）
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor myColorWithHexString:@"#f9f9f9"]]];
    
    [UITabBar appearance].translucent = NO;
    
}

//- (void)LoginedSuccess{
//
//    [self setSelectedViewController:[self.viewControllers objectAtIndex:1]];
//
//}

//- (void)midVideoBtnClick{
//
//    if ([UserCenter isLogin]) {
//
////        MidVideo *vc = [[MidVideo alloc]init];
////        self.midVideo = vc;
//
//        BOOL isAuthor =  [ImagePickerManger isHaveAlbumAuthorWithFirstAgreeBlock:^{
//
//            [self toMidVideo];
//
//        } rejectAgree:^{
//
//            return;
//        }];
//
//        if (isAuthor) {
//
//            [self toMidVideo];
//        }
//
//
//
//    }else{
//
//        [self ToLoginVCWithFromMyClass:NO];
//    }
//
//}

- (void)toMidVideo{

//    [MidVideo presentPopMidVideoControllerAnimated:YES  completion:^(NSInteger index) {
//
//        NSLog(@"%ld",(long)index);
//
//        if (index == 0) {
//
//            //拍短视频
//            XHFilterVideoVC *vc = [[XHFilterVideoVC alloc]init];
//            Navigation *nav = [[Navigation alloc]initWithRootViewController:vc];
//            [self presentViewController:nav animated:YES completion:^{
//
//            }];
//
//        }else if (index == 1){
//
//            //选择视频
//            myCustomerVideoPickerVC *vc = [[myCustomerVideoPickerVC alloc]init];
//            Navigation *nav = [[Navigation alloc]initWithRootViewController:vc];
//            [self presentViewController:nav animated:YES completion:^{ }];
//
//
//        }
//
//    }];
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
        
//    if(viewController == [tabBarController.viewControllers objectAtIndex:1])
//    {
//        if ([UserCenter isLogin]) {
//            
//            return YES;
//        }else{
//            
//            [self ToLoginVCWithFromMyClass:YES];
//            return NO;
//        }
//    }
    return YES;
}


- (void)ToLoginVCWithFromMyClass:(BOOL)isFrom{

//    LoginViewController *VC = [[LoginViewController alloc] init];
//    VC.isComeFromeBaseTabbar = isFrom;
//    Navigation *nav = [[Navigation alloc]initWithRootViewController:VC];
//
//    [self presentViewController:nav animated:YES completion:nil];

    
}

/*
 Changing the delegate of a tab bar 【managed by a tab bar controller】 is not allowed.
 被UITabBarController所管理的UITabBar的delegate是不允许修改的
 */

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{

//    //
//    HomeVC *newVc = [[HomeVC alloc] init];
//    Navigation *nav = [[Navigation alloc] initWithRootViewController:newVc];
//    [self addChildViewController:nav];
    
    
    {
        
        UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        UIButton *leftBarBtn = [[UIButton alloc]init];
        leftBarBtn.backgroundColor = [UIColor redColor];
        //把自定义的button作为初始化的样式
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBarBtn];
        
        UIButton *rightBarBtn = [[UIButton alloc]init];
        rightBarBtn.backgroundColor = [UIColor redColor];
        //把自定义的button作为初始化的样式
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightBarBtn];
        
        pageController.navigationItem.leftBarButtonItem = item;
        pageController.navigationItem.rightBarButtonItem = item2;
        
        RKSwipeBetweenViewControllers *navigationController = [[RKSwipeBetweenViewControllers alloc]initWithRootViewController:pageController];
        
        //%%% DEMO CONTROLLERS
        HomeVC *weekClassTable = [[HomeVC alloc]init];
        CalendarClassTableVC *calendarClassTableVC = [[CalendarClassTableVC alloc]init];
        
        [navigationController.viewControllerArray addObjectsFromArray:@[weekClassTable,calendarClassTableVC]];
        navigationController.buttonText = @[@"本周课表",@"日历"];
        
        [self addChildViewController:navigationController];
    }
    
    
    
    {
        
        UIPageViewController *pageController1 = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        RKSwipeBetweenViewControllers *navigationController = [[RKSwipeBetweenViewControllers alloc]initWithRootViewController:pageController1];
        
        //%%% DEMO CONTROLLERS
        TeacherVC *teacher1 = [[TeacherVC alloc]init];
        TeacherVC *teacher2 = [[TeacherVC alloc]init];
        
        teacher1.type = allTimeTeacher;
        teacher2.type = partTimeTeacher;
   
        teacher2.view.backgroundColor = [UIColor whiteColor];
        [navigationController.viewControllerArray addObjectsFromArray:@[teacher1,teacher2]];
        navigationController.buttonText = @[@"全职老师",@"兼职老师"];
        
        [self addChildViewController:navigationController];
    }
    

    // 我
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MeVC *meVc = [storyBoard instantiateViewControllerWithIdentifier:@"MeVC_Id"];
    Navigation *nav4 = [[Navigation alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav4];
}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton
{
    
    // 0:nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"课表";
    nav.tabBarItem.image = [UIImage imageNamed:@"课表（选中）"];
    // 快速生成一个没有渲染图片
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"课表（选中）"];
    
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"老师";
    nav1.tabBarItem.image = [UIImage imageNamed:@"老师（未选择）"];
    // 快速生成一个没有渲染图片
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"老师（选择）"];
    
    
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[2];
    nav4.tabBarItem.title = @"设置";
    nav4.tabBarItem.image = [UIImage imageNamed:@"设置（未选择）"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"设置（选择）"];
}


//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//
//    for (UIView *view in self.view.subviews) {
//        if ([view isKindOfClass:[UITabBar class]]) {
//            //此处注意设置 y的值 不要使用屏幕高度 - 49 ，因为还有tabbar的高度 ，用当前tabbarController的View的高度 - 49即可
//            view.frame = CGRectMake(view.frame.origin.x, self.view.bounds.size.height-49, view.frame.size.width, 49);
//        }
//    }
//    // 此处是自定义的View的设置 如果使用了约束 可以不需要设置下面,_bottomView的frame
////    _bottomView.frame = self.tabBar.bounds;
//}

@end
