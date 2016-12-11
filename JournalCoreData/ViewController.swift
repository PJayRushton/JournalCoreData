//
//  ViewController.swift
//  JournalCoreData
//
//  Created by Parker Rushton on 12/10/16.
//  Copyright © 2016 AppsByPJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuseID = "journalCell"
    
    var journals: [Journal] {
        return CoreDataHelper.shared.getJournals()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        dump(journals)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        addNewJournal()
    }
    
    func addNewJournal() {
        let newNumber = journals.filter { $0.title.contains("New") }.count + 1
        CoreDataHelper.shared.addJournal(title: "New Journal \(newNumber)")
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        let journal = journals[indexPath.row]
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries.count)"
        
        return cell
    }
    
}
