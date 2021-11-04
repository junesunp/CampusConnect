//
//  Scanner.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/3/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct Scanner: View {
  
  func handleScan(result: Result<String, CodeScannerView.ScanError>) {
    self.isShowingScanner = false
  }
  
  @State private var isShowingScanner = false
  
    var body: some View {
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      Button(action: {
        self.isShowingScanner = true
      }) {
        Image(systemName: "qrcode.viewfinder")
        Text("Scan")
      }
      .sheet(isPresented: $isShowingScanner) {
        CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
      }
    }
}
