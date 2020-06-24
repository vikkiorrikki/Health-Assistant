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

    weak var delegate: TextFieldDelegate?
    var textFieldTag: TextFieldTag?
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
//        textField.addTarget(self, action: #selector(textFieldDidChange), for: .valueChanged)
    }    
    
    func updatePlaceholder(with placeholder: String, tag: TextFieldTag) {
        textField.placeholder = placeholder
        textFieldTag = tag
    }
    
    func updateCell(text: String, tag: TextFieldTag) {
        textField.text = text
        textFieldTag = tag
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        delegate?.userDidChangeTextField(with: textField.text ?? "", tag: textFieldTag!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
