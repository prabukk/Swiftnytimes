//
//  Constants.swift
//  Swiftnytimes
//
//  Created by prabu.karuppaiah on 26/11/21.
//

import UIKit

class Constants: NSObject {
    
    //Constant
    static let kAuthorization = "Authorization"
    static let kBasic = "Basic YWRpZGFhczpEaXN5c0AzMjE="
    static let kNetwork = "Please check the network connection"
    static let kNoData = "No Data"

    //Tableviewcell
    static let kNewsEventDocumentTableViewCell = "NewsEventDocumentTableViewCell"

    //BaseUrl
    static let baseurl : String = "https://api.nytimes.com/"
    
    static let oneday : String = "svc/mostpopular/v2/viewed/1.json?api-key=dGy8xcuuGvXbEWtx319XijDyBUwNVDny"
    
    static let sevenday : String = "svc/mostpopular/v2/viewed/7.json?api-key=dGy8xcuuGvXbEWtx319XijDyBUwNVDny"
    
    static let thirtyday : String = "svc/mostpopular/v2/viewed/30.json?api-key=dGy8xcuuGvXbEWtx319XijDyBUwNVDny"

    
}
