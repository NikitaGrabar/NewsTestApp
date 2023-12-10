//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Nikita Grabar on 8.12.23.
//

import Foundation

class RequestProcedure {

    static let news = "?apikey=pub_3437165f1ec99dbc0e2343c5787d447b0e64c&q=pegasus&language=en"

}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    let SERVICE = "https://newsdata.io/api/1/news"
    
    func getNews(page: String, onSuccess: @escaping (ResponseDataNews) -> (), onFailure: @escaping () -> ()) {
        var stringPage = ""
        if !page.isEmpty {
            stringPage = "&page=\(page)"
        }
        
        guard let url = URL(string: SERVICE + RequestProcedure.news + stringPage) else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                print ("error: \(error)")
                onFailure()
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                onFailure()
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
               let data = data {
                do {
                  let decodedResponse = try JSONDecoder().decode(ResponseDataNews.self, from: data)
                    onSuccess(decodedResponse)
                } catch let jsonError as NSError {
                    print(String(describing: jsonError))
                }
            }
        }
        task.resume()
    }
    
    func getImage(urlString: String,completion: @escaping((Data?) -> ())) {
        guard let url = URL(string: urlString) else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            completion(data)
        }
        task.resume()
    }
}
