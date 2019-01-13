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
    @objc dynamic var full: Bool = false
    static let viewModel = ViewModel()
    private init(){ operationQueue.qualityOfService = .default }
    private var operation: Operation?
}

extension ViewModel {
    
    
    func gitListUpdated() {
        
        let getGitListOperation: BlockOperation = BlockOperation(block: {[weak self] in
            
            self!.networkManager.getPage(user: self!.user!, page: self!.page, completion:  { (gitArray, error) in
                
                if ((error) != nil ){
                    print("Failed to Initialize JSON object \(error!.description)")
                    return
                }
                    
                else if self?.full != true && gitArray != nil && gitArray?.count != 0 {
                    OperationQueue.main.addOperation { [weak self] in
                        self?.page += 1
                        self?.gitArray += gitArray!
                        self?.delegate?.reloadData()
                    }
                }
                    
                else if gitArray?.count == 0 {
                    self?.full = true
                    self?.operationQueue.cancelAllOperations()
                }
                
            })
        })

        if(self.full != true ){
            operationQueue.addOperation(getGitListOperation)
        }

    }
    
}
