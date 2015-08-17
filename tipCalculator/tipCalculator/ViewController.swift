//
//  ViewController.swift
//  tipCalculator
//
//  Created by Dan Tong on 8/17/15.
//  Copyright (c) 2015 DanTong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipAmountPerPerson: UILabel!
    @IBOutlet weak var peopleIconLabel: UILabel!
    @IBOutlet weak var tipPersonView: UIView!
    @IBOutlet weak var tipPercentSlider: UISlider!
    
    var tipPercent:Int = 10
    var billAmount: Double = 0.0
    var tipAmount: Double = 0.0
    var totalAmount: Double = 0.0
    var numberOfPeople: Int = 1
    var didLoadBefore: Bool = false
    
    // Save tip value
    var defaults = NSUserDefaults.standardUserDefaults()
    // Locale
    var formatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        billAmountTextField.placeholder = formatter.stringFromNumber(0)
        
        // Do any additional setup after loading the view, typically from a nib.
        showOrHidePersonTip(false)
        didLoadBefore = defaults.boolForKey("didLoadBefore")
        if didLoadBefore != true {
            defaults.setBool(true, forKey: "didLoadBefore")
            defaults.setInteger(10, forKey: "tipPercent")
            defaults.setDouble(0, forKey: "billAmount")
            defaults.synchronize()
            println("Set default value")
        }
        else {
            initUpdateValues()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        // Add auto focus on textfield
        billAmountTextField.becomeFirstResponder()
    }
    override func viewDidDisappear(animated: Bool) {
        defaults.setDouble(billAmount, forKey: "billAmount")
        defaults.setInteger(tipPercent, forKey: "tipPercent")
        defaults.synchronize()

    }
    @IBAction func onTextChanging(sender: UITextField) {
        updateAmount()
    }
    @IBAction func tipPercentSliderOnChanged(sender: UISlider) {
        tipPercentLabel.text = String(format: "%d%%",Int(sender.value))
        tipPercent = Int(sender.value)
        updateAmount()
        
    }
    
    @IBAction func peopleOnChanged(sender: UISlider) {
        numberOfPeople = Int(sender.value)
        tipAmountPerPerson.text = String(format: "$%0.2f", tipAmount/Double(numberOfPeople))
        switch numberOfPeople {
        case 1:
            peopleIconLabel.text = "👩"
        case 2:
            peopleIconLabel.text = "👩👩"
        case 3:
            peopleIconLabel.text = "👩👩👩"
        case 4:
            peopleIconLabel.text = "👩👩👩👩"
        case 5:
            peopleIconLabel.text = "👩👩👩👩👩"
        default:
            peopleIconLabel.text = "👩"
        }
    }
    
    func updateAmount(){
        if billAmountTextField.text != "" {
            billAmount  = Double((billAmountTextField.text as NSString).floatValue)
            tipAmount   = billAmount * Double(tipPercent)/100
            totalAmount = billAmount + tipAmount
            tipLabel.text = formatter.stringFromNumber(tipAmount)
            totalAmountLabel.text = formatter.stringFromNumber(totalAmount)
            tipAmountPerPerson.text = formatter.stringFromNumber(tipAmount/Double(numberOfPeople))
            showOrHidePersonTip(true)
            
            defaults.setDouble(billAmount, forKey: "billAmount")
            defaults.setInteger(tipPercent, forKey: "tipPercent")
            defaults.synchronize()
            
        } else {
            showOrHidePersonTip(false)
        }
    }
    func initUpdateValues(){
        billAmount = defaults.doubleForKey("billAmount")
        tipPercent = defaults.integerForKey("tipPercent")
        tipAmount   = billAmount * Double(tipPercent)/100
        totalAmount = billAmount + tipAmount
        tipPercentSlider.value = Float(tipPercent)
        
        tipPercentLabel.text = String(format: "%d%%",Int(tipPercentSlider.value))
        
        billAmountTextField.text = formatter.stringFromNumber(billAmount)
        tipLabel.text = formatter.stringFromNumber(tipAmount)
        totalAmountLabel.text = formatter.stringFromNumber(totalAmount)
        tipAmountPerPerson.text = formatter.stringFromNumber(tipAmount/Double(numberOfPeople))
        showOrHidePersonTip(true)
    }
    
    func showOrHidePersonTip(isShow: Bool){
        if isShow {
            UIView.animateWithDuration(0.8, animations: {
                self.tipPersonView.transform = CGAffineTransformMakeTranslation(0, 0)
            })
        }
        else {
            UIView.animateWithDuration(0.8, animations: {
                self.tipPersonView.transform = CGAffineTransformMakeTranslation(0, self.tipPersonView.frame.height+100)
            })
        }
    }
    // MARK: Keyboard hide on Tap
    @IBAction func onTapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

