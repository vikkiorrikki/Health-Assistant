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

class TextFieldTableViewCell: UITableViewCell {

    weak var delegate: TextFieldDelegate?
    var textFieldTag: TextFieldTag?
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        textField.addTarget(self, action: #selector(textFieldDidChange), for: .valueChanged)
    }    
    
    func updateCell(with text: String, tag: TextFieldTag) {
        textField.placeholder = text
        textFieldTag = tag
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        delegate?.userDidChangeTextField(with: (sender as AnyObject).text ?? "", tag: textFieldTag!)
    }

}
