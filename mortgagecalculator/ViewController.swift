//
//  ViewController.swift
//  mortgagecalculator
//
//  Created by Admin on 21/07/23.
//  Copyright © 2023 Admin. All rights reserved.
//

import UIKit

enum LoanDuration:String{
    case select = "Select a Duration"
    case fiveYears = "5 Years"
    case tenYears = "10 Years"
    case fifteenYears = "15 Years"
    case twentyYears = "20 Years"
    case twentyFiveYears = "25 Years"
    case thirtyYears = "30 Years"
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let durationOptions = [LoanDuration.select.rawValue, LoanDuration.fiveYears.rawValue,LoanDuration.tenYears.rawValue, LoanDuration.fifteenYears.rawValue,LoanDuration.twentyYears.rawValue,LoanDuration.twentyFiveYears.rawValue,
                           LoanDuration.thirtyYears.rawValue]
    var rateMap : [String:Double] = [:]
    
    var loanAmount: Int = 300000
    var rate:Double = 100.0
    var tenure: Int = 30*12

    @IBOutlet weak var homeValueTextEntry: UITextField!
    @IBOutlet weak var downPaymentTextEntry: UITextField!
    @IBOutlet weak var mortgageAmount: UILabel!
    @IBOutlet weak var rateAPR: UILabel!
    @IBOutlet weak var loanDurationPicker: UIPickerView!
    @IBOutlet weak var mortgageLable: UILabel!
    
    @IBAction func amtDisplay(_ sender: UIButton) {
        
        if let homeValueStr = homeValueTextEntry.text, let downPaymentStr = downPaymentTextEntry.text {
            if let homeValue = Int(homeValueStr), let downPayment = Int(downPaymentStr) {
                loanAmount = homeValue - downPayment
                mortgageAmount.text = "$\(loanAmount)"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        populateRateMap()
        loanDurationPicker.delegate = self
        loanDurationPicker.dataSource = self
    }
    
    private func populateRateMap(){
        for duration in durationOptions {
            switch duration{
            case LoanDuration.fiveYears.rawValue:
                rateMap[LoanDuration.fiveYears.rawValue] = 2.75
                
            case LoanDuration.tenYears.rawValue:
                rateMap[LoanDuration.tenYears.rawValue] = 2.75
                
            case LoanDuration.fifteenYears.rawValue:
                rateMap[LoanDuration.fifteenYears.rawValue] = 2.75
                
            case LoanDuration.twentyYears.rawValue:
                rateMap[LoanDuration.twentyYears.rawValue] = 2.75
                
            case LoanDuration.twentyFiveYears.rawValue:
                rateMap[LoanDuration.twentyFiveYears.rawValue] = 2.75
                
            case LoanDuration.thirtyYears.rawValue:
                rateMap[LoanDuration.thirtyYears.rawValue] = 3.00
            default:
                rateMap[LoanDuration.select.rawValue] = 100.00
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durationOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return durationOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch durationOptions[row]{
        case LoanDuration.fiveYears.rawValue:
            self.tenure = 5 * 12
            
        case LoanDuration.tenYears.rawValue:
            self.tenure = 10 * 12
            
        case LoanDuration.fifteenYears.rawValue:
            self.tenure = 15 * 12
        
        case LoanDuration.twentyYears.rawValue:
            self.tenure = 20 * 12
            
        case LoanDuration.twentyFiveYears.rawValue:
            self.tenure = 25 * 12
            
        case LoanDuration.thirtyYears.rawValue:
            self.tenure = 30 * 12
        default:
            self.tenure = 30 * 12
        }
        if let currentRate = rateMap[durationOptions[row]]{
            self.rate = currentRate
            rateAPR.text = "\(currentRate)%"
        }
    }

    @IBAction func computeMortgage(_ sender: UIButton) {
        mortgageLable.text =  "Monthly Mortgage: $\(Mortgage().computeMortgage(collateral: self.createCollateralModel()))"
    }
    private func createCollateralModel() -> Collateral {
        return Collateral(loanDuration: self.tenure, loanAmount: self.loanAmount, rateAPR: self.rate)
    }
    
}
  
