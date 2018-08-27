//
//  StructFile.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation


struct Top250Model : Codable {
    
    let count :Int
    let start:Int
    let total:Int
    let title:String
    let subjects:[Subjects]

    struct Subjects:Codable {
        struct Rating:Codable {
            let max:Int
            let average:float_t
            let stars:String
            let min:Int
        }
        let rating:Rating
        let title:String
        let casts:[Cast]

        struct Cast : Codable {
            let alt:String
            let name:String
            let id:String
            let avatars:Avatar
        }

        struct Avatar : Codable {
            let small:String
            let large:String
            let medium:String
        }

        let collect_count:Int
        let original_title:String
        let subtype:String
        let directors:[Director]
        struct Director:Codable {

            let alt:String
            let avatars:Avatar
            let name:String
            let id:String
        }

        let year:String
        struct Images:Codable {
            let small:String
            let large:String
            let medium:String
        }
        let images:Images
        let alt:String
        let id:String
    }
    
}
