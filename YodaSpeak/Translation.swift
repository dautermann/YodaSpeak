//
//  Translation.swift
//  YodaSpeak
//
//  Created by Michael Dautermann on 1/31/16.
//  Copyright © 2016 Michael Dautermann. All rights reserved.
//

// a base class into which we can put different kinds of Translation API's.

import UIKit

class Translation: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate
{
    var reverseTranslationAvailable : Bool = false
    var urlSession : NSURLSession
    var mashableKey : String = ""
    
    override init()
    {
        // initialize urlSession to SOMETHING just to get us by super.init
        urlSession = NSURLSession.sharedSession()
        
        super.init()
        
        // now reset URLSession to the proper thing
        urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    }

    func getUpperTextPlaceholder() -> String
    {
        return ""
    }
    
    func getLowerTextPlaceholder() -> String
    {
        return ""
    }
    
    func translateFromEnglishToDestination(fromString: NSString, closure: (data :String) -> ())
    {

    }
    
    func translateFromDestinationToEnglish(fromString: NSString, closure: (data :String) -> ())
    {

    }

    func performGetWithServer(url: NSURL, closure: (toString :String) -> ())
    {
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("text/plain", forHTTPHeaderField: "Accept")
        request.addValue(self.mashableKey, forHTTPHeaderField: "X-Mashape-Key")
        
        let task = urlSession.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let dataFromServer = data
            {
                if let translatedString = NSString(data: dataFromServer, encoding: NSUTF8StringEncoding) as? String
                {
                    closure(toString: translatedString)
                }
            } else {
                // unexpected error response data might go here...
                print("Response: \(response)")
            }
        })
        task.resume()
    }
}
