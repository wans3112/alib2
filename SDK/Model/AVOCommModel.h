//
//  AVOCommModel.h
//  Avolo
//
//  Created by Zhengji Tao on 11/30/13.
//  Copyright (c) 2013 wans. All rights reserved.
//

#import <Foundation/Foundation.h>

enum AVO_BillCurrency {
    avoBillCurrencyUSD = 0,
    avoBillCurrencyRMB = 1
};

enum AVO_ImageAvaliable {
    avoImageAvaliableYES = 0,
    avoImageAvaliableNO = 1
};

enum AVO_UserTripShipStatus {
    avoUserTripShipStatusOwner = 0,
    avoUserTripShipStatusMember = 1,
    avoUserTripShipStatusInvited = 2,
    avoUserTripShipStatusRequired = 3,
    avoUserTripShipStatusQuit = 4
};

@interface AVOCommModel : NSObject


-(id)fromDictionary:(NSDictionary *) dict;
-(NSDictionary *)toDictionary;

@end
