//
//  Models.swift
//  Kindle
//
//  Created by Tevin Mantock on 10/24/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import UIKit

class Book {
    let title: String
    let author: String
    let pages: [Page]
    let imageUrl: String
    
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.imageUrl = dictionary["coverImageUrl"] as? String ?? ""
        var bookPages = [Page]()
        
        if let pagesDictionary = dictionary["pages"] as? [[String: Any]] {
            for page in pagesDictionary {
                if let text = page["text"] as? String {
                    bookPages.append(Page(number: 1, text: text))
            
                }
            }
        }
        
        self.pages = bookPages
    }
}

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
