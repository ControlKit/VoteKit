//
//  ActionRequest.swift
//  AgreementKit
//
//  Created by Maziar Saadatfar on 9/1/25.
//
import Foundation
public struct ActionRequest {
    public var appId: String
    public var voteId: String
    public var action: VoteAction
    public var route: String = "https://tauri.ir/api/votes/"
    public var deviceUUID: String = UUID().uuidString
    public var sdkVersion: String = voteKit_Version
    public var applicationVersion: String = Bundle.main.releaseVersionNumber ?? String()
    
    var headers: [String: String] {
        return ["x-app-id": appId,
                "x-sdk-version": sdkVersion,
                "x-version": applicationVersion,
                "x-device-uuid": deviceUUID]
    }
    
    var params: [String: String] {
        return [
            "action": action.rawValue
        ]
    }
}

public enum VoteAction: String {
    case view = "VIEW"
    case submit = "SUBMIT"
    case cancel = "CANCEL"
}
  
