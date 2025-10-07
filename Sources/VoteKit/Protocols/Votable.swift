//
//  Votetable.swift
//
//
//  Created by Maziar Saadatfar on 10/11/23.
//

import Foundation
import ControlKitBase

public protocol Votable: AnyObject {
    var voteService: GenericServiceProtocol { get }
    func getVote(request: VoteRequest) async throws -> Result<VoteResponse>?
    func setVote(request: SubmitVoteRequest) async throws -> Result<SubmitVoteResponse>?
}

extension Votable {
    public func getVote(request: VoteRequest) async throws -> Result<VoteResponse>? {
        return try await voteService.execute(request: request)
    }
    
    public func setVote(request: SubmitVoteRequest) async throws -> Result<SubmitVoteResponse>? {
        return try await voteService.execute(request: request)
    }
}
