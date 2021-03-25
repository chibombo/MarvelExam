//
//  URLSessionWorker.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 23/03/21.
//

import UIKit

enum HTTPMethods: String {
    case post = "POST"
    case get = "GET"
    case update = "UPDATE"
    case delete = "DELETE"
    case put = "PUT"
}

enum NetworkingError: String, Error {

    case serviceError = "Error en el servidor"
    case timeout = "Tiempo de espera agotado"
    case invalidForm = "Intente de nuevo más tarde"
    case notPerformed = "Fallo la operación"
    case unknow = "Error inesperado"

}

class URLSessionWorker: NSObject {

    static let shared = URLSessionWorker()

    private override init() {

    }

    func executeRequest<T: Decodable>(url: String,
                                      httpMethod: HTTPMethods,
                                      headers: [String: String]? = ["Content-Type":"application/json"],
                                      timeout: Double = 5,
                                      responseType: T.Type,
                                      completionHandler: @escaping(Result<T, NetworkingError>) -> Void) {
        if let anUrl: URL = URL(string: url) {
            var urlRequest: URLRequest = URLRequest(url: anUrl)
            urlRequest.timeoutInterval = timeout
            setHeaders(urlRequest: &urlRequest, headers: headers)
            urlRequest.httpMethod = httpMethod.rawValue
            let session: URLSession = URLSession.init(configuration: URLSessionConfiguration.ephemeral,
                                                      delegate: self,
                                                      delegateQueue: nil)
            DispatchQueue.global(qos: .userInitiated).async {
                session.dataTask(with: urlRequest,
                                 completionHandler: { (result: Data?, _: URLResponse?, error: Error?) in
                                    if let _: Error = error {
                                        completionHandler(.failure(.serviceError))
                                    } else if let data: Data = result, let aResult: T = try? JSONDecoder().decode(T.self, from: data) {
                                        completionHandler(.success(aResult))
                                    } else {
                                        completionHandler(.failure(.unknow))
                                    }

                                 }).resume()
            }
        }
    }

    func fetchImage(url: String, httpMethod: HTTPMethods, headers: [String: String]?, timeout: Double = 5, completionHandler: @escaping(Result<Data, NetworkingError>) -> Void) {

        if let anUrl: URL = URL(string: url) {
            var urlRequest: URLRequest = URLRequest(url: anUrl)
            urlRequest.timeoutInterval = timeout
            setHeaders(urlRequest: &urlRequest, headers: headers)
            urlRequest.httpMethod = httpMethod.rawValue
            let session: URLSession = URLSession.init(configuration: URLSessionConfiguration.ephemeral,
                                                      delegate: self,
                                                      delegateQueue: nil)
            DispatchQueue.global(qos: .userInitiated).async {
                session.dataTask(with: urlRequest) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
                    if let _: Error = error {
                        completionHandler(.failure(.serviceError))
                    } else if let anUrlResponse: HTTPURLResponse = urlResponse as? HTTPURLResponse,
                              anUrlResponse.statusCode == 200, let aData: Data = data {
                        completionHandler(.success(aData))
                    } else {
                        completionHandler(.failure(.serviceError))
                    }
                }.resume()
            }
        } else {
            completionHandler(.failure(.serviceError))
        }
    }

    func fetchImageWithCache(url: String, httpMethod: HTTPMethods, headers: [String: String]?, timeout: Double = 5, completionHandler: @escaping(Result<UIImage, NetworkingError>) -> Void) {
        if let objImage: UIImage = CacheWorker.shared.getObject(key: url) {
            completionHandler(.success(objImage))
        } else {
            fetchImage(url: url,
                       httpMethod: httpMethod,
                       headers: headers,
                       timeout: timeout) { (result: Result<Data, NetworkingError>) in
                switch result {
                case .success(let data):
                    if let image: UIImage = UIImage(data: data) {
                        CacheWorker.shared.setObject(key: url, image: image)
                        completionHandler(.success(image))
                    } else {
                        completionHandler(.failure(.unknow))
                    }
                case .failure(let error): completionHandler(.failure(error))
                }
            }
        }
    }


    private func setHeaders(urlRequest: inout URLRequest, headers: [String:String]?) {
        guard let anHeaders: [String: String] = headers else {return}
        for header in anHeaders {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
    }

}

extension URLSessionWorker: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential.init())
    }

    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print(error?.localizedDescription ?? "No error")
    }
}
