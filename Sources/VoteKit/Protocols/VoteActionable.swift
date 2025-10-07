//
//  NPSActionable.swift
//  NetPromoterScoreKit
//
//  Created by Maziar Saadatfar on 9/25/25.
//
import ControlKitBase
public protocol VoteActionable {
    func setAction(_ action: ControlKitAction)
}
public extension VoteActionable where Self: VoteViewModel {
    func setAction(_ action: ControlKitAction) {
        Task {
            var request = ActionRequest(
                route: .vote,
                appId: serviceConfig.appId,
                sdkVersion: voteKit_Version,
                action: action,
                itemId: self.response.data?.id ?? "",
            )
            request.extraParameter = "\(request.itemId ?? "")/\(action.rawValue.lowercased())"
            let _: Result<ActionResponse> = try await voteActionService.execute(request: request)
        }
    }
}
