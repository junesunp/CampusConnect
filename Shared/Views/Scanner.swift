//
// Scanner.swift
// CampusConnect (iOS)
//
// Created by Andy Park on 11/3/21.
//
import SwiftUI
import CodeScanner
import UserNotifications
struct Scanner: View {
    @EnvironmentObject var groupViewModel : GroupsViewModel
    @EnvironmentObject var recViewModel : RecruitersViewModel
    @State var status = 1
    var group: Group
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        var flag: Bool = false
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "")
            if let stringArray = details as? [String] {
                for s in details[0] {
                    if s == "@" {
                        groupViewModel.addStudent(group: group, studentId: details[0])
                        flag = true
                        status = 2
                    }
                }
                if flag == false {
                    print("Scanning failed")
                    status = 3
                }
            }
            else {
                print("Scanning failed")
                status = 3
            }
        case .failure(let error):
            print("Scanning failed")
            status = 3
        }
    }
    @State private var isShowingScanner = false
    var body: some View {
        VStack {
            if status == 2 {
                Text("Successfully added student").foregroundColor(.green)
            }
            else if status == 3 {
                Text("Failed to add student").foregroundColor(.red)
            }
            Button(action: {
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan").padding()
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
            }

        }
    }
}
