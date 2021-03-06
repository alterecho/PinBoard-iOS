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
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var loadIndicator: LoadIndicator!
    
    private let refreshControl = UIRefreshControl(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
    
    private var fetchingImageData: Bool = false
    
    private var collectionData = [ImageData]() {
        didSet {
            if collectionData.count > 0 {
                collectionView.backgroundColor = UIColor.black
            } else {
                collectionView.backgroundColor = UIColor.clear
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        
        let layout = ImagePageLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: ViewController.CELL_ID)
        collectionView.refreshControl = refreshControl
        
        self.loadIndicator.isLoading = false
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
    
    /** used by refresh control */
    @objc func refreshControlAction() {
        fetchImageData(andAppend: false)
    }
    
    @objc private func fetchImageData(andAppend append: Bool) {
        if fetchingImageData {
            return
        }
        fetchingImageData = true
        let request = URLRequest(url: URL(string: "http://pastebin.com/raw/wgkJgazE")!)
        
        DownloadManager.shared().download(with: request) { [weak self] (imageDataArray: [ImageData], request, error) in
            if !append {
                self?.collectionData.removeAll()
            }
            self?.collectionData.append(contentsOf: imageDataArray)
            self?.refreshControl.endRefreshing()
            self?.collectionView.reloadData()
            self?.fetchingImageData = false
            self?.loadIndicator.isLoading = false
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == collectionView else {
            return
        }
        
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            self.loadIndicator.isLoading = true
            self.fetchImageData(andAppend: true)
        }
    }
}

