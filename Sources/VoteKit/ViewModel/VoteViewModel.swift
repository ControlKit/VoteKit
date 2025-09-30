//
//  File.swift
//  
//
//  Created by Maziar Saadatfar on 9/29/23.
//

import Foundation
import UIKit

public protocol VoteViewModel {
    var response: VoteResponse { get set }
}

public final class DefaultVoteViewModel: VoteViewModel {
    public var response: VoteResponse
    public init(response: VoteResponse) {
        self.response = response
    }
}

