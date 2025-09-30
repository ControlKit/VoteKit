//
//  SubmitVoteResponse.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 9/28/25.
//
import Foundation
public struct SubmitVoteResponse: Codable {
    public var data: SubmitVoteModel?
}
public struct SubmitVoteModel: Codable {
    public let id: String
    public let sdk_version: Int?
    public let created_at: String?
}

