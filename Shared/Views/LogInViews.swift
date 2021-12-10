//
//  LogInViews.swift
//  CampusConnect (iOS)
//
//  Created by Obi Nnaeto on 11/18/21.
//
import SwiftUI
import FirebaseAuth


// different users in your app
enum UserType {
    case recruiter
    case student
}

protocol UserData {
    var userType: UserType { get }
}

struct RecruiterUserData: UserData {
    let userType: UserType = .recruiter
}

struct StudentUserData: UserData {
    let userType: UserType = .student
}


class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var role = "Student"
    @Published var isStudent = true
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    var userID: String {
        return auth.currentUser!.uid
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard authResult != nil, error == nil else { return }
            // ...
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
    func signUp(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard authResult != nil, error == nil else { return }
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

struct LogInViews: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var sviewModel: AppViewModel
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    
    @State var asStudent = true
    @State var isSignedIn = true
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("AppIconImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    if isSignedIn == false{
                        Text("Incorrect credentials")
                            .padding()
                            .foregroundColor(.red)
                            .background(Color.black)
                            .font(Font.body.bold())
                            .cornerRadius(8)
                        
                    }
                    
                    ZStack {
                        Toggle("Sign in as..", isOn: $asStudent)
                            .onChange(of: asStudent) { value in
                                if sviewModel.role == "Student"{
                                    sviewModel.role = "Recruiter"
                                }
                                else{
                                    sviewModel.role = "Student"
                                }
                            }
                        
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(asStudent ? Color.green: Color.blue, lineWidth: 2) // <7>
                            )
                        if asStudent {
                            Text("Student")
                        }
                        else{
                            Text("Recruiter")
                        }
                    }
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                            stuViewModel.verifyLoginEmail(email: email, role: sviewModel.role)
                        if stuViewModel.correctUserType {
                            sviewModel.signIn(email: email, password: password)
                            
                            if sviewModel.role == "Student"{
                                stuViewModel.fetchStudent(currID: email)
                            }
                            else{
                                recViewModel.fetchRecruiter(email: email)
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1
                        ) {
                            if sviewModel.isSignedIn == false{
                                self.isSignedIn = false
                            }
                        }
                        
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                    })
                    .cornerRadius(8)

                    NavigationLink("Create Account", destination: StartSignUpView())
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Welcome!")
        }
    }
}
struct StartSignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var fname = ""
    @State var lname = ""
    var gradYear = ["2022", "2023", "2024", "2025"]
    @State private var selectedYearIndex = 0
    @State var schoolName = ""
    @State var major = ""
    
    
    @EnvironmentObject var sviewModel: AppViewModel
    @EnvironmentObject var stuViewModel: StudentsViewModel
    var body: some View {
        //NavigationView {
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
            NavigationLink(destination: SchoolSignUpView(email: $email, password:$password, fname:$fname, lname:$lname)) {
                Text("I want to be recruited")
                    .padding(15)
                    .frame(width: 250)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(8
                    )
            }
            .padding([.leading, .trailing], 30)
            .padding([.top], 21)
            .frame(height: 50)
            .simultaneousGesture(TapGesture().onEnded{
                sviewModel.role = "Student"
            })
            .padding()
            Text("OR...").bold()
                .padding()
            
            NavigationLink(destination: RecruiterSignUpView(email: $email, password:$password, fname:$fname, lname:$lname)) {
                Text("I want to be a recruiter")
                    .padding(15)
                    .frame(width: 250)
                    .background(Color.white)
                    .foregroundColor(Color.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
            .padding([.leading, .trailing], 30)
            .padding([.top], 21)
            .frame(height: 50)
            .simultaneousGesture(TapGesture().onEnded{
                sviewModel.role = "Recruiter"
            })
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                VStack {
   //                 Text("Create Account").font(.largeTitle).bold()
                    //Text("Subtitle").font(.subheadline)
                }
            }}
        .padding()
        //Spacer()
    }
    
    //.navigationTitle("Create Account")
    //}
}
struct SchoolSignUpView: View {
    @Binding var email : String
    @Binding var password : String
    @Binding var fname : String
    @Binding var lname : String
    @State var major = ""
    var gradYear = ["2022", "2023", "2024", "2025"]
    @State private var selectedYearIndex = 0
    @State var schoolName = ""
    let auth = Auth.auth()
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var sviewModel: AppViewModel
    var body: some View {
        VStack {
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
            Button(action: {
                stuViewModel.createStudent(id: email, email: email, password: password, fname: fname, lname: lname, schoolName: schoolName, major: major, gradYear: gradYear[selectedYearIndex])
                sviewModel.signUp(email: email, password: password)
                stuViewModel.fetchStudent(currID: email)
            }, label: {
                Text("Create Account")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
            })
                .cornerRadius(8)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Create Account").font(.largeTitle).bold()
                        }
                    }}
                .padding()
        }
    }
}

struct RecruiterSignUpView: View {
    @Binding var email : String
    @Binding var password : String
    @Binding var fname : String
    @Binding var lname : String
    @State var company = ""
    @State var position = ""
    var gradYear = ["2022", "2023", "2024", "2025"]
    @State private var selectedYearIndex = 0
    @State var schoolName = ""
    let auth = Auth.auth()
    //@ObservedObject var sviewModel =  AppViewModel()
    @EnvironmentObject var sviewModel: AppViewModel
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    var body: some View {
        //        NavigationView {
        //VStack {
        VStack {
            TextField("Company", text: $company)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Position/Role", text: $position)
                .padding()
                .background(Color(.secondarySystemBackground))
            Button(action: {
                recViewModel.createRecruiter(id: email, email: email, password: password, fname: fname, lname: lname, company: company, role: position)
                recViewModel.fetchRecruiter(email: email)
                sviewModel.signUp(email: email, password: password)
                
            }, label: {
                Text("Create Account")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
            })
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Create Account").font(.largeTitle).bold()
                            //Text("Subtitle").font(.subheadline)
                        }
                    }}
            //}
                .padding()
        }
    }
}



struct LogInViews_Previews: PreviewProvider {
    static var previews: some View {
        LogInViews()
            .environmentObject(AppViewModel())
            .environmentObject(StudentsViewModel())
            .environmentObject(RecruitersViewModel())
            .environmentObject(GroupsViewModel())
    }
}
