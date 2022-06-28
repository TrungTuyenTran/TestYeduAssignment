//
//  Repository.swift
//  Repository
//
//  Created by Tran Tuyen on 27/06/2022.
//

import DomainServices
import Foundation

public protocol ItemRepositoryProtocol {
    func getAllList(page: Int, limit: Int, completionHandler: @escaping ((PagingResponse<ResponseItemModel>?, String?) -> Void))
}

public class ItemRepository: ItemRepositoryProtocol {
    
    private var domain: DomainServicesProtocol = DomainServices()
    
    public init() {}
    
    public func getAllList(page: Int, limit: Int = 20, completionHandler: @escaping ((PagingResponse<ResponseItemModel>?, String?) -> Void)) {
        domain.callGETApi(urlString: API.users.url,
                          customHeader: Constants.baseHeader,
                          params: [
                            "page": String(page),
                            "limit": String(limit)
                          ]) { [weak self] responseData, error in
                              guard let self = self else { return }
                              if let error = error {
                                  let errorMessage = self.handleError(error: error)
                                  completionHandler(nil, errorMessage)
                                  return
                              }
                              if let responseData = responseData {
                                  do {
                                      let pagingObject = try JSONDecoder().decode(PagingResponse<ResponseItemModel>.self, from: responseData)
                                      print("LOG ERROR: ✅ API Success - GET \(API.users.url): \n\(pagingObject) \n\n")
                                      completionHandler(pagingObject, nil)
                                  } catch {
                                      print("LOG ERROR: ❌ API Failure - GET \(API.users.url): \n\(APIError.convertJSON.errorMessage) \n\n")
                                      completionHandler(nil, APIError.convertJSON.errorMessage)
                                  }
                              }
                          }
    }
    
    private func handleError(error: Error) -> String {
        if let error = error as? APIError {
            return error.errorMessage
        } else {
            return error.localizedDescription
        }
    }
}
