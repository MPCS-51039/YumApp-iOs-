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
    private let urlString = "https://run.mocky.io/v3/34a4d744-d8e4-4d77-912d-6afc5e66fb49"
//    empty mocky
//    private let urlString = "https://run.mocky.io/v3/fc8c249e-a12d-4e82-8303-f03f3c90e121"
    
    func getProduce(completion: @escaping ([Produce]?, Error?) -> ()) {
            guard let url = URL(string: self.urlString) else { //url initializer, we ensure it can create URL form our string, otherwise we switcho main dispatch queue
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
