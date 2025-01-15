//
//  PredatorDetail.swift
//  JPApexPredators17
//
//  Created by Shweta Nagdev on 2024-03-04.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    // dinosaur property so that we can grab all the data 
    let predator: ApexPredator
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader{
            geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing) {
                    // Background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                    //for gradient
                        .overlay{
                            LinearGradient(stops: 
                            [Gradient.Stop(color: .clear, location: 0.80),
                            Gradient.Stop(color: .black, location: 1)],
                            startPoint: .top , endPoint: .bottom)
                        }
                    
                    // Dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                    //geo.size.width is the size of the entire screen
                        .frame(width: geo.size.width/1.5,
                               height: geo.size.height/3)
                    // flips the dinosaur
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                    // makes the dinosaur pop
                        .offset(y: 20)
                    
                        
                }
                
                // Dinosaur name
                // can't add alignment to ScrollView so 1-we make a VStack and do alignment 2- add alignment to frame of the Scroll View
                VStack(alignment: .leading){
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Current location
                    NavigationLink{
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250 , pitch: 80 ))
                        )
                    } label: {
                        //Binding<MapCameraPosition> is basically where we are looking at the map from. For a binding value, we need to create a property
                        Map(position: $position) {
                            // used to add annotations like location pins
                            Annotation(predator.name, coordinate: predator.location){
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                                
                            }
                            //for usability purposes
                            .annotationTitles(.hidden)
                        }
                    }
                
                    .frame(height: 125)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "greaterthan")
                            .imageScale(.large)
                            .font(.title3)
                            .padding(.trailing, 5)
                    }
                    .overlay(alignment: .topLeading){
                        Text("Current Location")
                            .padding([.leading, .bottom], 5)
                            .padding(.trailing, 8)
                            .background(.black.opacity(0.33))
                            .clipShape(.rect(bottomTrailingRadius: 15))
                    }
                    .clipShape(.rect(cornerRadius: 15)) //makes the borders rounded
                    //Movies the dinosaurs appear in
                    // to use foreach everything in the collection we're using should be unique and identifiable
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    
                    // to make Strings identifiable and unique we add id- makinf ForEach Identifiable without changing the entire model to identifiable
                    ForEach(predator.movies, id: \.self){
                        movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    // Movie moments
                    Text("Movie Moments")
                        .font(.title)
                    //padding the top to make spac between bullet points and title
                        .padding(.top, 15)
                    ForEach(predator.movieScenes){
                        scene in
                        
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                        //adds the padding between the title and the paragraph
                            .padding(.bottom, 15)
                        
                        
                    }
                    
                    
                    // Link to webpage
                    Text("Read More:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                    
                } // Vstack ends
                // using .frame to make the Text of the name move to the leading edge of the screen
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
                
                
                
            }.ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    //Preview limitations dont allow us to use map on PredatorDetail, navigation link only works within a navigation stack
    NavigationStack{
        // distance is how high up from the ground are we
        PredatorDetail(predator: Predators().apexPredators[2], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 30000 )))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
