//
//  GitServiceProtocol.h
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

#ifndef GitServiceProtocol_h
#define GitServiceProtocol_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GitStatus) {
    unmodified,
    ignored,

    addedInIndex,
    deletedInIndex,
    modifiedInIndex,
    renamedInIndex,

    addedInWorktree,
    deletedInWorktree,
    modifiedInWorktree,
    renamedInWorktree
};

@protocol GitServiceProtocol

// TODO: Use completion handler instead of error handler to provide possiblity to reload badges/status after mutating commands.

- (void) createRepositoryAt: (NSURL * _Nonnull) url
                  onFailure: (void (^ _Nullable) (NSError * _Nonnull)) errorHandler;

- (void) cloneRepositoryFrom: (NSURL * _Nonnull) origin
                          to: (NSURL * _Nonnull) destination
                   onFailure: (void (^ _Nullable) (NSError * _Nonnull)) errorHandler;



- (void) statusFor: (NSURL * _Nonnull) fileURL
      onCompletion: (void (^ _Nonnull) (GitStatus, NSError * _Nullable)) completionHandler;



- (void) commit: (NSString * _Nonnull) message
   inRepository: (NSURL * _Nonnull) repositoryURL
   onCompletion: (void (^ _Nullable) (NSError * _Nullable)) completionHandler;



- (void) addToIndex: (NSURL * _Nonnull) fileURL
       onCompletion: (void (^ _Nullable) (NSError * _Nullable)) completionHandler;

- (void) removeFromIndex: (NSURL * _Nonnull) fileURL
            onCompletion: (void (^ _Nullable) (NSError * _Nullable)) completionHandler;

@end

#endif /* GitServiceProtocol_h */
