//
//  YodaTranslation.swift
//  YodaSpeak
//
//  Created by Michael Dautermann on 2/1/16.
//  Copyright © 2016 Michael Dautermann. All rights reserved.
//

import UIKit

class YodaTranslation: Translation {

    override init()
    {
        super.init()
        
        self.mashableKey = "QkZW0BHTTlmshjDExlCxV99ihLIPp1AB2u8jsnGph2xuefJBbF"
    }

    override func getUpperTextPlaceholder() -> String
    {
        return "Enter in text in Galactic Basic Standard (or English)"
    }
    
    override func getLowerTextPlaceholder() -> String
    {
        return "Yoda speak arrives here."
    }

    override func translateFromEnglishToDestination(fromString: NSString, closure: (data :String) -> ())
    {
        if let urlEncodedSentence = fromString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        {
            if let url = NSURL(string: "https://yoda.p.mashape.com/yoda/?sentence=\(urlEncodedSentence)")
            {
                performGetWithServer(url, closure: closure)
            }
        }
    }
}
