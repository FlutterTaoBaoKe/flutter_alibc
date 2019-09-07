//
//  SGSecurityBody.h
//  SecurityGuardMain
//
//  Created by lifengzhong on 2016/12/29.
//  Copyright © 2016年 Li Fengzhong. All rights reserved.
//

#ifndef SGSecurityBody_h
#define SGSecurityBody_h

#import <Foundation/Foundation.h>

 

#ifdef _SG_INTERNAL_VERSION_

#import "ISecurityGuardRootDetect.h"
#import "ISecurityGuardSecurityBody.h"
#import "ISecurityGuardSimulatorDetect.h"
#import "ISecurityGuardPageTrack.h"
#import "SecurityGuardPageTrackDefine.h"
#else

#import "ISecurityGuardOpenJAQVerification.h"

#endif

#import "ISecurityGuardOpenSecurityBody.h"
#import "ISecurityGuardOpenSimulatorDetect.h"
#import "ISecurityGuardOpenLBSRisk.h"

#endif /* SGSecurityBody_h */
