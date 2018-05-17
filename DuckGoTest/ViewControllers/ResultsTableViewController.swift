//
//  ResultsTableViewController.swift
//  DuckGoTest
//
//  Created by Raphael Araújo on 2018-05-16.
//  Copyright © 2018 Raphael Araújo. All rights reserved.
//

import UIKit
import SDWebImage
class ResultsTableViewController: UITableViewController {
    var results: [DuckGoResultItem] = [DuckGoResultItem]()
    let apiClient = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 96
        
        loadData()
    }
    
    func loadData() {
        apiClient.searchFor(string: "apple") { (completed, results, error) in
            guard let e = error else {
                if let r = results?.results {
                    let filteredResults = r.filter({ (item) -> Bool in
                        item.text != nil
                    }).prefix(20)
                    self.results.append(contentsOf: filteredResults)
                }
                if let relatedTopics = results?.relatedTopics {
                    self.results.append(contentsOf: relatedTopics.filter({ (item) -> Bool in
                        item.text != nil
                    }).prefix(20 - self.results.count))
                    
                    for relatedTopic in relatedTopics {
                        if let topics = relatedTopic.topics {
                            self.results.append(contentsOf: topics.filter({ (item) -> Bool in
                                item.text != nil
                            }).prefix(20 - self.results.count))
                        }
                    }
                }
                self.tableView.reloadData()
                return
            }
            
            print(">>> Error: \(e) <<<")
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        let item: DuckGoResultItem = results[indexPath.row]
        
        if let urlString = item.icon?.url, let url = URL(string: urlString) {
            if urlString != "" {
                cell.iconImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "cat"), options: .scaleDownLargeImages, completed: {(image, error, cacheType, _) in
                    cell.iconImageView?.clipsToBounds = true
                })
            }
        } else {
            cell.iconImageView?.image = UIImage(named: "cat")
        }
        
        cell.item = item
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = results[indexPath.row]
        self.performSegue(withIdentifier: "urlContentSegue", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "urlContentSegue" {
            if let destinationVC = segue.destination as? WebViewController {
                destinationVC.item = sender as! DuckGoResultItem
            }
        }
    }
}
