//
//  NewsEntity.swift
//  Swiftnytimes
//
//  Created by prabu.karuppaiah on 26/11/21.
//

import Foundation

struct NewsResponse:Codable {
    
    var status: String?
    var copyright: String?
    var num_results : Int?
    var results: [NewsDetail]?
}

struct NewsDetail:Codable {
    
    var uri: String?
    var url: String?
    var id: Double?
    var asset_id: Double?
    var source: String?
    var published_date: String?
    var updated: String?
    var section: String?

    var subsection: String?
    var nytdsection: String?
    var adx_keywords: String?
    var column: String?
    var byline: String?
    var type: String?
    var title: String?

    var abstract: String?
    var des_facet: [String]?
    var org_facet: [String]?
    var per_facet: [String]?
    var geo_facet: [String]?
    var media: [MediaDetail]?
    var eta_id: Int?

}

struct MediaDetail:Codable {
    
    var type: String?
    var subtype: String?
    var caption: String?
    var copyright: String?
    var approved_for_syndication: Int?
    var mediametadata: [MediaDataDetail]?

}


struct MediaDataDetail:Codable {
    
    var url: String?
    var format: String?
    var height: Int?
    var width: Int?
    
}
