//
//  SchoolsViewController.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import UIKit

class SchoolsViewController: UIViewController {
    let cellIdentifier = "SchoolCell"
    @IBOutlet weak var schoolsTableView: UITableView!
    
    var viewModel: SchoolsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SchoolsViewModel()
        schoolsTableView.estimatedRowHeight = 100
        fetchData()
    }
    
    // 
    internal func fetchData() {
        //API call to get the schools
        ActivityIndicator.showActivityIndicator(view: self.view)
        viewModel?.getAllSchoolsList(completion: { (error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.schoolsTableView.reloadData()
                    ActivityIndicator.hideActivityIndicator(view: self.view)
                }
            } else {
                self.showAlert(with: error!)
            }
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

}

extension SchoolsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numOfSections ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? schoolTableViewCell else {
                                                        let cell = schoolTableViewCell()
                                                        return cell
        }
        viewModel?.data(at: indexPath.row)
        cell.schoolNameLbl.text = viewModel?.schoolName
        cell.addressLbl.text = viewModel?.location
        cell.gradesLbl.text = viewModel?.subtitle
        cell.satScoreButton.tag = indexPath.row
        cell.satScoreButton.addTarget(self,
                                      action: #selector(showScoreTapped(sender:)),
                                      for: .touchUpInside)
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let infoVC = UIStoryboard.viewControllerFrom(storyboard: .main,
                                                        withIdentifier: StoryboardID.infoController) as! InfoViewController
        viewModel?.data(at: indexPath.row)
        infoVC.viewModel.selectedSchool = viewModel?.schl
        self.navigationController?.pushViewController(infoVC, animated: true)

    }
    
    //MARK: UIButton Action
    @objc func showScoreTapped(sender: UIButton) {
        let satRsltVC = UIStoryboard.viewControllerFrom(storyboard: .main,
                                                     withIdentifier: StoryboardID.resultsVc) as! SATResultsViewController
        viewModel?.data(at: sender.tag)
        satRsltVC.viewModel.selectedSchool = viewModel?.schl
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .coverVertical
        self.present(satRsltVC, animated: true, completion: nil)
    }
}
