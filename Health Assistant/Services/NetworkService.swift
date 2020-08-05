//
//  NetworkService.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 22.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class NetworkService {
    
    let apiKey = "faf75e02-d27e-4fce-8add-fa02a9bff264"
    let requestString = "больница,Санкт-Петербург"
    let clinicURL = "https://search-maps.yandex.ru/v1/?lang=ru_RU&type=biz&results=5"
    
    func fetchClinics(handler: @escaping ([LocationDataTransferObject]?, Error?) -> ()) {
        let urlString = "\(clinicURL)&apikey=\(apiKey)&text=\(requestString)"
        
        //        1. Create URL string
        if let url = URL(string: urlString.encodeUrl){
            //        2. Create URL session
            let session = URLSession(configuration: .default)
            //        3. Give URL session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    handler(nil, error)
                }
                if let safeData = data {
                    if let locations = self.parseJSON(safeData) {
                        handler(locations, nil)
                    }
                }
            }
            //        4. Start a task
            task.resume()
        }
    }
    
    func parseJSON(_ clinicData: Data) -> [LocationDataTransferObject]? {
        var locations = [LocationDataTransferObject]()
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ClinicData.self, from: clinicData)
            for feature in decodedData.features {
                let idString = feature.properties.CompanyMetaData.id
                let name = feature.properties.name
                let description = feature.properties.description
                let longitude = feature.geometry.coordinates[0]
                let latitude = feature.geometry.coordinates[1]
                
                let clinic = LocationDataTransferObject(id: Int64(idString)!, name: name, longitude: longitude, latitude: latitude, description: description)
                locations.append(clinic)
            }
            return locations
        } catch {
//            handler(error)
            return nil
        }
    }
}
