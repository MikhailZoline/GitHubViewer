//
//  GitViewModel.swift
//  GitHubViewer
//
//  Created by Mikhail Zoline on 1/9/19.
//  Copyright © 2019 MZ. All rights reserved.
//

import Foundation

struct GitHubViewArray: Codable{
    var array: [GitHubView]
}

struct GitHubView: Codable{
    var name: String?
    var description: String?
    var created_at: String?
    var license: GitHubLicense?
}

struct GitHubLicense: Codable{
        var name: String?
}

extension GitHubView {
    
    static var dayFormatter: DateFormatter? = nil
    var createdFormatter: DateFormatter {
        if (GitHubView.dayFormatter == nil) {
            GitHubView.dayFormatter = DateFormatter()
            GitHubView.dayFormatter?.locale = Locale(identifier: "US_en")
            GitHubView.dayFormatter?.timeStyle = .none
            GitHubView.dayFormatter?.dateFormat = "MM-DD-YYYY"
        }
        return GitHubView.dayFormatter!
    }
    
    var created : String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withYear, .withMonth, .withDay]
        let date = dateFormatter.date(from: created_at ?? "2015-11-10T19:52:44Z")
        return createdFormatter.string(from: date!)
    }
}
