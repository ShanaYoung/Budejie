//
//  SNConst.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/26.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SNTopicTypeAll = 1,
    SNTopicTypePicture = 10,
    SNTopicTypeWord = 29,
    SNTopicTypeVoice = 31,
    SNTopicTypeVideo = 41
} SNTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const SNTitlesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const SNTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const SNTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const SNTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const SNTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const SNTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度，就是用Break */
UIKIT_EXTERN CGFloat SNTopicCellPictureBreakH;

/** SNUser模型 - 性别属性值 */
UIKIT_EXTERN NSString *const SNUserSexMale;
UIKIT_EXTERN NSString *const SNUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const SNTopicCellTopCmtTitleH;
