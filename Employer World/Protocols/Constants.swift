//
//  Constants.swift
//  Employer World
//
//  Created by Abhishek Maurya on 23/07/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation
import UIKit

let PROFILESTATUS                       =   "ProfileStatus"
let PROFILESTATUSLOGIN                  =   "login"
let PROFILESTATUSSIGNUP                 =   "signup"
let PROFILESTATUSPROFILE                =   "profile"

let APPTITLE                            =   "Employer World"
let EMPLOYEEDETAILSTITLE                =   "Employee Details"
let GALLERYTITLE                        =   "Gallery"
let GOOGLEIMAGESEARCHTITLE              =   "Google Images"
let PHOTOPREVIEWTITLE                   =   "Preview"
let MAPSTITLE                           =   "Maps"
let LOGINTITLE                          =   "Login"
let RESETPASSWORDTITLE                  =   "Reset Password"
let SIGNUPTITLE                         =   "Signup"
let PROFILETITLE                        =   "Profile"

let PULLTOREFRESHMESSAGE                =   "Pull to refresh"

let THEMECORNERRADIUS: CGFloat          =   4
let SHADOWOFFSET                        =   CGSize(width: 1.0, height: 1.0)

let CUSTOMEMPLOYEECELLXIBNAME           =   "CustomEmployeeCell"
let CUSTOMEMPLOYEECELLNAME              =   "employeeCell"

let CUSTOMGALLERYCELLXIBNAME            =   "CollectionGalleryCell"
let CUSTOMGALLERYCELLNAME               =   "galleryCell"

let FIRSTTIMEKEY                        =   "isFirstTime"
let LOGINKEY                            =   "isLoggenIn"

let BLANKSTRING                         =   ""
let NULLVALUE                           =   "0"


let EMPLOYEEBASEURL                     =   "http://dummy.restapiexample.com/api/v1/employees"

let GOOGLECUSTOMSEARCHSBASEURL          =   "https://www.googleapis.com/customsearch/v1"
let GOOGLECX                            =   "018004629090563794309:4-knw3rlcoo"         // "018004629090563794309:4-knw3rlcoo"
let GOOGLEKEY                           =   "AIzaSyDIUO4kqd6rHZEbNg5-phC6z6-jmHD0jLI"   // "AIzaSyDFTIW28gbTwjayShhM2M7qy5ar7RWIqY8"

let PROFILEBASEURL                      =   "https://qa.curiousworld.com/api/v3"
let EMAILVALIDATIONURL                  =   PROFILEBASEURL + "/Validate/Email?_format=json"
let LOGINURL                            =   PROFILEBASEURL + "/Login?_format=json"
let FORGOTEMAILURL                      =   PROFILEBASEURL + "/ForgetPassword?_format=json"
let SIGNUPURL                           =   PROFILEBASEURL + "/SignUp"


let UserDefault                         =   UserDefaults.standard

enum CheckStatus: String {
    case correct = "✓"
    case incorrect = "✗"
    case unknown = "?"
    case none = ""
}

