//
//  ActionResponse.swift
//  AgreementKit
//
//  Created by Maziar Saadatfar on 9/1/25.
//
import Foundation
public struct ActionResponse: Codable {
    public var data: ActionModel?
}
public struct ActionModel: Codable {
    public let id: String?
}

