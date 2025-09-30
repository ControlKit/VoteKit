//
//  VoteServiceProtocol.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation

public class VoteService: VoteServiceProtocol {
    public init() {}
    public func getVote(request: VoteRequest) async throws -> VoteResponse? {
        do {
            guard var urlComponents = URLComponents(string: request.route) else {
                return nil
            }
            var queryItems = urlComponents.queryItems ?? []
            queryItems.append(URLQueryItem(name: "name", value: request.name))
            urlComponents.queryItems = queryItems
            guard let url = urlComponents.url else {
                return nil
            }
            var req = URLRequest(url: url)
            req.allHTTPHeaderFields = request.headers
            req.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            let (data, res) = try await URLSession.shared.data(for: req)
            if (res as? HTTPURLResponse)?.statusCode == 204 {
                return nil
            }
            if let response = try? JSONDecoder().decode(VoteResponse.self, from: data) {
                print(response)
                return response
            } else {
                print("Invalid Response")
                return nil
            }
        } catch {
            print("Failed to Send POST Request \(error)")
            return nil
        }
    }
    public func setVote(request: SubmitVoteRequest) async throws -> SubmitVoteResponse? {
        do {
            guard let url = URL(string: request.route) else {
                return nil
            }
            var req = URLRequest(url: url)
            req.allHTTPHeaderFields = request.headers
            req.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            let (data, res) = try await URLSession.shared.data(for: req)
            if (res as? HTTPURLResponse)?.statusCode == 204 {
                return nil
            }
            req.httpMethod = "POST"
            req.httpBody = try JSONEncoder().encode(request.params)
            if let response = try? JSONDecoder().decode(SubmitVoteResponse.self, from: data) {
                print(response)
                return response
            } else {
                print("Invalid Response")
                return nil
            }
        } catch {
            print("Failed to Send POST Request \(error)")
            return nil
        }
    }
}
