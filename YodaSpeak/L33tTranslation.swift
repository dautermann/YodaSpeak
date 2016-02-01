//
//  L33tTranslation.swift
//  YodaSpeak
//
//  Created by Michael Dautermann on 2/1/16.
//  Copyright © 2016 Michael Dautermann. All rights reserved.
//

import UIKit

class L33tTranslation: Translation {

    override init()
    {
        super.init()
        
        self.mashableKey = "o87pnEh1sKmshz8UgYKRrE1EmDuNp1KNPMEjsn7oJKTawBrw9j"
        
        self.reverseTranslationAvailable = true
    }
    
    override func getUpperTextPlaceholder() -> String
    {
        return "Enter in plain text English"
    }
    
    override func getLowerTextPlaceholder() -> String
    {
        return "7ru3 h@Ck3r text here."
    }
    
    override func translateFromEnglishToDestination(fromString: NSString, closure: (data :String) -> ())
    {
        if let urlEncodedSentence = fromString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        {
            if let url = NSURL(string: "https://montanaflynn-l33t-sp34k.p.mashape.com/encode=\(urlEncodedSentence)")
            {
                performGetWithServer(url, closure: closure)
            }
        }
    }
    
    override func translateFromDestinationToEnglish(fromString: NSString, closure: (data :String) -> ())
    {
        if let urlEncodedSentence = fromString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        {
            if let url = NSURL(string: "https://montanaflynn-l33t-sp34k.p.mashape.com/decode=\(urlEncodedSentence)")
            {
                performGetWithServer(url, closure: closure)
            }
        }
    }
}
