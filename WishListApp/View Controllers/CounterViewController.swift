//
//  CounterViewController.swift
//  WishListApp
//
//  Created by Ольга Горбачева on 15.11.21.
//

import UIKit
import Charts

class CounterViewController: UIViewController {
   
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var healthStepper: UIStepper!
    @IBOutlet weak var fastFoodStepper: UIStepper!
    
    var healtDataEntry = PieChartDataEntry(value: 0)
    var fastFoodDataEntry = PieChartDataEntry(value: 0)
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    
    @IBAction func countHealthFood(_ sender: UIStepper) {
        
        healtDataEntry.value = sender.value
        updateChartData()
        
    }
    
    @IBAction func countFastFood(_ sender: UIStepper) {
        fastFoodDataEntry.value = sender.value
        updateChartData()
        
    }
    
    func updateChartData () {
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
         let colors = [UIColor(named: "fastFoodColour"), UIColor(named: "healthFoodColour")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChart.chartDescription?.text = ""
        
        healtDataEntry.value = healthStepper.value
        healtDataEntry.label = "Health Food"
        
        
        fastFoodDataEntry.value = fastFoodStepper.value
        fastFoodDataEntry.label = "FastFood"
        
        numberOfDownloadsDataEntries = [healtDataEntry, fastFoodDataEntry]
        
        updateChartData()
    
    }
    
}

