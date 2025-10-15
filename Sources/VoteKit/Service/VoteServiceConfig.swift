//
//  VoteServiceConfig.swift
//
//
//  Created by Maziar Saadatfar on 10/12/23.
//

import Foundation
import ControlKitBase
public struct VoteServiceConfig {
    public init(style: VoteViewStyle = .fullscreen1,
                appId: String,
                name: String,
                language: CKLanguage) {
        self.viewConfig = VoteViewStyle.getViewConfigWithStyle(style: style, lang: language)
        self.appId = appId
        self.name = name
        self.language = language
    }
    public var appId: String
    public var name: String
    public var language: CKLanguage
    public var sdkVersion: String = voteKit_Version
    public var viewConfig: VoteViewConfig
}
