//
//  QRCode.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct QRCode: View {
    
    @EnvironmentObject var stuViewModel : StudentsViewModel
    
    var body: some View {
        VStack{
            Text("QR Code")
                .fontWeight(.bold)
            Image(uiImage: stuViewModel.createQRCode(from: stuViewModel.user.Email))
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
