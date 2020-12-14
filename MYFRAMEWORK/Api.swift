//
//  Api.swift
//  MYFRAMEWORK
//
//  Created by Digital Dividend on 12/11/20.
//

import Foundation

//public protocol request{
//    func load() -> String
//
//}
//public class Api: request {
//    public func load() -> String {
//        return "request loaded "
//    }
//}

import Foundation
import Alamofire

public protocol APIRequest {
    
    associatedtype RequestDataType
    associatedtype ResponseDataType
    func makeRequest(from data: RequestDataType) throws -> URLRequest
    func parseResponse(data: Data) throws -> ResponseDataType
    
}

public class APIRequestLoader<T: APIRequest> {

    let apiRequest: T
    let urlSession: URLSession
    public init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }

    public func loadAPIRequest(requestData: T.RequestDataType,
                        completionHandler: @escaping (T.ResponseDataType?, Error?) -> Void) {
        do {
            let urlRequest = try apiRequest.makeRequest(from: requestData)
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data else { return completionHandler(nil,error) }
                do {
                    let parseResponse = try self.apiRequest.parseResponse(data: data)
                    completionHandler(parseResponse,nil)
                }catch{
                    completionHandler(nil,error)
                }
            }.resume()
        }catch {
            completionHandler(nil,error)
        }
    }
    public func getAlamofireResponse(_ url: String, completion: @escaping (String) -> Void) {
      
//        Alamofire.request(url).responseString { (response) in
//            //
//            if let json = response.result.value {
//                completion(json) // serialized json response
//            }
//
//            //
//        }
        let request = AF.request("https://swapi.dev/api/films")
            // 2
        request.responseString { (response) in
            print(response)
        }
                    //
//                    if let json = response.result.value {
//                        completion(json) // serialized json response
//                    }
    }
}
