//
//  ISecurityGuardOpenAVMPSoftCert.h
//  SecurityGuardAVMP
//
//  Created by chenkong on 16/2/16.
//  Copyright © 2016年 SGAVMP. All rights reserved.
//

#ifndef ISecurityGuardOpenAVMPSoftCert_h
#define ISecurityGuardOpenAVMPSoftCert_h

#import <SecurityGuardSDK/Open/IOpenSecurityGuardPlugin.h>

@protocol ISecurityGuardOpenAVMPSoftCert <NSObject, IOpenSecurityGuardPluginInterface>

- (BOOL) initAVMPSoftCert: (NSString*) authCode;


- (NSData*) generateCSR: (NSString*) key
                   info: (NSString*) info
                   type: (int) type;

- (NSData*) signWithCert: (NSString*) key
                    data: (NSData*) plaintext
                    type: (int) type;

- (BOOL) verifyWithCert: (NSString*) key
              signature: (NSData*) signature
              plainData: (NSData*) plainData
                   type: (int) type;

- (BOOL) installCert: (NSString*) key
            certInfo: (NSString*) certInfo;


- (NSString*) getCert: (NSString*) key;



@end



#endif /* ISecurityGuardOpenAVMPSoftCert_h */
