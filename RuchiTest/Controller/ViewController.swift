//
//  ViewController.swift
//  RuchiTest
//
//  Created by iMac on 20/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var myArray: [ListData] = []
    private var myTableView: UITableView!
    private var refreshControl:UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Addtableview()
        AddRefresh()
        GetData()
       
      
    }
    
     //MARK: Add tableview
    func Addtableview()
    {
               myTableView = UITableView(frame: .zero, style: .plain)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
               myTableView.dataSource = self
               myTableView.delegate = self
        myTableView.estimatedRowHeight = UITableView.automaticDimension
        myTableView.rowHeight = 500
      
               self.view.addSubview(myTableView)
        setupAutoLayout()
    }
    func setupAutoLayout() {

           myTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       }
   
    //Add refresh controller
    func AddRefresh()
    {
            refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshScreen), for: .valueChanged)
            myTableView.refreshControl = refreshControl
    }
    
    @objc func refreshScreen(refreshControl: UIRefreshControl) {
      GetData()
        refreshControl.endRefreshing()
    }
    
    //get data using json url
    func GetData()
    {
        myArray.removeAll()
        let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

        //Load json
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    //parse json
    private func parse(jsonData: Data) {
        let decoder = JSONDecoder()
  
            do {
                let rowData = try decoder.decode(DemoData.self, from: jsonData)
               
               
                myArray.append(contentsOf: rowData.rows)
                print(myArray)
                
                // Reload table view
                            OperationQueue.main.addOperation({
                                self.title = rowData.title ?? ""
                                self.myTableView.reloadData()
                            })
                
            } catch {
                print(error)
            }

    }

    //load json from url
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
              
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                    completion(.success(utf8Data!))
                }
            }
            
            urlSession.resume()
        }
    }
}

//MARK: Tableview delegate and datasource method
extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell\(indexPath.row)")
        let cell = myTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell\(indexPath.row)", for: indexPath) as! CustomTableViewCell
        
        cell.selectionStyle = .none
        
        if self.myArray.count > 0
        {
            let mdl = self.myArray[indexPath.row]
           
            cell.setData(data: mdl)
        }
              
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
