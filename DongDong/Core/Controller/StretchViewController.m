//
//  StretchViewController.m
//  DongDong
//
//  Created by javalong on 16/7/26.
//  Copyright © 2016年 javalong. All rights reserved.
//

#import "StretchViewController.h"
#import "SelectedStretchChatViewController.h"
#import <HealthKit/HealthKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <CFNetwork/CFNetwork.h>

@interface StretchViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *_lm;
    CLGeocoder *_lg;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation StretchViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    _lm = [[CLLocationManager alloc] init];
    if ([_lm respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [_lm requestWhenInUseAuthorization];
    }
    _lm.delegate = self;//设置代理
    if ([CLLocationManager locationServicesEnabled])
    {
        [_lm startUpdatingLocation];//开启定位服务
    }
    [self textRequest];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (!locations.count) return;
    [manager stopUpdatingLocation];
    CLLocation *lo = locations.lastObject;
    if (!_lg)
    {
        _lg = [[CLGeocoder alloc] init];
    }
    __weak typeof (&*self)weakSelf = self;
    [_lg reverseGeocodeLocation:lo completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!placemarks.count) return ;
        CLPlacemark *lm = placemarks.lastObject;
        if (lm.locality.length)
        {
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:lm.locality style:UIBarButtonItemStylePlain target:nil action:nil];
            weakSelf.navigationItem.leftBarButtonItem = leftItem;
        }
    }];
}

- (void)queryStepCount
{
    if (![HKHealthStore isHealthDataAvailable])
    {
        NSLog(@"设备不支持healthKit"); return;
    }
    _healthStore = [[HKHealthStore alloc] init];
    HKObjectType *type1 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]; // 步数
    HKObjectType *type2 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning]; // 步行+跑步距离
    HKObjectType *type3 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];     // 已爬楼层
    HKObjectType *tyep4 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned]; // 活动能量
    HKObjectType *type5 = [HKObjectType activitySummaryType];// 健身记录
    // 会报错 'Authorization to read the following types is disallowed: HKCorrelationTypeIdentifierFood'
    // HKCorrelationTypeIdentifierFood 和 HKCorrelationTypeIdentifierBloodPressure  不允许读写
//    HKObjectType *type6 = [HKObjectType correlationTypeForIdentifier:HKCorrelationTypeIdentifierFood];
    
    HKObjectType *type8 = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex]; // 性别
    HKObjectType *type9 = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];//血型
    HKObjectType *type10 = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];//出生日期
    HKObjectType *type11 = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierFitzpatrickSkinType];//日光反应型皮肤类型
    
    HKObjectType *type12 = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];// 睡眠分析
//    HKObjectType *type12 = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierAppleStandHour]; // 站立小时
//    HKObjectType *type12 = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierCervicalMucusQuality]; // 宫颈粘液质量
//    HKObjectType *type12 = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierOvulationTestResult]; // 排卵测试结果
//    HKObjectType *type12 = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMenstrualFlow]; // 月经
//    HKObjectType *type12 = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierIntermenstrualBleeding];// 点滴出血
//    HKObjectType *type12 = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSexualActivity]; // 性行为
    NSSet *set = [NSSet setWithObjects:type1, type2, type3, tyep4, type5,type8,type9,type10,type11,type12, nil]; // 读集合
    
    
    HKSampleType *sType1 = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKCategoryType *sType2 = [HKCategoryType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    NSSet *sset = [NSSet setWithObjects:sType1, sType2, nil]; // 写集合
    
    __weak typeof (&*self) weakSelf = self;
    [_healthStore requestAuthorizationToShareTypes:sset readTypes:set completion:^(BOOL success, NSError * _Nullable error) {
        if (success)
        {
            [weakSelf readStepCount];
        } else
        {
            NSLog(@"healthkit不允许读写");
        }
    }];
}

//查询数据
- (void)readStepCount
{
    if ([UIDevice currentDevice].systemVersion.floatValue >=9.0)
    {
        NSLog(@"\n\n");
        NSLog(@"数据从这天%@才能读取", [_healthStore earliestPermittedSampleDate]);
    }
    NSError *error = nil;
    NSDate *b = [_healthStore dateOfBirthWithError:&error];
    if (!error) NSLog(@"出生日期=%@", b);
    else NSLog(@"出生日期error=%@", error);
    
    error = nil;
    HKBiologicalSexObject *s = [_healthStore biologicalSexWithError:&error];
    if (!error) {
        NSLog(@"性别=%@", @(s.biologicalSex));
    } else {
        NSLog(@"性别error=%@",error);
    }
    
    error = nil;
    HKBloodTypeObject *blood = [_healthStore bloodTypeWithError:&error];
    if (!error) {
        NSLog(@"血型=%@", @(blood.bloodType));
    } else {
        NSLog(@"血型error=%@",error);
    }
    
    error = nil;
    HKFitzpatrickSkinTypeObject *fitz = [_healthStore fitzpatrickSkinTypeWithError:&error];
    if (!error) {
        NSLog(@"日光反应型皮肤类型=%@", @(fitz.skinType));
    } else {
        NSLog(@"日光反应型皮肤类型error=%@",error);
    }
    
    
    // 睡眠分析
//    HKCategoryType *categoryType = [HKCategoryType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
//    HKDevice *device = [[HKDevice alloc] initWithName:@"文能设备" manufacturer:@"中国制造商" model:@"智能机" hardwareVersion:@"1.0.0" firmwareVersion:@"1.0.0" softwareVersion:@"1.0.0" localIdentifier:@"lizaochengwen" UDIDeviceIdentifier:@"wennengshebei"];
//    HKCategorySample *testObject = [HKCategorySample categorySampleWithType:categoryType value:0.25 startDate:[NSDate dateWithTimeIntervalSinceNow:-(24 * 3600)] endDate:[NSDate date] device:device metadata:nil];
//    [_healthStore saveObject:testObject withCompletion:^(BOOL success, NSError * _Nullable error) {
//        if (success) {
//            NSLog(@"文能设备，收集的睡眠记录保存成功");
//        } else
//        {
//             NSLog(@"文能设备，收集的睡眠记录保存失败 %@", error);
//        }
//    }];
    
//    NSMutableArray *list= [[NSMutableArray alloc] init];
//    for (float i = 1; i < 100; i++) {
//        HKCategorySample *testObject = [HKCategorySample categorySampleWithType:categoryType value:i/100.0 startDate:[NSDate dateWithTimeIntervalSinceNow:-(24 * 3600/i)] endDate:[NSDate date] device:device metadata:nil];
//        [list addObject:testObject];
//    }
//    [_healthStore saveObjects:list withCompletion:^(BOOL success, NSError * _Nullable error) {
//        if (success) {
//            NSLog(@"文能设备，收集的睡眠记录保存成功");
//        } else
//        {
//            NSLog(@"文能设备，收集的睡眠记录保存失败 %@", error);
//        }
//    }];
    
//    NSSet *dSet= [[NSSet alloc] initWithObjects:@"文能设备", nil];
//    NSPredicate *catePredicate = [HKQuery predicateForObjectsWithDeviceProperty:HKDevicePropertyKeyName allowedValues:dSet];
//    [_healthStore deleteObjectsOfType:categoryType predicate:catePredicate withCompletion:^(BOOL success, NSUInteger deletedObjectCount, NSError * _Nullable error) {
//        if (success) {
//            NSLog(@"文能设备，收集的睡眠记录删除成功 %@", @(deletedObjectCount));
//        } else
//        {
//            NSLog(@"文能设备，收集的睡眠记录删除失败 %@", error);
//        }
//    }];
    
    //查询采样信息
    HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    //NSSortDescriptors用来告诉healthStore怎么样将结果排序。
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end   = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    /*查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标，这里我们需要查询的步数是一个
     HKSample类所以对应的查询类就是HKSampleQuery。
     下面的limit参数传1表示查询最近一条数据,查询多条数据只要设置limit的参数值就可以了
     */
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateCom = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    
    NSDate *startDate, *endDate;
    endDate = [calendar dateFromComponents:dateCom];
    
    [dateCom setHour:0];
    [dateCom setMinute:0];
    [dateCom setSecond:0];
    
    startDate = [calendar dateFromComponents:dateCom];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    __weak typeof (&*_healthStore)weakHealthStore = _healthStore;
    
    HKSampleQuery *q1 = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        double sum = 0;
        double sumTime = 0;
        NSLog(@"步数结果=%@", results);
        for (HKQuantitySample *res in results)
        {
            
            sum += [res.quantity doubleValueForUnit:[HKUnit countUnit]];
            
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate:res.endDate];
            
            NSDate *startDate = [res.startDate dateByAddingTimeInterval:interval];
            NSDate *endDate   = [res.endDate dateByAddingTimeInterval:interval];

            sumTime += [endDate timeIntervalSinceDate:startDate];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //查询是在多线程中进行的，如果要对UI进行刷新，要回到主线程中
                self.title = [NSString stringWithFormat:@"运动步数：%@", @(sum).stringValue];
            }];
        }
        int h = sumTime / 3600;
        int m = ((long)sumTime % 3600)/60;
        NSLog(@"运动时长：%@小时%@分", @(h), @(m));
        NSLog(@"运动步数：%@步", @(sum));
        if(error) NSLog(@"1error==%@", error);
        [weakHealthStore stopQuery:query];
        NSLog(@"\n\n");
    }];
    
    HKSampleType *timeSampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKSampleQuery *q2 = [[HKSampleQuery alloc] initWithSampleType:timeSampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        double time = 0;
        for (HKQuantitySample *res in results)
        {
            time += [res.quantity doubleValueForUnit:[HKUnit meterUnit]];
        }
        NSLog(@"运动距离===%@米", @((long)time));
        if(error) NSLog(@"2error==%@", error);
        [weakHealthStore stopQuery:query];
    }];
    
    HKSampleType *type3 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    HKSampleQuery *q3 = [[HKSampleQuery alloc] initWithSampleType:type3 predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        double num = 0;
        for (HKQuantitySample *res in results)
        {
            num += [res.quantity doubleValueForUnit:[HKUnit countUnit]];
        }
        NSLog(@"楼层===%@层", @(num));
        if(error) NSLog(@"3error==%@", error);
        [weakHealthStore stopQuery:query];
    }];

    HKSampleType *type4 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKSampleQuery *q4 = [[HKSampleQuery alloc] initWithSampleType:type4 predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        double num = 0;
        for (HKQuantitySample *res in results)
        {
            num += [res.quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
        }
        NSLog(@"卡路里===%@大卡", @((long)num));
        if(error) NSLog(@"4error==%@", error);
        [weakHealthStore stopQuery:query];
        NSLog(@"\n\n");
    }];
    
    NSDateComponents *dateCom5B = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    [dateCom5B setDay:(dateCom5B.day - 10)];
    dateCom5B.calendar = calendar;
    NSDateComponents *dateCom5E = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    dateCom5E.calendar = calendar;
    NSPredicate *predicate5 = [HKActivitySummaryQuery predicateForActivitySummaryWithDateComponents:dateCom5B];
//    NSPredicate *predicate5 = [HKActivitySummaryQuery predicateForActivitySummariesBetweenStartDateComponents:dateCom5B endDateComponents:dateCom5E];
    HKActivitySummaryQuery *q5 = [[HKActivitySummaryQuery alloc] initWithPredicate:predicate5 resultsHandler:^(HKActivitySummaryQuery * _Nonnull query, NSArray<HKActivitySummary *> * _Nullable activitySummaries, NSError * _Nullable error) {
        double energyNum       = 0;
        double exerciseNum     = 0;
        double standNum        = 0;
        double energyGoalNum   = 0;
        double exerciseGoalNum = 0;
        double standGoalNum    = 0;
        for (HKActivitySummary *summary in activitySummaries)
        {
            energyNum       += [summary.activeEnergyBurned doubleValueForUnit:[HKUnit kilocalorieUnit]];
            exerciseNum     += [summary.appleExerciseTime doubleValueForUnit:[HKUnit secondUnit]];
            standNum        += [summary.appleStandHours doubleValueForUnit:[HKUnit countUnit]];
            energyGoalNum   += [summary.activeEnergyBurnedGoal doubleValueForUnit:[HKUnit kilocalorieUnit]];
            exerciseGoalNum += [summary.appleExerciseTimeGoal doubleValueForUnit:[HKUnit secondUnit]];
            standGoalNum    += [summary.appleStandHoursGoal doubleValueForUnit:[HKUnit countUnit]];
        }
        NSLog(@"\n\n");
        NSLog(@"健身记录：energyNum=%@",       @(energyNum));
        NSLog(@"健身记录：exerciseNum=%@",     @(exerciseNum));
        NSLog(@"健身记录：standNum=%@",        @(standNum));
        NSLog(@"健身记录：energyGoalNum=%@",   @(energyGoalNum));
        NSLog(@"健身记录：exerciseGoalNum=%@", @(exerciseGoalNum));
        NSLog(@"健身记录：standGoalNum=%@",    @(standGoalNum));
        if(error) NSLog(@"5error==%@", error);
        [weakHealthStore stopQuery:query];
        NSLog(@"\n\n");
    }];
    
//    HKQueryAnchor *anchor = [HKQueryAnchor anchorFromValue:HKAnchoredObjectQueryNoAnchor];
     // 从锚点为0处开始查询符合条件的所有记录
    HKAnchoredObjectQuery *q6 = [[HKAnchoredObjectQuery alloc] initWithType:sampleType predicate:predicate anchor:HKAnchoredObjectQueryNoAnchor limit:HKObjectQueryNoLimit completionHandler:^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSUInteger newAnchor, NSError * _Nullable error) {
        double sum = 0;
//        NSLog(@"results==%@", results);
        for (HKQuantitySample *res in results)
        {
            sum += [res.quantity doubleValueForUnit:[HKUnit countUnit]];
        }
        NSLog(@"Anchor%@查询步数=%@步", @(newAnchor), @(sum));
    }];
    // 从锚点为0处开始查询符合条件的一条记录，查询结果得到的锚点是12160
    HKAnchoredObjectQuery *q7 = [[HKAnchoredObjectQuery alloc] initWithType:sampleType predicate:predicate anchor:HKAnchoredObjectQueryNoAnchor limit:1 completionHandler:^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSUInteger newAnchor, NSError * _Nullable error) {
        double sum = 0;
//        NSLog(@"results==%@", results);
        for (HKQuantitySample *res in results)
        {
            sum += [res.quantity doubleValueForUnit:[HKUnit countUnit]];
        }
        NSLog(@"Anchor%@查询步数=%@步", @(newAnchor), @(sum));
    }];
    // 从锚点12160处开始查询符合条件的一条记录，锚点起到分页查询的作用
    HKAnchoredObjectQuery *q8 = [[HKAnchoredObjectQuery alloc] initWithType:sampleType predicate:predicate anchor:12160 limit:1 completionHandler:^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSUInteger newAnchor, NSError * _Nullable error) {
        double sum = 0;
//        NSLog(@"results==%@", results);
        for (HKQuantitySample *res in results)
        {
            sum += [res.quantity doubleValueForUnit:[HKUnit countUnit]];
            NSLog(@"device name:%@", res.device.name);
            NSLog(@"device manufacturer:%@", res.device.manufacturer);
            NSLog(@"device hardwareVersion:%@", res.device.hardwareVersion);
            NSLog(@"device firmwareVersion:%@", res.device.firmwareVersion);
            NSLog(@"device softwareVersion:%@", res.device.softwareVersion);
            NSLog(@"device localIdentifier:%@", res.device.localIdentifier);
            NSLog(@"device UDIDeviceIdentifier:%@", res.device.UDIDeviceIdentifier);
            
            NSLog(@"uuid:%@", res.UUID);
            
            HKSource *source = nil;
            if ([UIDevice currentDevice].systemVersion.floatValue >= 8)
            {
                source = res.sourceRevision.source;
                NSLog(@"source version:%@", res.sourceRevision.version);
            } else
            {
                source = res.source;
            }
            
            NSLog(@"source:%@", source.name);
            NSLog(@"source:%@", source.bundleIdentifier);
            
            NSLog(@"metadata:%@", res.metadata);
        }
        NSLog(@"Anchor%@查询步数=%@步", @(newAnchor), @(sum));
    }];
    
    // 统计分析
    sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    NSUInteger op = HKStatisticsOptionCumulativeSum;//(HKStatisticsOptionDiscreteAverage | HKStatisticsOptionDiscreteMin | HKStatisticsOptionDiscreteMax |HKStatisticsOptionCumulativeSum);
//    HKStatisticsQuery *q9 = [[HKStatisticsQuery alloc] initWithQuantityType:sampleType quantitySamplePredicate:predicate options:op completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
//        NSLog(@"\n\n");
//        if (error)
//        {
//            NSLog(@"统计出错 %@", error);
//            return;
//        }
//        double sum1 = [result.averageQuantity doubleValueForUnit:[HKUnit countUnit]];
//        double sum2 = [result.minimumQuantity doubleValueForUnit:[HKUnit countUnit]];
//        double sum3 = [result.maximumQuantity doubleValueForUnit:[HKUnit countUnit]];
//        double sum4 = [result.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
//        NSLog(@"统计平均步数=%@步", @(sum1));
//        NSLog(@"统计最小步数=%@步", @(sum2));
//        NSLog(@"统计最大步数=%@步", @(sum3));
//        NSLog(@"统计步数=%@步", @(sum4));
//        NSLog(@"\n\n");
//    }];
    
    // 间隔一小时统计一次
    NSDateComponents *hComponents = [calendar components:NSCalendarUnitHour fromDate:[NSDate date]];
    [hComponents setHour:1];
    HKStatisticsCollectionQuery *q10  =[[HKStatisticsCollectionQuery alloc] initWithQuantityType:sampleType quantitySamplePredicate:predicate options:op anchorDate:startDate intervalComponents:hComponents];
    q10.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection * __nullable result, NSError * __nullable error) {
        if (error)
        {
            NSLog(@"统计init出错 %@", error);
            return;
        }
        for (HKStatistics *s in result.statistics)
        {
            double sum1 = [s.averageQuantity doubleValueForUnit:[HKUnit countUnit]];
            double sum2 = [s.minimumQuantity doubleValueForUnit:[HKUnit countUnit]];
            double sum3 = [s.maximumQuantity doubleValueForUnit:[HKUnit countUnit]];
            double sum4 = [s.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
            NSLog(@"init统计平均步数=%@步", @(sum1));
            NSLog(@"init统计最小步数=%@步", @(sum2));
            NSLog(@"init统计最大步数=%@步", @(sum3));
            NSLog(@"init统计步数=%@步", @(sum4));
        }
    };
    q10.statisticsUpdateHandler = ^(HKStatisticsCollectionQuery *query, HKStatistics * __nullable statistics, HKStatisticsCollection * __nullable collection, NSError * __nullable error) {
        if (error)
        {
            NSLog(@"统计update出错 %@", error);
            return;
        }
        for (HKStatistics *result in collection.statistics)
        {
            double sum1 = [result.averageQuantity doubleValueForUnit:[HKUnit countUnit]];
            double sum2 = [result.minimumQuantity doubleValueForUnit:[HKUnit countUnit]];
            double sum3 = [result.maximumQuantity doubleValueForUnit:[HKUnit countUnit]];
            double sum4 = [result.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
            NSLog(@"update统计平均步数=%@步", @(sum1));
            NSLog(@"update统计最小步数=%@步", @(sum2));
            NSLog(@"update统计最大步数=%@步", @(sum3));
            NSLog(@"update统计步数=%@步", @(sum4));
        }
    };
    
    //执行查询
    [_healthStore executeQuery:q1];
    [_healthStore executeQuery:q2];
    [_healthStore executeQuery:q3];
    [_healthStore executeQuery:q4];
    [_healthStore executeQuery:q5];
    [_healthStore executeQuery:q6];
    [_healthStore executeQuery:q7];
    [_healthStore executeQuery:q8];
//    [_healthStore executeQuery:q9];
    [_healthStore executeQuery:q10];
}

// 运动与健身
- (void)motion
{
    if ([CMMotionActivityManager isActivityAvailable])
    {
        CMMotionActivityManager *motionActivityManager = [[CMMotionActivityManager alloc]init];
        
        [motionActivityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity *activity) {
            
            NSLog(@"confidence=%@  unknown=%@   walking=%@  stationary=%@  running=%@   cycling=%@  automotive=%@  startDate==%@", @(activity.confidence), @(activity.unknown), @(activity.walking), @(activity.stationary), @(activity.running), @(activity.cycling), @(activity.automotive), activity.startDate);
        }];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *dateCom = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
        
        NSDate *endDate = [calendar dateFromComponents:dateCom];
        
        [dateCom setHour:0];
        [dateCom setMinute:0];
        [dateCom setSecond:0];
        
        NSDate *startDate = [calendar dateFromComponents:dateCom];
        [motionActivityManager queryActivityStartingFromDate:startDate toDate:endDate toQueue:[NSOperationQueue mainQueue] withHandler:^(NSArray<CMMotionActivity *> * _Nullable activities, NSError * _Nullable error) {
            for (CMMotionActivity *activity in activities)
            {
                NSLog(@"query confidence=%@  unknown=%@   walking=%@  stationary=%@  running=%@   cycling=%@  automotive=%@  startDate==%@", @(activity.confidence), @(activity.unknown), @(activity.walking), @(activity.stationary), @(activity.running), @(activity.cycling), @(activity.automotive), activity.startDate);
            }
        }];
         
        [motionActivityManager stopActivityUpdates];
        
    } else
    {
        NSLog(@"运动与健身 不可用");
    }
}

- (IBAction)addStretchAction:(id)sender
{
    SelectedStretchChatViewController * chat = [[SelectedStretchChatViewController alloc] init];
    [self.navigationController pushViewController:chat animated:YES];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tempID = @"Stretch";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tempID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tempID];
    }
    
    cell.detailTextLabel.text = @"开始动一动吧";
    cell.textLabel.text = @"日常运动";
    cell.imageView.image = [UIImage imageNamed:@"first"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self queryStepCount];
    
    NSDictionary *dic = (__bridge NSDictionary *)CFNetworkCopySystemProxySettings();
    NSLog(@"===dic===%@", dic);
    
    TestViewController *test = [[TestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}


+(int)getMaxNumber:(int)a b:(int)b c:(int)c
{
    if(a > b){
        if(a > c){
            return a;
        }else{
            return c;
        }
    }else{
        if(b > c){
            return b;
        }else{
            return c;
        }
    }
}

- (void)textRequest
{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"foo": @"bar"};
//    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
//    [manager POST:@"http://example.com/resources.json" parameters:parameters constructingBodyWithBlock:^(id<</b>AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Success: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
    [self testDownload];
}

- (void)testDownload
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSLog(@"url==%@", documentsDirectoryURL);
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

- (void)testUpload
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [[bundle resourcePath] stringByAppendingPathComponent:@"DongDong.entitlements"];
    NSURL *filePath = [NSURL fileURLWithPath:path];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

@end
