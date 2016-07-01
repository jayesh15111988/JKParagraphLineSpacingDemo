//
//  ViewController.swift
//  JKParagraphLineSpacingDemo
//
//  Created by Jayesh Kawli Backup on 7/1/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let textLabel = UILabel()
    let currentValueLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialSliderValue: Float = 5.0
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let contentView = UIView()
        contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        contentView.layer.borderWidth = 1.0
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let sliderView = UISlider()
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.addTarget(self, action: #selector(valueChanged), forControlEvents: UIControlEvents.ValueChanged)
        sliderView.minimumValue = 0
        sliderView.maximumValue = 36
        sliderView.setValue(initialSliderValue, animated: true)
        self.view.addSubview(sliderView)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "This demo will show you how to add line spacing using custom paragraph style with iOS. This is a great use of NSAttributedString to add necessary parameters to the string value.Hope you have enjoyed it"
        textLabel.textAlignment = .Center
        textLabel.numberOfLines = 0
        contentView.addSubview(textLabel)
        
        currentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        currentValueLabel.textAlignment = .Center
        self.view.addSubview(currentValueLabel)
        
        let views = ["scrollView": scrollView, "contentView": contentView, "textLabel": textLabel, "sliderView": sliderView, "currentValueLabel": currentValueLabel]
        let metrics = ["smallPadding": 10, "extraPadding": 20]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-44-[sliderView]-[currentValueLabel]-[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .Leading, relatedBy: .Equal, toItem: contentView, attribute: .Leading, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .Trailing, relatedBy: .Equal, toItem: contentView, attribute: .Trailing, multiplier: 1.0, constant: 0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-extraPadding-[textLabel]-extraPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-smallPadding-[currentValueLabel]-smallPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[textLabel]-extraPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-smallPadding-[sliderView]-smallPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        updateWithSpacing(initialSliderValue)
        
    }
    
    func valueChanged(slider: UISlider) {
        updateWithSpacing(slider.value)
    }
    
    func updateWithSpacing(lineSpacing: Float) {
        let attributedString = NSMutableAttributedString(string: textLabel.text!)
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = CGFloat(lineSpacing)
        if let stringLength = textLabel.text?.characters.count {
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: mutableParagraphStyle, range: NSMakeRange(0, stringLength))
        }
        textLabel.attributedText = attributedString
        currentValueLabel.text = String(format: "%.1f", lineSpacing)
    }

}

