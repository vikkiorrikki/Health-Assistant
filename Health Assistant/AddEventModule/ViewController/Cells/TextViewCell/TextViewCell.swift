//
//  TextViewCell.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 16.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        textView.text = "Notes"
        textView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Notes"
            textView.textColor = UIColor.lightGray
        }
    }
}
