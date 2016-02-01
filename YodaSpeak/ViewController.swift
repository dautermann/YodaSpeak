//
//  ViewController.swift
//  YodaSpeak
//
//  Created by Michael Dautermann on 1/31/16.
//  Copyright © 2016 Michael Dautermann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var upArrowButton : UIButton!
    @IBOutlet var upperTextView : PlaceholderTextView!
    @IBOutlet var lowerTextView : PlaceholderTextView!
    
    var translationObject : Translation
    
    // we'll use this to bump the down arrow button to the left a little bit
    // to center things a bit more friendly
    @IBOutlet var buttonCenterXConstraint : NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder)
    {
        translationObject = YodaTranslation.init()
        
        super.init(coder: aDecoder)
    }

    override func viewWillAppear(animated: Bool)
    {
        let showUpArrow = translationObject.reverseTranslationAvailable
        self.upArrowButton.hidden = (showUpArrow == false) // hide up arrow if reverseTranslationAvailable is false
        
        if showUpArrow
        {
           buttonCenterXConstraint.constant = -40
        } else {
            buttonCenterXConstraint.constant = 0
        }
        
        self.upperTextView.placeholderString = translationObject.getUpperTextPlaceholder()
        self.lowerTextView.placeholderString = translationObject.getLowerTextPlaceholder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func translateToButtonTouched(sender: UIButton)
    {
        if sender == upArrowButton
        {
            translationObject.translateFromDestinationToEnglish(lowerTextView.text, closure: self.untranslateCompleted)
        } else {
            translationObject.translateFromEnglishToDestination(upperTextView.text, closure: self.translationCompleted)
        }
    }

    func translationCompleted(toString: String)
    {
        dispatch_async(dispatch_get_main_queue()) {
            // update UI on main thread
            self.lowerTextView.text = toString
        }
    }
    
    func untranslateCompleted(toString: String)
    {
        dispatch_async(dispatch_get_main_queue()) {
            // update UI on main thread
            self.upperTextView.text = toString
        }
    }
}

