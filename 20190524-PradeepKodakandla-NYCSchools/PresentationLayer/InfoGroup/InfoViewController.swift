//
//  InfoViewController.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import UIKit
import MessageUI
import MapKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var numOfTakersLbl: DesignableLabel!
    @IBOutlet weak var mathsAvgScoreLbl: DesignableLabel!
    @IBOutlet weak var readingAvgScoreLbl: DesignableLabel!
    @IBOutlet weak var writingAvgScoreLbl: DesignableLabel!
    
    var viewModel = infoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Information"
        registerCells()
    }
    
    func registerCells() {
        infoTableView.register(UINib(nibName: xibAndIdentifers.overviewCell,
                                     bundle: Bundle.main),
                               forCellReuseIdentifier:xibAndIdentifers.overviewXib)
        infoTableView.register(UINib(nibName: xibAndIdentifers.contactCell,
                                     bundle: Bundle.main),
                               forCellReuseIdentifier:xibAndIdentifers.contactXib)
        infoTableView.register(UINib(nibName: xibAndIdentifers.busCell,
                                     bundle: Bundle.main),
                               forCellReuseIdentifier:xibAndIdentifers.busXib)
        infoTableView.register(UINib(nibName: xibAndIdentifers.subwayCell,
                                     bundle: Bundle.main),
                               forCellReuseIdentifier:xibAndIdentifers.subwayXib)
    }
    
    //MARK: Contact cell Button Actions
    @objc func callTapped(sender: UIButton) {
        if let phoneNum = viewModel.selectedSchool?.phoneNumber,
            let phoneUrl = URL(string: "tel://\(phoneNum)") {
            openUrl(url: phoneUrl)
        }
    }
    
    @objc func mailTapped(sender: UIButton) {
        if let emailStr = viewModel.selectedSchool?.schoolEmail {
            launchEmail(with: emailStr)
        }
    }
    
    @objc func locationTapped(sender: UIButton) {
        
        if let lat = viewModel.selectedSchool?.latitude,
            let lon = viewModel.selectedSchool?.longitude {
            openMapForPlace(lat: Double(lat) ?? 00,
                            lon: Double(lon) ?? 00,
                            schlName: viewModel.selectedSchool?.schoolName ?? "")
        }
    }
    
    @objc func websiteTapped(sender: UIButton) {
        if let websiteLink = viewModel.selectedSchool?.website {
            let websiteUrl:URL?
            if websiteLink.hasPrefix("http://") {
                websiteUrl = URL(string: websiteLink)
            } else {
                websiteUrl = URL(string: "http://"+websiteLink)
            }
            openUrl(url: websiteUrl!)
        }
    }
    
    // Mark: Opening Maps by passing location attributes
    func openMapForPlace(lat: CLLocationDegrees, lon: CLLocationDegrees,
                         schlName: String) {
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(lat, lon)
        let regionSpan = MKCoordinateRegion(center: coordinates,
                                            latitudinalMeters: regionDistance,
                                            longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = schlName
        mapItem.openInMaps(launchOptions: options)
    }
    
    // Mark: Lunching MFMailComposeViewcontoller by populating School administration office Email ID
    func launchEmail(with email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            present(mail, animated: true)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: Email.errorAlertTitle,
                                                   message: Email.errorMessage,
                                                   preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "OK",
                                                   style: .default,
                                                   handler: { _ in
        }
        ))
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // Mark: Opening school website in safari browser
    func openUrl(url: URL) {
        UIApplication.shared.open(url)
    }

}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    //MARK: Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRows
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            return prepareOverviewCell(for: tableView ,at:indexPath)
        case 1:
            let contact = tableView.dequeueReusableCell(withIdentifier: xibAndIdentifers.contactXib) as! ContactTableViewCell
            contact.callButton.addTarget(self, action: #selector(callTapped(sender:)), for: .touchUpInside)
            contact.mailButton.addTarget(self, action: #selector(mailTapped(sender:)), for: .touchUpInside)
            contact.locationButton.addTarget(self, action: #selector(locationTapped(sender:)), for: .touchUpInside)
            contact.websiteButton.addTarget(self, action: #selector(websiteTapped(sender:)), for: .touchUpInside)

            return contact
        case 2:
            return prepareBusCell(for: tableView ,at:indexPath)
        case 3:
            return prepareSubwayCell(for: tableView ,at:indexPath)
        default:
            return cell
        }
    }
    
    //MARK: Delegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func prepareOverviewCell(for tableView: UITableView,
                             at indexPath: IndexPath) -> OverviewTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overview") as! OverviewTableViewCell
        cell.overViewLabel.numberOfLines = 0
        cell.overViewLabel.sizeToFit()
        cell.overViewLabel.text = viewModel.selectedSchool?.overview
        return cell
    }
    
    func prepareSubwayCell(for tableView: UITableView,
                             at indexPath: IndexPath) -> SubwayTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subway") as! SubwayTableViewCell
        cell.subway(with: viewModel.subwayArray)
        return cell
    }
    
    func prepareBusCell(for tableView: UITableView,
                           at indexPath: IndexPath) -> BusTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bus") as! BusTableViewCell
        cell.buses(with: viewModel.busArray)
        return cell
    }
}

