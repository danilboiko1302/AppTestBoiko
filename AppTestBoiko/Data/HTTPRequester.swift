//
//  HTTPRequester.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class HTTPRequester{
    typealias CompletionHandler = (_ data:Data?) -> Void
    static func getRequest(_ url:String,  completionHandler: @escaping CompletionHandler) {
      //  print("I am HTTPRequester, I will sent request and give data back to HTTPService.")
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        if let urlComponents = URLComponents(string: url) {
            if let url = urlComponents.url {
                dataTask =
                    defaultSession.dataTask(with: url)  {  data, response, error in
                        if let error = error {
                            print(error.localizedDescription)
                            completionHandler(nil)
                        } else if let data = data,
                                  let response = response as? HTTPURLResponse,
                                  response.statusCode == 200 {
                            //print("I am HTTPRequester, I got new data and give it back to HTTPService.")
                            completionHandler( data)
                        }
                    }
                dataTask?.resume()
            }
        }
    }
    static func loadImage(url:URL,  completionHandler: @escaping CompletionHandler){
       // print("Download Started")
       // print("LOAD")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            //print(response?.suggestedFilename ?? url.lastPathComponent)
           // print("Download Finished")
            completionHandler( data)
        }
        
    }
  
    
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
