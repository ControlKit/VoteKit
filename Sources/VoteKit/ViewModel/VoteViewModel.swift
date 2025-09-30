//
//  File.swift
//  
//
//  Created by Maziar Saadatfar on 9/29/23.
//

import Foundation
import UIKit

public protocol VoteViewModel: Votable {
    var serviceConfig: VoteServiceConfig { get set }
    var response: VoteResponse { get set }
    var selectedVoteOption: VoteOption? { get set }
    func setVote()
}

public final class DefaultVoteViewModel: VoteViewModel {
    public var voteService: VoteServiceProtocol!
    public var response: VoteResponse
    public var selectedVoteOption: VoteOption?
    public var serviceConfig: VoteServiceConfig
    public init(
        serviceConfig: VoteServiceConfig,
        response: VoteResponse,
        voteService: VoteServiceProtocol = VoteService()
    ) {
        self.serviceConfig = serviceConfig
        self.response = response
        self.voteService = voteService
    }
    public func setVote() {
        guard let selectedVoteOption else { return }
        Task {
            try await setVote(
                request: SubmitVoteRequest(
                    appId: serviceConfig.appId,
                    voteOptionId: selectedVoteOption.id
                )
            )
        }
    }
}

