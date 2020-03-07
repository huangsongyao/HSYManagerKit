//
//  UITableView+Operations.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import "UITableView+Operations.h"

@implementation UITableView (Operations)

- (void)hsy_firstInsertSectionRow
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)hsy_firstDeleteSectionRow
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)hsy_insertSection:(NSInteger)rows
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rows inSection:0];
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)hsy_deleteSection:(NSInteger)rows
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rows inSection:0];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}


@end
