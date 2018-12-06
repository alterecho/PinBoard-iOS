//
//  ViewController.swift
//  PinBoard
//
//  Created by echo on 2/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit
import Downloader

class ViewController: UIViewController {
    private static let CELL_ID = "cell"
    private var collectionData = [ImageData]() {
        didSet {
            if collectionData.count > 0 {
                collectionView.backgroundColor = UIColor.black
            } else {
                collectionView.backgroundColor = UIColor.clear
            }
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let refreshControl = UIRefreshControl(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
    
    private var fetchingImageData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(fetchImageData), for: .valueChanged)
        
        let layout = ImagePageLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: ViewController.CELL_ID)
        collectionView.refreshControl = refreshControl
        
//        self.fetchImageData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let parentSize = self.view.frame
            if parentSize.width > parentSize.height {
                layout.itemSize = CGSize(width: self.view.frame.size.width / 3.0, height: self.view.frame.size.width / 3.0)
            } else {
                layout.itemSize = CGSize(width: self.view.frame.size.width * 0.5, height: self.view.frame.size.width * 0.5)
            }
            
            layout.minimumLineSpacing = 0.0
            layout.minimumInteritemSpacing = 0.0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc private func fetchImageData() {
        if fetchingImageData {
            return
        }
        fetchingImageData = true
        let request = URLRequest(url: URL(string: "http://pastebin.com/raw/wgkJgazE")!)
        
        DownloadManager.shared().download(with: request) { [weak self] (imageDataArray: [ImageData], request, error) in
            self?.collectionData.removeAll()
            self?.collectionData.append(contentsOf: imageDataArray)
            self?.refreshControl.endRefreshing()
            self?.collectionView.reloadData()
            self?.fetchingImageData = false
            }.start()
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.CELL_ID, for: indexPath) as! ImageCell
        
        let imageData = collectionData[indexPath.row]
        cell.imageData = imageData
        return cell
    }
}

