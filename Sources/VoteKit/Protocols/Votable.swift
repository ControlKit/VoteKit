//
//  Votetable.swift
//
//
//  Created by Maziar Saadatfar on 10/11/23.
//

import Foundation

public protocol Votable: AnyObject {
    var voteService: VoteServiceProtocol! { get }
    func getVote(request: VoteRequest) async throws -> VoteResponse?
    func setVote(request: SubmitVoteRequest) async throws -> SubmitVoteResponse?
}

extension Votable {
    public func getVote(request: VoteRequest) async throws -> VoteResponse? {
        return try await voteService.getVote(request: request)
    }
    
    public func setVote(request: SubmitVoteRequest) async throws -> SubmitVoteResponse? {
        return try await voteService.setVote(request: request)
    }
}
