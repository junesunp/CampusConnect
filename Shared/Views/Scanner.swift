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
    
  @ObservedObject var groupViewModel = GroupsViewModel()
  var group: Group
    
  func handleScan(result: Result<String, CodeScannerView.ScanError>) {
    self.isShowingScanner = false
    switch result {
    case .success(let code):
        let details = code.components(separatedBy: "")
        
        groupViewModel.addStudent(group: group, studentId: details[0])
    case .failure(let error):
        print("Scanning failed")
    }
  }
  
  @State private var isShowingScanner = false
  
    var body: some View {
      Button(action: {
        self.isShowingScanner = true
      }) {
        Image(systemName: "qrcode.viewfinder")
        Text("Scan")
      }
      .sheet(isPresented: $isShowingScanner) {
        CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
      }
    }
}
