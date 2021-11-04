//
//  Group.swift
//  CampusConnect
//
//  Created by Thomas Choi on 11/2/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct Group: Identifiable, Codable {
    
  @DocumentID var id: String? = UUID().uuidString
  var Created: Date
  var Updated: Date
  var Name: String
  var Description: String?
  var Recruiter: String
  var Students: [String]?
    
  enum CodingKeys: String, CodingKey {
    case id
    case Created
    case Updated
    case Name = "Name"
    case Description
    case Recruiter
    case Students
  }
    
}
