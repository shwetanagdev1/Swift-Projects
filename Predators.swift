//
//  Predators.swift
//  JPApexPredators17
//
//  Created by Shweta Nagdev on 2024-02-28.
//

import Foundation
// MANIPULATES THE DATA
//class for all our Predators instead of one
class Predators{
    // once all the apex predators are decoded they will be found here, the initial value is set to empty array
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    // used to call the decode fucntion whenever a new instance of predators is created
    init() {
        
        decodeApexPredatorData()
    }
    // decoding JSON data
    func decodeApexPredatorData() {
        // use the url to access the json data
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do {
                // try to get data from the URL, try since getting data can throw errors
                let data = try Data(contentsOf: url)
                // set up a JSON decoder
                let decoder = JSONDecoder()
                // since the JSON data has variables in SnakeCase we need to convert to camlcase
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // decode and store all the apexPredators in the variable created above
                // decoding from data to [ApexPredator]- convert JSON data to ApexPredator instances AND stores in the apexPredators property
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch{
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty{
            return apexPredators
        } else {
            //make another function for filter - filter works like a for each loop
            // localizedInsensitivecontains makes the search case insensitive
            //filter our list to only have the predators whose name contains the searchText(whatever the user types on the search field)
            return apexPredators.filter {
                predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    // in the sort function we compare two predators with each other
    func sort(by alphabetical: Bool) {
        apexPredators.sort {
            predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    // arguement name: parameter type
    func filter(by type: PredatorType){
        if type == .all {
            apexPredators = allApexPredators
            
        } else {
            apexPredators = allApexPredators.filter {
                predator in
                predator.type == type
            }
        }
        
        
    }
}
