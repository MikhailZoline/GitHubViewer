//
//  NetworkManager.swift
//  GitHubViewer
//
//  Created by Mikhail Zoline on 1/9/19.
//  Copyright © 2019 MZ. All rights reserved.
//

import Foundation
import CoreLocation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
    switch response.statusCode {
    case 200...299: return .success
    case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
}

public typealias NetworkRequestCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

class NetworkManager {
    
    static let GitHubURL: String = "https://api.github.com/users/"
    
    private var task: URLSessionTask?
    
    private init(){
        
    }
    static let sharedInstance = NetworkManager()
    
    var user: String?
    
    func request(user: String, page: Int, completion: @escaping NetworkRequestCompletion) {
        
        let session = URLSession.shared
        
        let stringURL: String = NetworkManager.GitHubURL + user + "/repos?page=" + String(page) + "&per_page=10"
        
        guard let url = URL(string: stringURL) else{
            fatalError("Failed to create URL with \(stringURL)" )
        }
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
       
        self.task = session.dataTask(with: request, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        
        self.task?.resume()
    }
    
    func getPage(user: String, page: Int, completion: @escaping (_ list: [GitHubView]?,_ error: String?)->()){
        
        self.request(user: user, page: page) { (data, response, error) in
            if error != nil {
                    completion(nil, "Please check your network connection.")
                }
                if let response = response as? HTTPURLResponse {
                    let result = handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
//                            print(responseData)
                            let responseJSON: [GitHubView] = try JSONDecoder().decode([GitHubView].self, from : responseData)
                            // print(responseJSON.debugDescription)
                            OperationQueue.main.addOperation({
                                completion( responseJSON,nil)
                            })
                        }catch {
                            print("Failed to Initialize JSON object \(error)")
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    }

