//
//  PlaceholderTextView.swift
//  YodaSpeak
//
//  Created by Michael Dautermann on 2/1/16.
//  Copyright © 2016 Michael Dautermann. All rights reserved.
//

import UIKit

class PlaceholderTextView: UITextView, UITextViewDelegate {
    
    override var text: String! {
        didSet {
            if text != ""
            {
                checkAndSet(self)
            }
        }
    }

    var placeholderString : String = "" {
        didSet {
            checkAndSet(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        let tapDismiss = UITapGestureRecognizer(target: self, action: "toggleKeyboard")
        self.addGestureRecognizer(tapDismiss)
        
        self.delegate = self
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?)
    {
        super.init(frame: frame, textContainer: textContainer)
        
        let tapDismiss = UITapGestureRecognizer(target: self, action: "toggleKeyboard")
        self.addGestureRecognizer(tapDismiss)
        
        self.delegate = self
    }
    
    func toggleKeyboard()
    {
        // use gesture recognizer to dismiss the keyboard
        // if this text view already has focus
        if self.isFirstResponder()
        {
            self.resignFirstResponder()
        } else {
            self.becomeFirstResponder()
        }
    }
    
    func checkAndSet(textView: UITextView)
    {
        if (textView.text == "") {
            textView.text = self.placeholderString ?? "Placeholder"
            textView.textColor = UIColor.lightGrayColor()
        } else {
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        checkAndSet(textView)
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView){
        if (textView.text == self.placeholderString ?? "Placeholder"){
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        textView.becomeFirstResponder()
    }
    
}

