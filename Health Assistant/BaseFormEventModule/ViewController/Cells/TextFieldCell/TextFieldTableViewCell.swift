//
//  TextFieldTableViewCell.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 14.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

protocol TextFieldDelegate: class {
    func userDidChangeTextField(with text: String, tag: TextFieldTag)
}

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    private weak var delegate: TextFieldDelegate?
    private var textFieldTag: TextFieldTag?
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func updateCell(text: String?, tag: TextFieldTag, delegate: TextFieldDelegate?) {
        
        self.delegate = delegate
        
        switch tag {
        case .title:
            textField.placeholder = "Title"
        case .doctorsName:
            textField.placeholder = "Doctors Name"
        }
        
        textField.text = text
        textFieldTag = tag
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        guard let tag = textFieldTag else {
            return
        }
        delegate?.userDidChangeTextField(with: textField.text ?? "", tag: tag)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
