//
//  SATResultsViewController.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import UIKit

class SATResultsViewController: UIViewController {

    var viewModel = SATRsltViewModel()
    @IBOutlet weak var numOfTakersLbl: DesignableLabel!
    @IBOutlet weak var mathsAvgScoreLbl: DesignableLabel!
    @IBOutlet weak var readingAvgScoreLbl: DesignableLabel!
    @IBOutlet weak var writingAvgScoreLbl: DesignableLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mark: Initiating request to fetch all school info from given URL.
        fetchResult()
    }

    
    func fetchResult(){
        //API call to get the schools
        ActivityIndicator.showActivityIndicator(view: self.view)
        viewModel.getSatResults(for: viewModel.selectedDbn,
                                completion: { (error) in
                                    if error == nil {
                                        DispatchQueue.main.async {
                                            if let resutl = self.viewModel.resultData {
                                                self.updateSatResultView(result: resutl)
                                            }
                                        }
                                    } else {
                                        self.showAlert(with: error!)
                                    }
                                    ActivityIndicator.hideActivityIndicator(view: self.view)
                                    
        })
    }
    
    internal func showAlert(with error:Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {
            //            self.accountTableView.backgroundView = self.noResultsView
            ActivityIndicator.hideActivityIndicator(view: self.view)
        })
    }
    
    func updateSatResultView(result: SATResult?) {
        if (result != nil) {
            numOfTakersLbl.text = result?.numOfTestTakers
            mathsAvgScoreLbl.text = result?.mathAvgScore
            readingAvgScoreLbl.text = result?.readingAvgScore
            writingAvgScoreLbl.text = result?.writingAvgScore
        }
    }
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
