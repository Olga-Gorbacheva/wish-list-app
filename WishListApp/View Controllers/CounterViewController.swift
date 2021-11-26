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
    
    var waterDataEntry = PieChartDataEntry(value: 0)
    var coffeeDataEntry = PieChartDataEntry(value: 0)
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    
    @IBAction func countHealthFood(_ sender: UIStepper) {
        
        waterDataEntry.value = sender.value
        updateChartData()
        
    }
    
    @IBAction func countFastFood(_ sender: UIStepper) {
        coffeeDataEntry.value = sender.value
        updateChartData()
    }
    
    func updateChartData () {
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
         let colors = [UIColor(named: "fastFoodColour"), UIColor(named: "healthFoodColour")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
        pieChart.centerText = "Food"
        pieChart.entryLabelColor = .black
        pieChart.entryLabelFont = .italicSystemFont(ofSize: 18)
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let backGroundImage = UIImageView(frame: UIScreen.main.bounds)
        backGroundImage.image = UIImage(named: "fontCounter")
        backGroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backGroundImage, at: 0)
        
        backGroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backGroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        pieChart.chartDescription?.text = ""
        
        waterDataEntry.value = healthStepper.value
        waterDataEntry.label = "Water"
        
        
        coffeeDataEntry.value = fastFoodStepper.value
        coffeeDataEntry.label = "Coffee"
        
        numberOfDownloadsDataEntries = [waterDataEntry, coffeeDataEntry]
        
        updateChartData()
    
    }
    
}

