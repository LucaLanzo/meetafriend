//
//  SwipeLocationsView.swift
//  meetafriend
//
//  Created by Luca on 17.05.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SwipeLocationsView: View {
    @EnvironmentObject var locationService: LocationServiceImpl
    @EnvironmentObject var mapService: MapServiceImpl
    
    let location: Location?
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                // Background Image
                WebImage(url: URL(string: location?.locationPictureURL ?? ""))
                    .resizable()
                    .blur(radius: 2)
                    .background(.gray)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(location?.name ?? "Name")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(location?.subDescription ?? "Sub Description")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        if location?.joinedUsers.count ?? 0 > 1 {
                            
                            Text("\(location?.joinedUsers.count ?? 1) people active")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top)
                            
                        } else if location?.joinedUsers.count ?? 0 == 1 {
                            
                            Text("\(location?.joinedUsers.count ?? 10) person active")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top)
                        
                        } else {
                            
                            Text("No one is here yet")
                                .font(.title3) 
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top)
                        
                        }
                    }
                    .padding(40)
                    
                    Spacer()
                    
                    VStack {
                        if (mapService.closeTo.contains(where: { $0 == (location?.id ?? "") })) {
                            Button {
                                locationService.joinLocation(lid: location?.id ?? "")
                            } label: {
                                ZStack {
                                    Text("enter")
                                        .fontWeight(.bold)
                                }
                                .padding([.leading, .trailing], 30)
                                .padding([.top, .bottom], 10)
                                .buttonStyle(.plain)
                                .background(.white)
                                .cornerRadius(25)
                                .shadow(radius: 10)
                            }
                            .buttonStyle(.plain)
                        } else {
                            NavigationLink(destination: MapView()) {
                                ZStack {
                                    Text("show on map")
                                        .fontWeight(.bold)
                                }
                                .padding([.leading, .trailing], 30)
                                .padding([.top, .bottom], 10)
                                .buttonStyle(.plain)
                                .background(.white)
                                .cornerRadius(25)
                                .shadow(radius: 10)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 35)
                }
            
            }
            .cornerRadius(30)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .navigationBarHidden(true)
        .padding()
    }
}



struct SwipeLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeLocationsView(location: nil)
            .environmentObject(MapServiceImpl())
            .environmentObject(LocationServiceImpl())
    }
}