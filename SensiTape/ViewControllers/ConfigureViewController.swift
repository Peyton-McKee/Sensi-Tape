//
//  ViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/4/23.
//

import UIKit

class ConfigureViewController: UIViewController, ErrorHandler {
    private lazy var loadingScreen = LoadingScreen(frame: self.view.frame)
    private var recommendations : [Recommendation] = []
    private var pickerOptions : [String] = ["Right Foot", "Left Foot"]
    
    @IBOutlet var configurationStackView: UIStackView!
    @IBOutlet var temperatureSlider: UISlider!
    @IBOutlet var compressionSlider: UISlider!
    @IBOutlet var footPickerView: UIPickerView!
    
    @IBOutlet var activityGraphView: LineGraphView!
    
    @IBOutlet var tapeStatusStackView: UIStackView!
    @IBOutlet var batteryImageView: UIImageView!
    @IBOutlet var connectionStatusImageView: UIImageView!
    
    @IBOutlet var recommendationTableView: UITableView!
    
    @IBOutlet var profileButton: UIBarButtonItem!
    
    private lazy var graphTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    
    private let logoutAction: UIAction = UIAction(title: "Log Out") {
        action in
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.userId.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.compressionValue.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.temperatureValue.rawValue)
        let storyboard = UIStoryboard(name: StoryboardId.storyboardId.rawValue, bundle: nil)
        let logInViewController = storyboard.instantiateViewController(identifier: StoryboardId.logInViewController.rawValue)
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(logInViewController)
    }
    
    private lazy var profileMenu: UIMenu = {
        let menu = UIMenu(children: [self.logoutAction])
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentUser()
        self.getAllRecommendations()
        self.recommendationTableView.dataSource = self
        self.recommendationTableView.delegate = self
        self.footPickerView.delegate = self
        self.footPickerView.dataSource = self
        self.styleSections()
        self.setBatteryImageFor(value: 56.5)
        self.configureButtons()
        self.addLogoToNavigationBarItem()
        //        self.mockInputs()
    }
    
    func mockInputs () {
        DispatchQueue.global().async{
            while true {
                let rand = Int.random(in: 0..<10000)
                if (rand <= 100) {
                    self.setBatteryImageFor(value: Float(rand))
                }
                
            }
        }
    }
    
    private func getCurrentUser() {
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultKey.userId.rawValue) else {
            self.handle(error: UserError.notSignedInError)
            return
        }
        APIHandler.shared.queryData(route: Route.userById(userId: userId), completion: {
            result in
            do {
                Model.shared.setCurrentUser(try result.get())
                DispatchQueue.main.async {
                    self.setDefaults()
                }
            } catch {
                DispatchQueue.main.async{
                    self.handle(error: error)
                }
            }
        })
    }
    
    private func getAllRecommendations() {
        APIHandler.shared.queryData(route: Route.allRecommendations(), completion: {
            result in
            do {
                self.recommendations = try result.get()
                DispatchQueue.main.async{
                    self.recommendationTableView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
        })
    }
    
    @objc func handleTap() {
        performSegue(withIdentifier: StoryboardId.graphSegue.rawValue, sender: self)
    }
    
    private func setDefaults() {
        let compressionValue = UserDefaults.standard.float(forKey: UserDefaultKey.compressionValue.rawValue)
        self.compressionSlider.setValue(compressionValue, animated: false)
        let temperatureValue = UserDefaults.standard.float(forKey: UserDefaultKey.temperatureValue.rawValue)
        self.temperatureSlider.setValue(temperatureValue, animated: false)
        
        guard let selectedFoot = UserDefaults.standard.string(forKey: UserDefaultKey.selectedFoot.rawValue), let pickerRow = self.pickerOptions.firstIndex(of: selectedFoot) else {
            return
        }
        self.footPickerView.selectRow(pickerRow, inComponent: 0, animated: false)
        self.setWifiImageFor(connected: false)
        
        do {
            let currentUserData = try Model.shared.getCurrentUser().data.filter({ $0.dataTypeName == RequiredDataType.FRONT_ANKLE_TEMP.rawValue }).map({ CGFloat($0.value) })
            self.activityGraphView.setAndRefreshData(dataPoints: [currentUserData])
        } catch {
            self.handle(error: error)
        }

    }
    
    private func styleSections() {
        StyleManager.styleViews([self.batteryImageView, self.connectionStatusImageView, self.configurationStackView, self.recommendationTableView, self.activityGraphView])
        
        StyleManager.styleTableView(self.recommendationTableView)

        self.recommendationTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        
        self.batteryImageView.tintColor = .gray
        self.activityGraphView.addGestureRecognizer(self.graphTap)
    }
    
    private func configureButtons() {
        profileButton.menu = profileMenu
    }
    
    @IBAction func temperatureSliderChanged (sender: UISlider) {
        UserDefaults.standard.setValue(sender.value, forKey: UserDefaultKey.temperatureValue.rawValue)
    }
    
    @IBAction func compressionSliderChanged (sender: UISlider) {
        UserDefaults.standard.setValue(sender.value, forKey: UserDefaultKey.compressionValue.rawValue)
    }
    
    private func setBatteryImageFor(value: Float) {
        if (value >= 95) {
            self.batteryImageView.image = .init(systemName: "battery.100")
        } else if (value >= 65) {
            self.batteryImageView.image = .init(systemName: "battery.75")
        } else if (value >= 40) {
            self.batteryImageView.image = .init(systemName: "battery.50")
        } else if (value >= 15) {
            self.batteryImageView.image = .init(systemName: "battery.25")
        } else {
            self.batteryImageView.image = .init(systemName: "battery.0")
            self.batteryImageView.tintColor = .red
        }
    }
    
    private func setWifiImageFor(connected: Bool) {
        if (connected) {
            self.connectionStatusImageView.image = .init(systemName: "wifi")
        } else {
            self.connectionStatusImageView.image = .init(systemName: "wifi.slash")
        }
    }
}

extension ConfigureViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recommendations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.recommendationTableViewCell.rawValue, for: indexPath) as! RecommendationTableViewCell
        cell.setLabelText(self.recommendations[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: self.recommendations[indexPath.row].link) else {
            self.handle(error: ConfigurationError.InvalidLink)
            return
        }
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableViewHeaderView()
        view.setTitleLabelText("Recommendations")
        return view
    }
}

extension ConfigureViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.setValue(self.pickerOptions[row], forKey: UserDefaultKey.selectedFoot.rawValue)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.pickerOptions[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

extension ConfigureViewController {

    func addLogoToNavigationBarItem() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: "sun.min")

        // In order to center the title view image no matter what buttons there are, do not set the
        // image view as title view, because it doesn't work. If there is only one button, the image
        // will not be aligned. Instead, a content view is set as title view, then the image view is
        // added as child of the content view. Finally, using constraints the image view is aligned
        // inside its parent.
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
