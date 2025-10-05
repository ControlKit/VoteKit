//
//  AgreementServiceProtocol.swift
//  
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation

public protocol ActionServiceProtocol {
    func action(request: ActionRequest) async throws -> ActionResponse?
}
public class ActionService: ActionServiceProtocol {
    public init() {}
    public func action(request: ActionRequest) async throws -> ActionResponse? {
        do {
            guard let url = URL(string: "\(request.route)\(request.voteId)/\(request.action.rawValue)") else {
                return ActionResponse()
            }
            var req = URLRequest(url: url)
            req.allHTTPHeaderFields = request.headers
            req.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            req.httpMethod = "POST"
            req.httpBody = try JSONEncoder().encode(request.params)
            let (data, res) = try await URLSession.shared.data(for: req)
            if (res as? HTTPURLResponse)?.statusCode == 204 {
                print("Vote Action Response --> 204")
                return nil
            }
            if let response = try? JSONDecoder().decode(ActionResponse.self, from: data) {
                print("Vote Action Response --> 200")
                print(response)
                return response
            } else {
                print("Vote Action Response --> Decode Error")
                return nil
            }
        } catch {
            print("Failed to Vote Action Request \(error)")
            return nil
        }
    }
}
