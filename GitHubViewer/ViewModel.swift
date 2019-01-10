//
//  ViewModel.swift
//  GitHubViewer
//
//  Created by Mikhail Zoline on 1/9/19.
//  Copyright © 2019 MZ. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class  {
    func reloadData()
}

class ViewModel{
    
    let networkManager: NetworkManager = NetworkManager.sharedInstance
    var gitArray: [GitHubView] = [GitHubView]()
    var operationQueue: OperationQueue = OperationQueue()
    weak var delegate: ViewModelProtocol?
    var page: Int = 1
    var user: String? = "apple"
    var full: Bool = false
    static let viewModel = ViewModel()
    private init(){}

    func gitListUpdated() {
        
        operationQueue.qualityOfService = .default
        let getGitListOperation: BlockOperation = BlockOperation(block: {[weak self] in
            self!.networkManager.getPage(user: self!.user!, page: self!.page, completion:  { (gitArray, error) in
                if ((error) != nil){
                    fatalError("Failed to Initialize JSON object \(error!.description)")
                }
                OperationQueue.main.addOperation { [weak self] in
                    self?.full = gitArray?.count == 0 ? true : false
                    self?.page += 1
                    self?.gitArray += gitArray as! [GitHubView]
                    self?.delegate?.reloadData()
                }
            })
        })
        getGitListOperation.completionBlock = {[weak self] in
    
        }
        if( self.full == false){
//            print("gitListUpdated(\(self.page))")
            operationQueue.addOperation(getGitListOperation)
        }
        else{
//            print("gitListFull(\(self.page))")
        }
    }
}
