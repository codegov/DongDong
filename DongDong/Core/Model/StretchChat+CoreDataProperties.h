//
//  StretchChat+CoreDataProperties.h
//  DongDong
//
//  Created by javalong on 16/7/27.
//  Copyright © 2016年 javalong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "StretchChat.h"

NS_ASSUME_NONNULL_BEGIN

@interface StretchChat (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *subtitle;
@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSString *preMsgTime;
@property (nullable, nonatomic, retain) NSSet<StretchMessage *> *messageList;

@end

@interface StretchChat (CoreDataGeneratedAccessors)

- (void)addMessageListObject:(StretchMessage *)value;
- (void)removeMessageListObject:(StretchMessage *)value;
- (void)addMessageList:(NSSet<StretchMessage *> *)values;
- (void)removeMessageList:(NSSet<StretchMessage *> *)values;

@end

NS_ASSUME_NONNULL_END
