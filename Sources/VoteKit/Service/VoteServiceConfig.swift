//
//  VoteServiceConfig.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
public struct VoteServiceConfig {
    public init(style: VoteViewStyle = .fullscreen1,
                appId: String,
                name: String,
                language: String,
                version: String) {
        self.viewConfig = VoteViewStyle.getViewConfigWithStyle(style: style, lang: language)
        self.appId = appId
        self.name = name
        self.version = version
        self.language = language
    }
    public var appId: String
    public var name: String
    public var language: String
    public var version: String
    public var sdkVersion: String = voteKit_Version
    public var viewConfig: VoteViewConfig
}
