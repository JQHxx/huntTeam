//
//  HomeMeetCell.m
//  LIEBANG
//
//  Created by  YIQI on 2018/7/6.
//  Copyright © 2018年  YIQI. All rights reserved.
//

#import "ThemeListMeetCell.h"
#import "StarView.h"
#import "OrderStatusView.h"

@interface ThemeListMeetCell ()

@property (nonatomic,strong)NameLabel *nameLabel;
@property (nonatomic,strong)PostionLabel *personLabel;
@property (nonatomic,strong)UIButton *numberLabel;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *messageLabel;
@property (nonatomic,strong)PriceLabel *priceLabel;
@property (nonatomic,strong)UIButton *typeLabel;
@property (nonatomic,strong)StarView *starView;
@property (nonatomic,strong)UIButton *timeLabel;
@property (nonatomic,strong)OrderStatusView *statusView;


@property (nonatomic,strong)UIButton *editButton;
@property (nonatomic,strong)UIButton *confimButton;

@end


@implementation ThemeListMeetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createSubViews];
        
    }
    return self;
}

- (void)setThemeClassModel:(ThemeClassModel *)themeClassModel {//推荐话题
    _themeClassModel = themeClassModel;
    
    _nameLabel.userUid = themeClassModel.userUid;
    _personLabel.userUid = themeClassModel.userUid;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:themeClassModel.userHead] placeholderImage:[UIImage imageNamed:@"no_headIcon"]];
    [_nameLabel setNameString:themeClassModel.userName showIcon:themeClassModel.isBasic];
    NSString *help = [NSString stringWithFormat:@"帮助过%d人",[themeClassModel.map_helpNum intValue]];
    CGFloat helpw = BoundWithSize(help, kDeviceWidth, 11).size.width + 20;
    [_numberLabel setTitle:help forState:UIControlStateNormal];
    _numberLabel.width = helpw;
    if (IsStrEmpty(themeClassModel.position))
    {
        _personLabel.hidden = YES;
    }
    else
    {
        _personLabel.hidden = NO;
        NSString *name = [NSString stringWithFormat:@" |  %@%@",themeClassModel.company,themeClassModel.position];
        CGSize size = BoundWithSize(name, kDeviceWidth, 13).size;
        
        NSString *userName = themeClassModel.userName;
        CGFloat nameW = BoundWithSize(userName, kDeviceWidth, 13).size.width;
        if ([themeClassModel.isBasic isEqualToString:@"0"]) {
            _nameLabel.width = nameW - 20;
        }else{
            _nameLabel.width = nameW - 8;
        }
        [_personLabel setCompany:@"" postion:name showIcon:themeClassModel.isOccupationOne];
        CGFloat pW = BoundWithSize(name, kDeviceWidth, 13).size.width;

        if (pW > kDeviceWidth-_nameLabel.width - _iconImageView.width -kCurrentWidth(12)) {
            _personLabel.width = kDeviceWidth-_nameLabel.width - _iconImageView.width - kCurrentWidth(30);
        }else{
            if ([themeClassModel.isOccupationOne isEqualToString:@"0"]) {
                _personLabel.labelWidth = size.width + 20;

            }else{
                _personLabel.width = size.width + 44;
            }
        }
        _personLabel.left = _nameLabel.right+kCurrentWidth(10)+15;
    }
    
    _starView.score = [themeClassModel.startLevel floatValue];
    [_priceLabel setUsePrice:themeClassModel.topicPrice oldPrice:themeClassModel.originalPrice];
    
    _messageLabel.text = themeClassModel.topicName;
    [_timeLabel setTitle:[NSString stringWithFormat:@"%@小时/次",themeClassModel.serviceTime] forState:UIControlStateNormal];
    _timeLabel.left = _numberLabel.right + 5;
    _timeLabel.centerY = _timeLabel.centerY;
    
    
    if ([themeClassModel.serviceType isEqualToString:@"0"])
    {
        [_typeLabel setTitle:@"线下约见" forState:UIControlStateNormal];
        [_typeLabel setBackgroundImage:[UIImage imageNamed:@"list_button_xianxia"] forState:UIControlStateNormal];
    }
    else if ([themeClassModel.serviceType isEqualToString:@"1"])
    {
        [_typeLabel setTitle:@"全国通话" forState:UIControlStateNormal];
        [_typeLabel setBackgroundImage:[UIImage imageNamed:@"list_button_quanguo"] forState:UIControlStateNormal];
    }
    
//    if (self.homeMeetCellState == HomeMeetCellStateAccount)
//    {
//        _nameLabel.hidden = NO;
//        CGSize size = [themeClassModel.topicName sizeWithFont:kSystem(15) maxSize:CGSizeMake(kDeviceWidth-kCurrentWidth(20), MAXFLOAT)];
//        _messageLabel.height = size.height;
//    }
//    else
//    {
//        CGSize size = [themeClassModel.topicName sizeWithFont:kSystem(15) maxSize:CGSizeMake(kDeviceWidth-kCurrentWidth(80), kCurrentWidth(65))];
//        _messageLabel.height = size.height;
//    }
    
    _nameLabel.top = _messageLabel.bottom+kCurrentWidth(4);
    _personLabel.top = _nameLabel.top;

    _numberLabel.top = _nameLabel.bottom+kCurrentWidth(4);
//    _timeLabel.top = _nameLabel.bottom+kCurrentWidth(4);
    _timeLabel.centerY = _numberLabel.centerY;
    _priceLabel.top = _numberLabel.bottom+ kCurrentWidth(4);
    _starView.top = _numberLabel.bottom+ kCurrentWidth(4);
    self.height = _starView.bottom + kCurrentWidth(15);
    _iconImageView.centerY = self.height/2;
}

- (CGFloat)cellHeight {
    return self.height;
}

- (void)enterAccountEvent {
    if (_accountButtonBlock) {
        _accountButtonBlock();
    }
}

#pragma mark 界面布局
- (void)createSubViews {
 
    _typeLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeLabel.frame = CGRectMake(kDeviceWidth-kCurrentWidth(72), 0, kCurrentWidth(60), kCurrentWidth(19));
    [_typeLabel setBackgroundImage:[UIImage imageNamed:@"list_button_xianxia"] forState:UIControlStateNormal];
    [_typeLabel setTitle:@"线下约见" forState:UIControlStateNormal];
    [_typeLabel setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _typeLabel.titleLabel.font = kSystem(12);
    _typeLabel.adjustsImageWhenHighlighted = NO;
    [self addSubview:_typeLabel];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kCurrentWidth(12), kCurrentWidth(36), kCurrentWidth(45), kCurrentWidth(45))];
    _iconImageView.image = [UIImage imageNamed:@"no_headIcon"];
    _iconImageView.layer.cornerRadius = kCurrentWidth(45)/2;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.userInteractionEnabled = YES;
    [_iconImageView setContentScaleFactor:[[UIScreen mainScreen]scale]];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.autoresizingMask = UIViewAutoresizingNone;
    [self addSubview:_iconImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAccountEvent)];
    [_iconImageView addGestureRecognizer:tap];
    
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right+kCurrentWidth(10), kCurrentWidth(2) + _typeLabel.bottom, kDeviceWidth-kCurrentWidth(80), kCurrentWidth(20))];
    _messageLabel.text = @"讲一讲生产型企业IT信息安全优化";
    _messageLabel.font = kSystem(15);
    _messageLabel.textColor = kLBBlackColor;
    _messageLabel.numberOfLines = 3;
    [self addSubview:_messageLabel];
    
    WeakSelf;
    _nameLabel = [[NameLabel alloc] initWithFrame:CGRectMake(_iconImageView.right+kCurrentWidth(10), kCurrentWidth(47), kCurrentWidth(50), kCurrentWidth(13))];
    [_nameLabel setNameString:@"猎帮" showIcon:@"0"];
    _nameLabel.labelFont = kSystem(13);
    _nameLabel.GetBasicCertiImageViewBlock = ^(NSString *imageUrl) {
        if (weakSelf.GetBasicSourceBlock) {
            weakSelf.GetBasicSourceBlock(imageUrl);
        }
    };
    [self addSubview:_nameLabel];
    
    _personLabel = [[PostionLabel alloc] initWithFrame:CGRectMake(_nameLabel.right+kCurrentWidth(12)+15, _nameLabel.top, kCurrentWidth(150), kCurrentWidth(13))];
    _personLabel.font = kSystem(13);
    _personLabel.color = kLBSixColor;
    _personLabel.GetWorkCertiImageViewBlock = ^(NSString *imageUrl) {
        if (weakSelf.GetWorkSourceBlock) {
            weakSelf.GetWorkSourceBlock(imageUrl);
        }
    };
    [self addSubview:_personLabel];
    
    _numberLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    _numberLabel.frame = CGRectMake(_iconImageView.right+kCurrentWidth(10), _nameLabel.bottom,75, kCurrentWidth(20));
    _numberLabel.adjustsImageWhenHighlighted = NO;
    [_numberLabel setTitleColor:kLBNineColor forState:UIControlStateNormal];
    [_numberLabel setTitle:@"帮助过0人" forState:UIControlStateNormal];
    [_numberLabel setImage:[UIImage imageNamed:@"list_icon_user"] forState:UIControlStateNormal];
    _numberLabel.titleLabel.font = kSystem(11);
    _numberLabel.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    _numberLabel.titleEdgeInsets = UIEdgeInsetsMake(0, kCurrentWidth(6), 0, 0);
    [self addSubview:_numberLabel];
    [_numberLabel sizeToFit];
    
    _timeLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeLabel.frame = CGRectMake(_numberLabel.right+kCurrentWidth(0), _numberLabel.top, 75, kCurrentWidth(20));
    _timeLabel.adjustsImageWhenHighlighted = NO;
    [_timeLabel setTitleColor:kLBNineColor forState:UIControlStateNormal];
    [_timeLabel setTitle:@"1小时/次" forState:UIControlStateNormal];
    [_timeLabel setImage:[UIImage imageNamed:@"list_icon_zhong"] forState:UIControlStateNormal];
    _timeLabel.titleLabel.font = kSystem(11);
    _timeLabel.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    _timeLabel.titleEdgeInsets = UIEdgeInsetsMake(0, kCurrentWidth(5), 0, 0);
    [self addSubview:_timeLabel];

    _priceLabel = [[PriceLabel alloc] initWithFrame:CGRectMake(kDeviceWidth-kCurrentWidth(113), _numberLabel.bottom, kCurrentWidth(100), kCurrentWidth(14))];
    _priceLabel.priceTextAlignment = NSTextAlignmentRight;
    [self addSubview:_priceLabel];
    
    _starView = [[StarView alloc] initWithFrame:CGRectMake(_iconImageView.right+kCurrentWidth(10), _numberLabel.bottom, kCurrentWidth(78), kCurrentWidth(10))];
    _starView.score = 4.5f;
    [self addSubview:_starView];
    
    _confimButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confimButton.frame = CGRectMake(kDeviceWidth-kCurrentWidth(56), kCurrentWidth(10), kCurrentWidth(44), kCurrentWidth(20));
    [_confimButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_confimButton setTitleColor:kLBRedColor forState:UIControlStateNormal];
    _confimButton.layer.cornerRadius = kCurrentWidth(10);
    _confimButton.layer.borderColor = kLBRedColor.CGColor;
    _confimButton.layer.borderWidth = 0.5;
    _confimButton.layer.masksToBounds = YES;
    _confimButton.titleLabel.font = kSystem(13);
    _confimButton.hidden = YES;
    [_confimButton addTarget:self action:@selector(confimButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_confimButton];
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _editButton.frame = CGRectMake(_confimButton.left-kCurrentWidth(54), kCurrentWidth(10), kCurrentWidth(44), kCurrentWidth(20));
    [_editButton setTitle:@"删除" forState:UIControlStateNormal];
    [_editButton setTitleColor:kLBRedColor forState:UIControlStateNormal];
    _editButton.layer.cornerRadius = kCurrentWidth(10);
    _editButton.layer.borderColor = kLBRedColor.CGColor;
    _editButton.layer.borderWidth = 0.5;
    _editButton.layer.masksToBounds = YES;
    _editButton.titleLabel.font = kSystem(13);
    _editButton.hidden = YES;
    [_editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_editButton];
    
}

- (OrderStatusView *)statusView {
    if (!_statusView) {
        _statusView = [[OrderStatusView alloc] initWithFrame:CGRectMake(0, _starView.bottom + kCurrentWidth(15), kDeviceWidth, kCurrentWidth(38))];
    }
    return _statusView;
}

#pragma mark Event
- (void)confimButtonClick {
    if (_confimButtonBlock) {
        _confimButtonBlock(self.themeClassModel);
    }
}

- (void)editButtonClick {
    if (_deleteButtonBlock) {
        _deleteButtonBlock(self.themeClassModel);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
