//
//  SGAVMP.h
//  SecurityGuardMain
//
//  Created by lifengzhong on 2016/12/29.
//  Copyright © 2016年 Li Fengzhong. All rights reserved.
//

#ifndef SGAVMP_h
#define SGAVMP_h

#import <Foundation/Foundation.h>

 


#ifdef _SG_INTERNAL_VERSION_

#import "ISecurityGuardAVMPSafeToken.h"
#import "ISecurityGuardAVMPSoftCert.h"

#else

#import "JAQAVMPSignature.h"

#endif

#import "ISecurityGuardOpenAVMPGeneric.h"
#import "ISecurityGuardOpenAVMPSafeToken.h"
#import "ISecurityGuardOpenAVMPSoftCert.h"

#endif /* SGAVMP_h */
