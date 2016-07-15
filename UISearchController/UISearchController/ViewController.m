//
//  ViewController.m
//  UISearchController
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate,UISearchControllerDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
@property (strong,nonatomic) NSMutableArray  *dataList;

@property (strong,nonatomic) NSMutableArray  *searchList;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation ViewController


-(UITableView*)tableView
{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    self.dataList=[NSMutableArray arrayWithCapacity:100];
    
    for (NSInteger i=0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld-FlyElephant",(long)i]];
    }
#pragma mark 懒加载就不需要这个啦。。。。
    //[self tableView];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    
    //是否设置蒙层
   // _searchController.dimsBackgroundDuringPresentation = YES;
    //搜索时，背景变模糊
    _searchController.obscuresBackgroundDuringPresentation = YES;
    
    
#pragma mark 看到的时候还觉得奇怪，，果然就崩溃了。。我这个demo里边没创建导航，，崩溃还没有原因。。。不过真的是一眼望穿！看来水平还是得到提高了的。。
    //隐藏导航栏
   // _searchController.hidesNavigationBarDuringPresentation = NO;
    
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
}
//设置区域
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.searchList count];
    }else{
        return [self.dataList count];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    
    //cell.detailTextLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    
    
    //刷新表格
    [self.tableView reloadData];
}

#pragma mark 自己试试看，想想吧，之前晨阳说的时候是直接创建两个控制器的，搜索结果的表的展示数据的表不在同一个控制器里边，现在是在同一个控制器里边的，那么表的协议方法就一套，所以就要求考虑和区分好点击单元格的时候是哪一个的if (self.searchController.active) {}else{}. 现在试试看，输出nslog就可以，只要知道可以行得通了，那就好办了，就可以根据单元格来选择做什么了，还有一个，一般来说，功能都是这样的，看起来就是在导航上的，然后点击那个搜索，就跳转到搜索界面，应该是push效果的，应该是点击那个看起来像搜索框的输入框，其实就是按钮？还是上边那个updateSearchResultsForSearchController:(UISearchController *)searchController方法里边，先实现跳转？ ，应该不是这个方法的，，，试试看一会，，还有就是，点击这个得到点击那个单元格后，一般都是根据得到的单元格上的数据或者搜索框里边的数据，来进行请求得到数据！！！！！应该是给了个URL接口的，，然后拼接，，然后请求，，如果只是产品，也就是就自己的服务器内部的数据，，那请求更加狭窄！！，，一会可以试试来个百度的拼接试试，，，

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.searchController.active) {
        
        
      
    }else{
        
        
        
    }

    
}



@end
