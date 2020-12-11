//
//  ListVC.swift
//  Technology_Assesment
//
//  Created by Haritej on 11/12/20.
//  Copyright © 2020 com.ipac.iOS. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private var getListData: ListResponseMaster?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        self.getDatafromServerAPI()
     //   self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    // MARK: - Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getListData?.results?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListVCCell", for: indexPath) as? ListVCCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.extraLabel.isHidden = true
        cell.title.text = getListData?.results?[indexPath.row].title
        cell.abstrct.text = getListData?.results?[indexPath.row].abstract
        cell.date.text = getListData?.results?[indexPath.row].published_date
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //API Call
    func getDatafromServerAPI() -> Void {
        SVProgressHUD.show()
        APIManager.getList(completion: { [weak self] (response,data,statusMsg,status,statusCode) in
            SVProgressHUD.dismiss()
            switch(response) {
            case .success(let sucess):
                self?.getListData = sucess
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
