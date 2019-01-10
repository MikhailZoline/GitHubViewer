//
//  CollectionViewController.swift
//  GitHubViewer
//
//  Created by Mikhail Zoline on 1/9/19.
//  Copyright © 2019 MZ. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,ViewModelProtocol, UIScrollViewDelegate, UITextFieldDelegate {
    
    var cellIdentifier = "cell"
    
    @IBOutlet var userTxtField: UITextField!
    @IBOutlet var collectionView: UICollectionView!
    weak var viewModel = ViewModel.viewModel
    @IBOutlet var segmentCtrl: UISegmentedControl!
    var list: Bool =  false
    
//    MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTxtField.delegate = self
        
        // ViewModel Init here
        viewModel!.delegate = self
        viewModel!.gitListUpdated()
        
        // CollectionView Self Sizing Cell Init here
//        let collectionFlowLayout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        collectionFlowLayout.estimatedItemSize = CGSize(width: 1, height:1)
//        collectionFlowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        segmentCtrl.addTarget(self, action: #selector(toggleGrid), for: .valueChanged)
    }
    
    @objc func toggleGrid(){
        self.list = self.list == false ? true : false
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    MARK: - textField Delegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewModel?.gitArray.removeAll()
        self.viewModel?.user = textField.text?.lowercased().trimmingCharacters(in: CharacterSet(charactersIn: " "))
        self.viewModel?.page = 1
        self.viewModel?.gitListUpdated()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }

    // MARK: - UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.gitArray.count ?? 0
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        configureCell(cell: cell, at: indexPath)
        
        return cell

    }
    
    func configureCell(cell: CollectionViewCell, at indexPath: IndexPath ) {
        if let gitSummary: GitHubView? = self.viewModel?.gitArray[indexPath.row]{
            cell.created.text = "created at: " + (gitSummary?.created_at != nil ? (gitSummary?.created_at)! : "nil" )
            cell.descr.text = "description : " + (gitSummary?.description != nil ? (gitSummary?.description)! : "nil")
            cell.license.text = "licence : " + (gitSummary?.license != nil ? (gitSummary?.license!.name!)! : "nil")
            cell.name.text = "name : " + (gitSummary?.name != nil ? (gitSummary?.name)! : "nil")
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    // MARK: - CollectionViewFlowLayout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = view.frame.height
        return CGSize(width: (width - 15)/(self.list == false ? 2 : 1), height: (height - 15)/(self.list == false ? 3 : 5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    // MARK: - ModelViewDelegate
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    // MARK: - ScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetMaxY: Float = Float(scrollView.contentOffset.y + scrollView.bounds.size.height)
        let contentHeight: Float = Float(scrollView.contentSize.height)
        
        let ret = contentOffsetMaxY > contentHeight - 100
        
        if ret {
            self.viewModel?.full == false ? self.viewModel?.gitListUpdated() : ()
        }
    }
}

