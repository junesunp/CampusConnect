//
//  ContentView.swift
//  Shared
//
//  Created by John Park on 10/28/21.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
          DispatchQueue.main.async {
            self?.signedIn = true
          }
            
        }
    }
    
    func signUp(email: String, password: String, username: String, fname: String, lname: String, schoolName: String, major: String, gradYear: String){
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
        guard let strongSelf = self else { return }
        DispatchQueue.main.async {
          self?.signedIn = true
        }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
}


struct ContentView: View {
    private func studentRowView(student: Student) -> some View{
      VStack(alignment: .leading){
          
        Text(student.First)
        Text(student.Last)
        Text(student.School)
        Text(student.Major)

      }
    }
    
    @EnvironmentObject var sviewModel: AppViewModel
    @ObservedObject var viewModel = StudentsViewModel()
    var body: some View {
        TabView{
            if sviewModel.signedIn {
                List {
                    Text(viewModel.user.Email)
                    Text(viewModel.user.First)
                    Text(viewModel.user.Last)
                    Button(action: {
                        sviewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color.blue)
                            .background(Color.green)
                    })
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                }
                VStack{
                    Text("QR Code")
                    ForEach(viewModel.students) {
                      student in
                        Image(uiImage: viewModel.createQRCode(from: student.Email))
                    }
                }
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                }
                VStack{
                    Text(viewModel.user.First)
                    Text(viewModel.user.Last)
                    Text(viewModel.user.School)
                }
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
                
            }
            else{
                SignInView()
            }
        }
        .onAppear {
            sviewModel.signedIn = sviewModel.isSignedIn
        }
    }
  
  init(){
    viewModel.fetchStudents()
    viewModel.fetchStudent()
  }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var sviewModel: AppViewModel

    @ObservedObject var viewModel = StudentsViewModel()
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        sviewModel.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    NavigationLink("Create Account", destination: StartSignUpView())
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Sign In")
        }
    }
}

struct StartSignUpView: View {
    @State var email = ""
    @State var username = ""
    @State var password = ""
    @State var fname = ""
    @State var lname = ""
    var gradYear = ["2022", "2023", "2024", "2025"]
    @State private var selectedYearIndex = 0
    @State var schoolName = ""
    @State var major = ""
    
    
    @EnvironmentObject var sviewModel: AppViewModel

    @ObservedObject var viewModel = StudentsViewModel()
    var body: some View {
        NavigationView {
//            VStack {
                VStack {
                    TextField("First Name", text: $fname)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    TextField("Last Name", text: $lname)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    NavigationLink("Next", destination: SchoolSignUpView())
//                    Button(action: {
//                        guard !email.isEmpty, !password.isEmpty else {
//                            return
//                        }
//                        sviewModel.signUp(email: email, password: password)
//                    }, label: {
//                        Text("Create Account")
//                            .foregroundColor(Color.white)
//                            .frame(width: 200, height: 50)
//                            .cornerRadius(8)
//                            .background(Color.blue)
//                    })
                }
                .padding()
                //Spacer()
            }
            .navigationTitle("Create Account")
        }
    }
// }

struct SchoolSignUpView: View {
    @State var email = ""
    @State var username = ""
    @State var password = ""
    @State var fname = ""
    @State var lname = ""
    @State var major = ""
    var gradYear = ["2022", "2023", "2024", "2025"]
    @State private var selectedYearIndex = 0
    @State var schoolName = ""
    
    @EnvironmentObject var sviewModel: AppViewModel

    @ObservedObject var viewModel = StudentsViewModel()
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    TextField("School", text: $schoolName)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Picker(selection: $selectedYearIndex, label: Text("")) {
                        ForEach(0 ..< gradYear.count) {
                           Text(self.gradYear[$0])
                        }
                     }
                     Text("Your Graduation Year: \(gradYear[selectedYearIndex])")
                    TextField("major", text: $major)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    //NavigationLink("Next", destination: SchoolSignUpView())
                    Button(action: {
//                        guard !email.isEmpty, !password.isEmpty else {
//                            return
//                        }
                        sviewModel.signUp(email: email, password: password, username: username, fname: fname, lname: lname, schoolName: schoolName, major: major, gradYear: gradYear[selectedYearIndex])
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                }
                .padding()
                Spacer()
            }
//            .navigationTitle("Create Account")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
