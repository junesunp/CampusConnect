//
//  RecruiterProfile.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct RecruiterProfile: View {
    
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    @EnvironmentObject var sviewModel: AppViewModel
    
    var body: some View {
        VStack{
            HStack {
                Text(recViewModel.user.Email)
                    .fontWeight(.bold)
            }.padding()
            Button(action: {
                sviewModel.signOut()
            }, label: {
                Text("Logout")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
            })
        }
    }
}
