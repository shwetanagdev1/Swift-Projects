//
//  ContentView.swift
//  JPApexPredators17
//
//  Created by Shweta Nagdev on 2024-02-27.
//

import SwiftUI
import MapKit
// SHOWS THE DATA
struct ContentView: View {
    let predators = Predators()
    
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PredatorType.all
    
    // filtered dinos is an array of apex predators
    // calling a function from predators class to filter the data
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        // in here, alphabetical is set to false anyways so it
        //does not sort
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinos) { predator in
                NavigationLink{
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                    
                } // label has the entire HStack in it
            label: {
                HStack{
                    //Dinosaur Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .shadow(color: .white, radius: 1)
                    
                    VStack(alignment: .leading){
                        //Name
                        Text(predator.name)
                            .fontWeight(.bold)
                        // Type
                        Text(predator.type.rawValue.capitalized)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 5)
                            .background(predator.type.background)
                            .clipShape(.capsule)
                    }
                    
                }
            }
            }.navigationTitle("Apex Predators")
                .searchable(text: $searchText)
                .autocorrectionDisabled()
            // give it the animation effect, whenever search text changes it triggers animation to occur
                .animation(.default, value: searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                alphabetical.toggle()
                            }
                        } label: {
                            //                        if alphabetical{
                            //                            Image(systemName: "film")
                            //                        } else {
                            //                            Image(systemName: "textformat")
                            //                        }
                            
                            // use of the ternary operator - checks if conditional is true and makes decision, equivalent of if else
                            Image(systemName: alphabetical ?
                                  "film" : "textformat")
                            //whenever the value of alphabetical changes, it impacts the symbol effect to bounce
                            .symbolEffect(.bounce, value: alphabetical)
                        }
                    }
                    // another toolbar item - Menu
                    ToolbarItem(placement: .topBarTrailing){
                        Menu {
                            //Picker property reuqires a title and what is currently selected in the picker
                            Picker("Filter", selection: $currentSelection.animation()){
                                // we will be using a foreach loop
                                ForEach(PredatorType.allCases){
                                    type in
                                    // use Label a new view- Label takes in arguements - title and systemimage
                                    Label(type.rawValue.capitalized, systemImage: type.icon)
                                }
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                    }
                    
                }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
