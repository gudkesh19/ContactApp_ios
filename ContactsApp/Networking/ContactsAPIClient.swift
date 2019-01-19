//
//  ContactFetcher.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 24/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

final class ContactsAPIClient {
    
    private let session: URLSession
    
    init(with session: URLSession) {
        self.session = session
    }
    
    func fetch<T: APIRequest> (_ request: T, completion: @escaping ResponseCallback<T.Response>) {
        guard let url = URL(string: request.resourceURLString) else {
            completion(.failure(ContactError.invalidURL))
            return
        }
        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data = data {
                do {
                    let response: T.Response = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
