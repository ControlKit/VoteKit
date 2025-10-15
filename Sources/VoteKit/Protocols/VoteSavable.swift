//
//  VoteSavable.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/14/25.
//
import Foundation
public protocol VoteSavable {
    func saveLatestId(id: String, name: String)
}
public extension VoteSavable {
    func saveLatestId(id: String, name: String) {
        UserDefaults.standard.set(id, forKey: name)
    }
}
func getName(_ name: String) -> String {
    return "CK_Vote_Name_\(name)"
}
