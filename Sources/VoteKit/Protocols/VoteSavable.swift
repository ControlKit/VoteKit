//
//  VoteSavable.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/14/25.
//
import Foundation
public protocol VoteSavable {
    func saveLatestId(id: String)
}
public extension VoteSavable {
    func saveLatestId(id: String) {
        UserDefaults.standard.set(id, forKey: latestVoteKey)
    }
}
