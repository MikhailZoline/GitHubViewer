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
