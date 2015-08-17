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
    
    var tipPercent:Double = 0.1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTextChanging(sender: UITextField) {
        if sender.text != "" {
            let billAmount: Double = Double(sender.text.toInt()!)
            let tipAmount: Double = billAmount * tipPercent
            let totalAmount : Double = billAmount + tipAmount
            tipLabel.text = String(format: "$%0.1f",tipAmount)
            totalAmountLabel.text = String(format: "$%0.1f",totalAmount)
        }
    }
    
    func updateAmount(){
        if billAmountTextField.text != "" {
            let billAmount: Double = Double(billAmountTextField.text.toInt()!)
            let tipAmount: Double = billAmount * tipPercent
            let totalAmount : Double = billAmount + tipAmount
            //            println("Amount: \(billAmount) , \(tipAmount) , \(totalAmount)")
            tipLabel.text = String(format: "$%0.1f",tipAmount)
            totalAmountLabel.text = String(format: "$%0.1f",totalAmount)
        }

    }
    @IBAction func tipPercentSliderOnChanged(sender: UISlider) {
        tipPercentLabel.text = String(format: "%0.f%%",sender.value)
        tipPercent = Double(sender.value)/100
        updateAmount()
        
    }
    
    // MARK: Keyboard hide on Tap
    @IBAction func onTapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

