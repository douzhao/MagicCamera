//
//  ViewController.m
//  MagicCamera
//
//  Created by SongWentong on 2/15/16.
//  Copyright © 2016 SongWentong. All rights reserved.
//

#import "ViewController.h"
#import "EditImageViewController.h"
#import "FrameViewController.h"
@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

-(NSArray<NSString*>*)avalibleEffect
{
    return @[@"增强",@"滤镜",@"马赛克",@"边框"];
}

-(NSArray<NSString*>*)avalibleSegues
{
    return @[@"enhance",@"filter",@"mosaic",@"frame"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender
{
    UIViewController *vc = segue.destinationViewController;
    if ([vc isKindOfClass:[EditImageViewController class]]) {
        EditImageViewController *temp = (EditImageViewController*)vc;
        temp.originalImage = sender;
    }
    if ([vc isKindOfClass:[FrameViewController class]]) {
        FrameViewController *temp = (FrameViewController*)vc;
        temp.originalImage = sender;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
        NSArray *avalibleSegues = [self avalibleSegues];
        NSString *segue = avalibleSegues[_tableView.indexPathForSelectedRow.row];
        [self performSegueWithIdentifier:segue sender:image];
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self avalibleEffect].count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self avalibleEffect][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pickPhoto];
}





@end
