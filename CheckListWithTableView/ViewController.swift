import UIKit

class ViewController: UIViewController {
    
    class CheckList {
        var title: String
        var isChecked: Bool = false
        
        init(title: String) {
            self.title = title
        }
    }
    
    let items: [CheckList] = [
        "Need to revise the tableview",
        "Project on TableView",
        "Gym",
        "Movie time",
        "Need to go shopping",
        "Cooking",
        "Family time",
        "Need to go for a walk",
        "Need to do Laundry",
        "Need to clean the house"
    ].compactMap({ CheckList(title: $0) })
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .black
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "CheckList"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 30, weight: .bold),
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.barTintColor = .black

            navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        
        setupFooterView()
    }
    
    private func setupFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        footerView.backgroundColor = .black
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 70, width: footerView.frame.width, height: 50))
            searchBar.placeholder = "Search"
        searchBar.barStyle = .default
            searchBar.backgroundImage = UIImage() // Removes the default background
            searchBar.searchTextField.textColor = .white // Set text color
            footerView.addSubview(searchBar)

        let label = UILabel(frame: footerView.bounds)
        label.text = "CheckList Footer"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        footerView.addSubview(label)

        tableView.tableHeaderView = footerView // Use as footer
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.accessoryType = item.isChecked ? .checkmark : .none
        cell.selectionStyle = .none
        
        // Remove any existing border view to prevent duplication
        cell.contentView.subviews.forEach { if $0.tag == 999 { $0.removeFromSuperview() } }
        
        // Add a bottom border
        let border = UIView(frame: CGRect(x: 0, y: cell.contentView.frame.height - 1, width: cell.contentView.frame.width, height: 1))
        border.backgroundColor = .white
        border.tag = 999 // Add a tag to identify the border
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        cell.contentView.addSubview(border)
        
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        item.isChecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        if offset > 50 {
            navigationItem.title = "CheckList"
        } else {
            navigationItem.title = ""
        }
    }
}

