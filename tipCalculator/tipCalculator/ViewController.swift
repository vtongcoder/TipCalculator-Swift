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
    
    var tipPercent:Int = 10
    var billAmount: Double = 0.0
    var tipAmount: Double = 0.0
    var totalAmount: Double = 0.0
    var numberOfPeople: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showOrHidePersonTip(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTextChanging(sender: UITextField) {
//        if sender.text != "" {
//            billAmount      = Double(sender.text.toInt()!)
//            tipAmount       = billAmount * tipPercent
//            totalAmount     = billAmount + tipAmount
//            tipLabel.text = String(format: "$%0.1f",tipAmount)
//            totalAmountLabel.text = String(format: "$%0.1f",totalAmount)
//            tipAmountPerPerson.text = String(format: "$%0.2f", tipAmount/Double(numberOfPeople))
//        }
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
            billAmount  = Double(billAmountTextField.text.toInt()!)
            tipAmount   = billAmount * Double(tipPercent)/100
            totalAmount = billAmount + tipAmount
            tipLabel.text = String(format: "$%0.1f",tipAmount)
            totalAmountLabel.text = String(format: "$%0.1f",totalAmount)
            tipAmountPerPerson.text = String(format: "$%0.2f", tipAmount/Double(numberOfPeople))
            showOrHidePersonTip(true)
        } else {
            showOrHidePersonTip(false)
        }

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

