//
//  MissionDetails.swift
//  XMissions-rest
//
//  Created by Hossein Akbari on 4/9/1400 AP.
//

import SwiftUI

struct MissionDetails: View {
    @ObservedObject var launchesVM: LaunchesViewModel
    let mission: LaunchModel
    
    init(mission: LaunchModel) {
        self.mission = mission
        self.launchesVM = LaunchesViewModel()
    }
    
    var body: some View {
        ZStack {
            Color("navy-blue").edgesIgnoringSafeArea([.top,.bottom])
            
            ScrollView {
                    
                ImageSliderView()
                
                VStack(spacing: 20) {
                    InformationView(mission: mission)
                    
                    if launchesVM.isLoading {
                        RocketInfo(rocket: nil)
                    } else if let rocket = launchesVM.rocket {
                        RocketInfo(rocket: rocket)
                    }
                    
                    

//                     SiteInfo(missionDetailVM: self.missionDetailVM)
                }
                .padding(.all, 15)
                
                Spacer()
            }
            .navigationBarTitle(mission.name ?? "Unkonwn")
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            self.launchesVM.getRocketData(rocketID: mission.rocket)
        }
    }
}



struct MissionDetails_Previews: PreviewProvider {
    static var previews: some View {
        MissionDetails(mission: LaunchModel(id: "", name: "Mission name", flight_number: 1, date_utc: "", success: false, links: nil, details: "", rocket: ""))
            .environmentObject(ContentVM())
    }
}