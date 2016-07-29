//
//  StretchMessage+CoreDataProperties.h
//  DongDong
//
//  Created by javalong on 16/7/27.
//  Copyright © 2016年 javalong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "StretchMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface StretchMessage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSDate *beginTime;
@property (nullable, nonatomic, retain) NSDate *endTime;
@property (nullable, nonatomic, retain) NSNumber *stepNum;
@property (nullable, nonatomic, retain) NSString *bgIcon;
@property (nullable, nonatomic, retain) StretchChat *chat;

@end

NS_ASSUME_NONNULL_END
