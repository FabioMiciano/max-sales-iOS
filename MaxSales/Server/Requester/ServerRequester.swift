//
//  ServerRequester.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation

final class ServerRequester: Requester {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String : Any]?, header: String?) throws -> URLRequest {
        let requestEndPoint = "\(baseURL)\(endPoint)"
        
        guard let url = URL(string: requestEndPoint) else {
            throw Errors.invalidURL
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let parameters = parameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        
        if let header = header {
            urlRequest.addValue(header, forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }
    
    
    func requestWith(endPoint: Endpoint, completion: @escaping RequesterCompletion) {
        guard let request = try? self.createURLRequestWith(endPoint: endPoint.path, method: endPoint.method, parameters: endPoint.parameters, header: endPoint.header) else {
            completion(.failure(Errors.invalidRequest))
            return
        }
        
        self.session.dataTask(with: request) {[weak self] (data, response, error) in
            guard let result = self?.handleRequest(response: response, data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(Errors.serverError))
                }
                return
            }
            
            if !result.success {
                guard let error = result.error else {
                    DispatchQueue.main.async {
                        completion(.failure(Errors.serverError))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            if result.success {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    completion(.success(data))
                    return
                }
            }
        }.resume()
    }
    
    private func handleRequest(response: URLResponse?, data: Data?) -> (success: Bool, error: Errors?) {
        guard let response = response as? HTTPURLResponse, let data = data else { return (false, nil) }
        
        switch response.statusCode {
        case 200, 201, 202, 203, 204:
            return (true, nil)
        case 300:
            return (false, Errors.redirect)
        case 400, 401, 402, 403, 404:
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(DataError.self, from: data)
                return (false, Errors.clientError(error: model) )
            } catch {
                return (false, Errors.serverError)
            }
            
        case 500:
            return (false, Errors.serverError)
        default:
            return (false, Errors.invalidRequest)
        }
    }
}
