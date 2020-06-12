//
//  ViewController.swift
//  NASAImages
//
//  Created by Cristian Gochi on 11/06/20.
//  Copyright © 2020 JoseNieves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dateCell = Date()

    @IBOutlet weak var tableView: UITableView!
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dateString = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)?.textLabel?.text
        dateCell = formatter.date(from: dateString!)!
        if let vc = segue.destination as? DetailiewController {
            vc.date = dateCell
        }
    }


}

extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = Date(timeInterval: -60 * 60 * 24 * Double(indexPath.row), since: .init())
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = formatter.string(from: date)
        return cell
    }
}
