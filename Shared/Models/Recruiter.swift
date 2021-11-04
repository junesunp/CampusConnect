//
//  Recruiter.swift
//  CampusConnect
//
//  Created by Thomas Choi on 11/2/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct Recruiter: Identifiable, Codable {
    
  @DocumentID var id: String? = UUID().uuidString
  var Email: String
  var First: String
  var Last: String
  var Phone: String
  var Company: String
  var Position: String
  var Password: String
    
  enum CodingKeys: String, CodingKey {
    case id
    case Email
    case First = "FName"
    case Last = "LName"
    case Phone
    case Company
    case Position
    case Password
  }
    
}
