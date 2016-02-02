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
    
    // this outlet is used to bump the down arrow button to the left a little bit
    // to center things in a more friendly way when the up arrow
    // is visible and it's functionality is available.
    @IBOutlet var buttonCenterXConstraint : NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder)
    {
        // we could add in some UI (e.g. a picker?) to easily
        // switch API's to L33tTranslation or text-to-speech (where the 
        // Translation actually pipes the audio data through the speaker 
        // while returning some string)
        // translationObject = YodaTranslation.init() // L33tTranslation.init()
        translationObject = L33tTranslation.init()

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
            self.upperTextView.text = toString
        }
    }
}

