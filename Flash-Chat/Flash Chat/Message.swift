//
//  Message.swift
//  Flash Chat
//
//  This is the model struct that represents the blueprint for a message
//
//  Created by Tevin Mantock on 12/28/2017.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

struct Message {
    var sender : String?
    var message : String?
    
    init(sender : String, message : String) {
        self.sender = sender
        self.message = message
    }
}
