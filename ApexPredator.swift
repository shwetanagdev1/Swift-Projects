//
//  ApexPredator.swift
//  JPApexPredators17
//
//  Created by Shweta Nagdev on 2024-02-28.
//

// SCOPE OF A SINGLE DINOSAUR
import Foundation
import SwiftUI
import MapKit
// DESCRIBES THE DATA
struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    // make a computed property for the image that returns a String
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // the name of the struct should have the first letter in capital form.
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    

}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    //add a type for all
    case all
    case land //"land"
    case air
    case sea
    
    var id: PredatorType {
        self
    }
    
    //background is our another computed property
    var background: Color {
        switch self {
        case .land:
            .brown
        case .air:
            .teal
        case .sea:
            .blue
        case .all:
            .black
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
    
    
}
