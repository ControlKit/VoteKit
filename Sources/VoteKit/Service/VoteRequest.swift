//
//  VoteRequest.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
public struct VoteRequest {
    public var appId: String
    public var route: String = "https://tauri.ir/api/votes"
    public var name: String
    public var applicationVersion: String = Bundle.main.releaseVersionNumber ?? String()
    public var deviceUUID: String = UUID().uuidString
    public var sdkVersion: String = voteKit_Version
    
    var headers: [String: String] {
        return ["x-app-id": appId,
                "x-sdk-version": sdkVersion,
                "x-version": applicationVersion,
                "x-device-uuid": deviceUUID]
    }
    
    var params: [String: String] {
        return ["name": name]
    }
}
