//
//  GroupRow.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct GroupRow: View {
    //@ObservedObject var viewModel = StudentsViewModel()
    var group: Group
    
    var body: some View {
        HStack {
          Text("Name:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(group.Name) //group.name
            .padding(.trailing)
        }.padding()
    }
}
