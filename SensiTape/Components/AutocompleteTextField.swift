//
//  AutocompleteTextField.swift
//  SensiTape
//
//  Created by Peyton McKee on 11/18/23.
//

import UIKit

class AutoCompleteTextField: UITextField {
    
    var datasource: [String]?
    var autocompleteDelegate: AutoCompleteTextFieldDelegate?
    
    private var currInput: String = ""
    private var isReturned: Bool = false
    
    var lightTextColor: UIColor = UIColor.systemGray {
        didSet {
            self.textColor = lightTextColor
        }
    }
    
    var boldTextColor: UIColor = UIColor.label
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        self.textColor = lightTextColor
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol AutoCompleteTextFieldDelegate {
    func provideDatasource()
    func returned(with selection: String)
    func textFieldCleared()
}

extension AutoCompleteTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.autocompleteDelegate?.provideDatasource()
        self.currInput = ""
        self.isReturned = false
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.updateText(string, in: textField)
        
        self.testBackspace(string, in: textField)
        
        self.findDatasourceMatch(for: textField)
        
        self.updateCursorPosition(in: textField)
        
        return false
    }
    
    private func updateText(_ string: String, in textField: UITextField) {
        self.currInput += string
        textField.text = self.currInput
    }
    
    private func testBackspace(_ string: String, in textField: UITextField) {
        let char = string.cString(using: String.Encoding.utf8)
        let isBackSpace: Int = Int(strcmp(char, "\u{8}"))
        if isBackSpace == -8 {
            self.currInput = String(self.currInput.dropLast())
            if self.currInput == "" {
                textField.text = ""
                self.autocompleteDelegate?.textFieldCleared()
            }
        }
    }
    
    private func findDatasourceMatch(for textField: UITextField) {
        guard let datasource = self.datasource?.map({$0.lowercased()}) else { return }
        let currInput = self.currInput.lowercased()
        
        let allOptions = datasource.filter({ $0.hasPrefix(currInput) })
        let exactMatch = allOptions.filter() { $0 == currInput }
        let fullName = exactMatch.count > 0 ? exactMatch.first! : allOptions.first ?? currInput
        if let range = fullName.range(of: currInput) {
            let nsRange = fullName.nsRange(from: range)
            let attribute = NSMutableAttributedString.init(string: fullName as String)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: self.boldTextColor, range: nsRange)
            textField.attributedText = attribute
        }
    }
    
    private func updateCursorPosition(in textField: UITextField) {
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: self.currInput.count) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.autocompleteDelegate?.returned(with: textField.text!)
        self.isReturned = true
        self.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignFirstResponder()
        if !isReturned {
            textField.text = ""
            self.currInput = ""
        } else {
            textField.textColor = boldTextColor
        }
    }
    
    
}

extension String {
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}
