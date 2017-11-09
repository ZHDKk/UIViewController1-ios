//
//  ViewController.m
//  XML数据解析
//
//  Created by zh dk on 2017/8/29.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "NoteInfo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    _arrayData = [[NSMutableArray alloc] init];
    
    [self parseXML];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"ID";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    NoteInfo *nInfo = [_arrayData objectAtIndex:indexPath.row];
    cell.textLabel.text =nInfo.content;
    cell.detailTextLabel.text = nInfo.date;
    return cell;
}

-(void) parseXML
{
    //获取解析文件的全路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"txt"];
    //将xml读入内存中，，并且以二进制方式存储
    NSData *dataXML = [NSData dataWithContentsOfFile:path];
    
    //创建XML文档对象
    NSError *error = nil;
    GDataXMLDocument *docXML = [[GDataXMLDocument alloc] initWithData:dataXML options:0 error:&error];
    NSLog(@"error = %@",error);
    
    //获取根节点元素对象
    GDataXMLElement *elemRoot = [docXML rootElement];
    //搜索节点下面所有的UserID元素对象添加到数组中，返回到这个数组
    NSArray *arrayCount = [elemRoot elementsForName:@"count"];
     GDataXMLElement *elemCount = [arrayCount objectAtIndex:0];
    NSString *strCount = [elemCount stringValue];
        NSLog(@"count = %@",strCount);
    
    NSArray *arrayTotal = [elemRoot elementsForName:@"totalcount"];
    GDataXMLElement *elemTotal = [arrayTotal objectAtIndex:0];
    NSString *strTotal = [elemTotal stringValue];
    NSLog(@"totalcount = %@",strTotal);
    
    NSArray *arrayNotes = [elemRoot elementsForName:@"Notes"];
    GDataXMLElement *elemNoteList = [arrayNotes lastObject];
    NSArray *arrayNote = [elemNoteList elementsForName:@"Note"];
    for (int i=0; i<arrayNote.count; i++) {
        GDataXMLElement *elemNote = arrayNote[i];
        
        NSArray *arrayDate= [elemNote elementsForName:@"CDate"];
        GDataXMLElement *elemDate= [arrayDate lastObject];
        NSString *strDate = [elemDate stringValue];
        
        NSArray *arrayContent= [elemNote elementsForName:@"Content"];
        GDataXMLElement *elemContent= [arrayContent lastObject];
        NSString *strContent = [elemContent stringValue];
        
        NSArray *arrayUserID= [elemNote elementsForName:@"UserID"];
        GDataXMLElement *elemUserID= [arrayUserID lastObject];
        NSString *strUserID = [elemUserID stringValue];
        
        NSLog(@"Date = %@",strDate);
        
        NoteInfo *nInfo = [[NoteInfo alloc] init];
        nInfo.date = strDate;
        nInfo.content = strContent;
        nInfo.user = strUserID;
        [_arrayData addObject:nInfo];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
