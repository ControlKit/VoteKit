//
//  NPSActionable.swift
//  NetPromoterScoreKit
//
//  Created by Maziar Saadatfar on 9/25/25.
//
public protocol VoteActionable {
    func setAction(_ action: VoteAction)
}
public extension VoteActionable where Self: VoteViewModel {
    func setAction(_ action: VoteAction) {
        Task {
            let request = ActionRequest(appId: serviceConfig.appId, voteId: self.response.data?.id ?? "", action: action)
            let _ = try await voteActionService.action(request: request)
        }
    }
}
