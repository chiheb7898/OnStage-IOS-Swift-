//
//  StageRoomViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 08/04/2022.
//

import UIKit

struct VideoModel{
    let caption : String
    let username: String
    let tags: String
    let videoFileName: String
    let videoFileFormat: String
}

class StageRoomViewController: UIViewController {
    
    
    //var
    private var data = [VideoModel]()
    
    
    
    //widgets
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<10 {
            let model = VideoModel(caption: "New Project",
                                   username: "@Chikhaoui_Chiheb",
                                   tags: "#Startup #Success",
                                   videoFileName: "trialVid",
                                   videoFileFormat: "mp4")
            data.append(model)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    

}

extension StageRoomViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier,
                                                      for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
}

extension StageRoomViewController: VideoCollectionViewCellDelegate {
    func didTapLikeButton(with model: VideoModel) {
        print("liked")
    }
    
    func didTapProfileButton(with model: VideoModel) {
        print("profile")
    }
    
    func didTapShareButton(with model: VideoModel) {
        print("share")
    }
    
    func didTapCommentButton(with model: VideoModel) {
        print("comment")
    }
    
    
}
