//
//  VoteServiceProtocol.swift
//  
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation

public protocol VoteServiceProtocol {
    func getVote(request: VoteRequest) async throws -> VoteResponse?
    func setVote(request: SubmitVoteRequest) async throws -> SubmitVoteResponse?
}
