//
//  PredatorMap.swift
//  JPApexPredators17
//
//  Created by Shweta Nagdev on 2024-03-12.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    //make a predators class, do annotations for every single predator
    let predators = Predators()
    
    @State var position: MapCameraPosition
    @State var showsatelliteimage = false
    
    var body: some View {
        // map pushes out and uses all the space on the screen
        // position is of the dinosaur that we tapped on
        // annotations are of many dinosaurs
        Map(position: $position){
            //use foreach to get all the predator annotations on the map
            ForEach(predators.apexPredators){
                predator in
                Annotation(predator.name, coordinate: predator.location){
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height:100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        //mapStyle give the map a sort of satellite imagery
        //elevation: realistic makes it look 3D
        // use if else statement in the mapstyle
        .mapStyle(showsatelliteimage ? .imagery(elevation: .realistic)
                  : .standard(elevation: .realistic))
        
        
        // overlaying puts the button on the map
        .overlay(alignment: .bottomTrailing){
            Button{
                // changes the value of satellite image when the button is tapped
                showsatelliteimage.toggle()
            } label: {
                Image(systemName: showsatelliteimage ?
                      "globe.americas.fill" : "globe.americas")
                .font(.largeTitle)
                .imageScale(.large)
                .padding(3)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 7))
                .shadow(radius: 3)
                .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    //distance: distance from ground, heading: which direction we are facing, pitch: what angle we're looking at
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 1000, heading: 250 , pitch: 80 ))
    )
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
