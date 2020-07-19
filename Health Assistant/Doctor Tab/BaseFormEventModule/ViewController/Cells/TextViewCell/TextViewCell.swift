//
//  TextViewCell.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 16.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

protocol TextViewDelegate: class {
    func userDidChangeTextView(with text: String?)
}

class TextViewCell: UITableViewCell, UITextViewDelegate {

    weak var delegate: TextViewDelegate?
    @IBOutlet weak var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        textView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    @objc func keyboardWillHide() {
//        delegate.view.frame.origin.y = 0
//    }
//
//    @objc func keyboardWillChange(notification: NSNotification) {
//
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if textView.isFirstResponder {
//                self.view.frame.origin.y = -keyboardSize.height
//            }
//        }
//    }
    
    func updateCell(with text: String?, delegate: TextViewDelegate?) {
        self.delegate = delegate
        
        if let text = text {
            textView.text = text
        } else {
            textView.textColor = UIColor.lightGray
            textView.text = "Notes"
        }
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        delegate?.userDidChangeTextView(with: textView.text)
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
            delegate?.userDidChangeTextView(with: nil)
        }
    }
    
    @objc func tapDone(sender: Any) {
        self.textView.endEditing(true)
    }

}

extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
