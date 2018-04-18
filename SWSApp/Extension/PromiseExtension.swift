//
//  PromiseExtension.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/26/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import PromiseKit

extension Promise {
    
    /**
     Waits on all provided promises.
     
     `any` waits on all provided promises, it rejects only if all of the promises rejected, otherwise it fulfills with values from the fulfilled promises.
     
     - Returns: A new promise that resolves once all the provided promises resolve.
     */
    public func any<T>(promises: [Promise<T>]) -> Promise<[T]> {
        guard !promises.isEmpty else { return Promise<[T]>([]) }
        return Promise<[T]> { fulfill, reject in
            var values = [T]()
            var countdown = promises.count
            for promise in promises {
                promise.then { value in
                    values.append(value)
                    }
                    .always {
                        --countdown
                        if countdown == 0 {
                            if values.isEmpty {
                                reject(AnyError.Any)
                            }
                            else {
                                fulfill(values)
                            }
                        }
                }
            }
        }
    }
    
    enum AnyError: ErrorType {
        case `Any`
    }

}
