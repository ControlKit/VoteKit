//
//  File.swift
//  
//
//  Created by Maziar Saadatfar on 9/29/23.
//

import Foundation
import UIKit
import ControlKitBase
public protocol VoteViewModel: Votable,
                               VoteActionable,
                               VoteSavable {
    var voteActionService: GenericServiceProtocol { get set }
    var voteService: GenericServiceProtocol { get set }
    var serviceConfig: VoteServiceConfig { get set }
    var response: VoteResponse { get set }
    var selectedVoteOption: VoteOption? { get set }
    func setVote() async throws -> Result<SubmitVoteResponse>?
    func saveLastId()
}

public final class DefaultVoteViewModel: VoteViewModel {
    public var voteActionService: GenericServiceProtocol
    public var voteService: GenericServiceProtocol
    public var response: VoteResponse
    public var selectedVoteOption: VoteOption?
    public var serviceConfig: VoteServiceConfig
    public init(
        serviceConfig: VoteServiceConfig,
        response: VoteResponse,
        voteService: GenericServiceProtocol = GenericService(),
        voteActionService: GenericServiceProtocol = GenericService()
    ) {
        self.serviceConfig = serviceConfig
        self.response = response
        self.voteService = voteService
        self.voteActionService = voteActionService
    }
    public func setVote() async throws -> Result<SubmitVoteResponse>? {
        guard let selectedVoteOption else {
            let errorModel = NSError(domain: "No Vote Option Selected",
                                     code: 13)
            return Result.failure(errorModel)
        }
        return try await setVote(
            request: SubmitVoteRequest(
                itemId: self.response.data?.id,
                appId: serviceConfig.appId,
                voteOptionId: selectedVoteOption.id
            )
        )
    }
    public func saveLastId() {
        guard let id = response.data?.id else {
            return
        }
        saveLatestId(id: id, name: getName(serviceConfig.name))
    }
}

