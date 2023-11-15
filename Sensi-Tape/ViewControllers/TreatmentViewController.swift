//
//  TreatmentViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/14/23.
//

import UIKit

class TreatmentViewController: UIViewController, ErrorHandler{
    @IBOutlet var HeaderView: HeaderView!
    @IBOutlet var treatmentDescriptionLabel: UILabel!
    @IBOutlet var recommendationVideoCollectionView: UICollectionView!
    
    lazy var recommendationVideoCollectionViewContainer: CollectionViewContainer =
    CollectionViewContainer(CollectionViewConfig(function: Model.shared.openLink), self.recommendationVideoCollectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recommendationVideoCollectionViewContainer.setFlowlayout(CollectionViewFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 10, minimumLineSpacing: 10))
        self.getAllRecommendations()
    }
    
    private func getAllRecommendations() {
        APIHandler.shared.queryData(route: Route.allRecommendations(), completion: {
            result in
            do {
                let recommendations: [Recommendation] = try result.get()
                DispatchQueue.main.async{
                    self.recommendationVideoCollectionViewContainer.setOptions(recommendations.map({CollectionViewCellConfig(link: $0.link, title: $0.name)}))
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
        })
    }
}
