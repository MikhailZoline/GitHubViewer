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
    
    static var dateFormatterISO8601: DateFormatter? = nil
    static var dateFormatter: DateFormatter? = nil
    
    var dateFormatterPosix: DateFormatter{
        if GitHubView.dateFormatterISO8601 == nil {
            GitHubView.dateFormatterISO8601 = DateFormatter()
            GitHubView.dateFormatterISO8601!.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            GitHubView.dateFormatterISO8601!.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        return GitHubView.dateFormatterISO8601!
    }

    var dateFormatter: DateFormatter {
        if (GitHubView.dateFormatter == nil) {
            GitHubView.dateFormatter = DateFormatter()
            GitHubView.dateFormatter!.dateFormat = "MM-dd-yyyy"
        }
        return GitHubView.dateFormatter!
    }
    
    var created : String {
        let date = (created_at != nil ? dateFormatterPosix.date(from: created_at!) : dateFormatterPosix.date(from: "2015-11-10T19:52:44Z"))
        return dateFormatter.string(from: date!)
    }
}
