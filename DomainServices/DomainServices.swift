//
//  DomainServices.swift
//  DomainServices
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation

public protocol DomainServicesProtocol {
    func callGETApi(urlString: String,
                    customHeader: [String: String]?,
                    params: [String: String]?,
                    completion: ((Data?, Error?) -> Void)?)
}

public class DomainServices: DomainServicesProtocol {
    public init() {}
    
    public func callGETApi(urlString: String,
                           customHeader: [String: String]? = nil,
                           params: [String: String]? = nil,
                           completion: ((Data?, Error?) -> Void)? = nil) {
        // Get url from url string
        guard var url = URL(string: urlString) else {
            completion?(nil, APIError.notFound)
            return
        }
        
        // Add params
        if let params = params,
           var urlComponents = URLComponents(string: urlString),
           params.isEmpty == false {
            var queryItems: [URLQueryItem] = []
            for key in params.keys {
                let queryItem = URLQueryItem(name: key, value: params[key])
                queryItems.append(queryItem)
            }
            urlComponents.queryItems = queryItems
            if let urlFromComponents = urlComponents.url {
                url = urlFromComponents
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Add custom header
        if let customHeader = customHeader {
            request.allHTTPHeaderFields = customHeader
        }
        
        // Start to call API
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                completion?(data, nil)
            } else if let error = error {
                if let httpResponse = response as? HTTPURLResponse {
                    print("LOG ERROR: ❌ API Failure - GET \(url): \n\(error) \n\n")
                    completion?(nil, APIError.other(NSError(domain: "",
                                                            code: httpResponse.statusCode,
                                                            userInfo: ["message": error.localizedDescription])))
                } else {
                    print("LOG ERROR: API Failure - GET \(url): \n Something went wrong \n\n")
                    completion?(nil, APIError.other(NSError(domain: "",
                                                            code: 0,
                                                            userInfo: ["message": "Something went wrong"])))
                }
            } else {
                print("LOG ERROR: ❌ API Failure - GET \(url): \n Something went wrong \n\n")
                completion?(nil, APIError.other(NSError(domain: "",
                                                        code: 0,
                                                        userInfo: ["message": "Something went wrong"])))
            }
        })
        
        task.resume()
    }
}
