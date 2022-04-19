//
//  ProduceService.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import Foundation

enum ProduceCallingError: Error {
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case ProblemDecodingData
}

class ProduceService {
    
    private let urlString = "https://run.mocky.io/v3/0e462cdb-a8b1-4e7a-853f-081887b5969c"
    
    func getProduce(completion: @escaping ([Produce]?, Error?) -> ()) {
            guard let url = URL(string: self.urlString) else {
                DispatchQueue.main.async { completion(nil, ProduceCallingError.problemGeneratingURL) }
                return
        }
                
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async { completion(nil, ProduceCallingError.problemGettingDataFromAPI) }
                    return
                }
                
                do {
                    let produceResult = try JSONDecoder().decode(ProduceResult.self, from: data)
                    DispatchQueue.main.async { completion(produceResult.produces, nil) }
                } catch (let error) {
                    print(error)
                    DispatchQueue.main.async { completion(nil, ProduceCallingError.ProblemDecodingData) }
                }
                                                        
            }
            task.resume()
        }
}
