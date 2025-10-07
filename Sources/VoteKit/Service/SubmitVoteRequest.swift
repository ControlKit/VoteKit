//
//  SubmitVoteRequest.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 9/28/25.
//
import Foundation
import ControlKitBase
public struct SubmitVoteRequest: GenericRequest {
    public var itemId: String?
    public var extraParameter: String?
    public var appId: String
    public var voteOptionId: String
    public var httpMethod: HTTPMethod = .post
    public var route: ControlKitItem = .vote
    public var applicationVersion: String = Bundle.main.releaseVersionNumber ?? String()
    public var deviceUUID: String = CKDeviceUUID
    public var sdkVersion: String = voteKit_Version
    
    public var headers: [String: String] {
        return ["x-app-id": appId,
                "x-sdk-version": sdkVersion,
                "x-version": applicationVersion,
                "x-device-uuid": deviceUUID]
    }
    
    public var body: [String: String] {
        return ["vote_option_id": voteOptionId]
    }
}
