//
//  StudentViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI
import simd

struct StudentViews: View {
    
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var groupViewModel: GroupsViewModel
    @State var sort: Int = 2
    @State var searchText = ""
    
	var sortResults: [Group] {
			if searchText.isEmpty {
					if sort == 1{
							return stuViewModel.activeGroups.sorted()
					}
					else if sort == 2 {
							return stuViewModel.activeGroups.sorted(by: { $0.Created < $1.Created } )
					}
					else if sort == 3 {
							return stuViewModel.activeGroups.sorted(by: { $0.Updated < $1.Updated } )
					}
					else{
							return stuViewModel.activeGroups.sorted() // default alphabetical
					}
			}
			else {
					return stuViewModel.activeGroups.filter { $0.Name.contains(searchText) }
			}
	}
    
    var body: some View {
        TabView{
            NavigationView{
                VStack{
                    List{
                        Section(header: Text("My Active Groups")){
                            ForEach(sortResults, id: \.self){ group in
															NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter, image: Image(uiImage: UIImage(data: Data(base64Encoded: groupViewModel.viewedGroupRecruiter.Picture, options: .ignoreUnknownCharacters)!) ?? UIImage())).onAppear(perform: { groupViewModel.getRecruiter(group: group) })) {
                                    GroupRow(group: group)
                                }
                            }
                        }
                    }
                    //                    .onAppear(perform: { stuViewModel.getActiveGroups(number: 1) })

                    .searchable(text: $searchText)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) { // <3>
                                            VStack {
                                                Text("Campus Connect").font(.title)
                                            }
                                        }
                            ToolbarItem(placement: .primaryAction) {
                                Menu {
                                    Picker(selection: $sort, label: Text("Sorting options")) {
																			Text("Alphabetical").tag(1)
																			Text("Date Created").tag(2)
																			Text("Date Updated").tag(3)
                                    }
                                }
                            label: {
                                Label("Sort", systemImage: "arrow.up.arrow.down")
                            }
                        }
                    }
                    List{
                        Section(header: Text("My Inactive Groups")){
                            ForEach(stuViewModel.inactiveGroups){ group in
                                NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter, image: Image(uiImage: UIImage(data: Data(base64Encoded: groupViewModel.viewedGroupRecruiter.Picture, options: .ignoreUnknownCharacters)!) ?? UIImage())).onAppear(perform: { groupViewModel.getRecruiter(group: group) })) {
                                    GroupRow(group: group)
                                }
                            }
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "list.bullet")
            }
            QRCode()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                }
            Profile(image: Image(uiImage: UIImage(data: Data(base64Encoded: stuViewModel.user.Picture, options: .ignoreUnknownCharacters)!) ?? UIImage()) )
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
            
        }
    }
}
