//
//  CandidateScrollerView.swift
//  Emoji-IME
//
//  Created by Wuhua Dai on 15/2/15.
//  Copyright (c) 2015年 wua. All rights reserved.
//

import UIKit

protocol CandidateScrollerViewDelegate {
    func didRecivedInputString(string:String)
}

class CandidateScrollerView: UIScrollView {
    var inputDelegate: CandidateScrollerViewDelegate?
    var candidateScrollViewHeightConstraint: NSLayoutConstraint!
    var buttons: [UIButton] = []
    func updateButtonsWithStrings(strings: [String]) {
        for button in buttons {
            button.removeFromSuperview()
        }
        buttons = []
        for string in strings {
            let button = UIButton.buttonWithType(.System) as UIButton
            button.setTitle(string, forState: .Normal)
            button.sizeToFit()
            button.titleLabel!.font = UIFont.systemFontOfSize(15)
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            button.backgroundColor = UIColor.greenColor()
            button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
            buttons.append(button)
            self.addSubview(button)
        }
        
        for (index, button) in enumerate(buttons) {
            //add constraints
            let t = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
            let b = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
            self.addConstraints([t,b])
            
            var l: NSLayoutConstraint
            if (index == 0) {
                l = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
            } else {
                l = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: buttons[index-1], attribute: .Right, multiplier: 1, constant: 1)
            }
            self.addConstraints([l])
            
            if (index == buttons.count - 1) {
                let r = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
                self.addConstraints([r])
            }
        }
    }

    func didTapButton(sender: AnyObject?) {
        let button = sender as UIButton
        let title = button.titleForState(.Normal)
        inputDelegate?.didRecivedInputString(title!)
    }
}

extension CandidateScrollerView: EmojiImputDelegate {
    func didRecivedEmojiStrings(strings: [String]?) {
        if candidateScrollViewHeightConstraint == nil {
            candidateScrollViewHeightConstraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 32)
            self.addConstraints([candidateScrollViewHeightConstraint])
        }
        if strings == nil || strings!.count == 0 {
            candidateScrollViewHeightConstraint.constant = 0;
        } else {
            candidateScrollViewHeightConstraint.constant = 32;
            updateButtonsWithStrings(strings!)
        }
    }
}