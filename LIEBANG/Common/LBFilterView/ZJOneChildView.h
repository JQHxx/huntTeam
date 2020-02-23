//
//  ZJOneChildView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/7.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */

#import <UIKit/UIKit.h>
#import "AllClassModel.h"

@protocol ZJOneChildViewDelegate <NSObject>

/**
 * 选中左边tableview cell的回调事件

 @param leftIndex 左边的索引
 @param rightIndex 右边的索引
 */
-(void)oneViewLeftTableviewDidSelectedWithLeftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;

/**
 * 选中右边tableview cell的回调事件
 
 @param leftIndex 左边的索引
 @param rightIndex 右边的索引
 */
-(void)oneViewRightTableviewDidSelectedWithLeftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;

@end


@interface ZJOneChildView : UIView

// 选中的cell
@property(nonatomic ,assign) NSInteger leftSeleIndex;
@property(nonatomic ,assign) NSInteger rightSeleIndex;


@property(nonatomic ,strong) NSArray        *leftDataArray;

@property(nonatomic ,strong) NSArray        *rightDataArray;

@property(nonatomic ,strong) UIView    *topView;

@property(nonatomic ,strong) UITableView    *leftTable;

@property(nonatomic ,strong) UITableView    *rightTable;

@property(nonatomic ,strong) AllClassModel  *classModel;
@property(nonatomic ,weak) id<ZJOneChildViewDelegate> delegate;

@end
