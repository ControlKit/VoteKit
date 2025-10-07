//
//  UpdateResponse.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
import ControlKitBase
public struct VoteResponse: Codable {
    public var data: VoteModel?
}
public struct VoteModel: Codable {
    public let id: String
    public let name: String
    public let force: Bool
    public let title: LocalString?
    public let description: LocalString?
    public let accept_button_title: LocalString?
    public let cancel_button_title: LocalString?
    public let vote_options: [VoteOption]
    public let sdk_version: String?
    public let created_at: String?
}

public struct VoteOption: Codable {
    public let id: String
    public let title: LocalString?
    public let order: Int
    public let created_at: String
}
