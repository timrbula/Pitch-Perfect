//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Tim Bula on 10/17/15.
//  Copyright © 2015 Tim Bula. All rights reserved.
//

import Foundation

final class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL
    var title: String?
    
    //constructor for class, takes the NSURL and String and sets them to instance variables
    //string is optional value
    init(filePathUrl: NSURL, title: String?) {
    
        self.filePathUrl = filePathUrl
        
        if let title = title {
            self.title = title
        
        } else {
            print("Title for RecordedTitle object is nil")
        
        }
    
    }
    

}