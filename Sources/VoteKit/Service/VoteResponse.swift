//
//  UpdateResponse.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation

public typealias VoteLocalString = [VoteLocalizedText]

public struct VoteResponse: Codable {
    public var data: VoteModel?
}
public struct VoteModel: Codable {
    public let id: String
    public let name: String
    public let force: Bool
    public let title: VoteLocalString?
    public let description: VoteLocalString?
    public let accept_button_title: VoteLocalString?
    public let cancel_button_title: VoteLocalString?
    public let vote_options: [VoteOption]
    public let sdk_version: Int?
    public let created_at: String?
}
public struct VoteLocalizedText: Codable {
    public let language: String?
    public let content: String?
}

public struct VoteOption: Codable {
    public let id: String
    public let title: VoteLocalString?
    public let order: Int
    public let created_at: String
}
