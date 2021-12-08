//
// MailView.swift
// CampusConnect (iOS)
//
// Created by Andy Park on 12/6/21.
//
import SwiftUI
import MessageUI
struct EmailView: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    var group: Group
    var students: [Student]
    var body: some View {
        VStack {
            if MFMailComposeViewController.canSendMail() {
                Button("Send CSV to email") {
                    self.isShowingMailView.toggle()
                }
            } else {
                Text("Can’t send emails from this device")
            }
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: self.$result) { composer in
                composer.setSubject(group.Name + " CSV File")
                composer.setToRecipients(["andyxpark@gmail.com"])
                var mailString = String()
                mailString.append("First, Last, Email, Grad, Major, Phone, School\n")
                for person in students {
                    mailString.append(person.First + "," + person.Last + "," + person.Email + "," + person.Grad + "," + person.Major + "," + person.Phone + "," + person.School + "\n")
                }
                let data = Data(mailString.utf8)
                composer.addAttachmentData(data, mimeType: "text/csv", fileName: group.Name + ".csv")
            }
        }
    }
}
