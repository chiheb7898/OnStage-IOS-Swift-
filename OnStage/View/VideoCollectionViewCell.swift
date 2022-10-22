//
//  VideoCollectionViewCell.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 12/04/2022.
//

import UIKit
import AVFoundation

protocol VideoCollectionViewCellDelegate: AnyObject{
    func didTapLikeButton(with model: VideoModel)
    func didTapProfileButton(with model: VideoModel)
    func didTapShareButton(with model: VideoModel)
    func didTapCommentButton(with model: VideoModel)
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    
    //Labels
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray5
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    //Buttons
    
    private let profileButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named: "avatarman"), for: .normal)
        
        return button
    }()
    
    private let likeButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.setBackgroundImage(UIImage(systemName:"heart.fill" ), for: .normal)
        return button
    }()
    
    private let commentButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.setBackgroundImage(UIImage(systemName:"text.bubble.fill" ), for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.setBackgroundImage(UIImage(systemName:"arrowshape.turn.up.right.fill" ), for: .normal)
        return button
    }()
    
    private let videoContainer: UIView = UIView()
    
    //Delegate
    
    weak var delegate: VideoCollectionViewCellDelegate?
    
    //subviews
    var player: AVPlayer?
    
    private var model: VideoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.bounds.size = CGSize(width: 414, height: 813-49)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        usernameLabel.text = nil
        tagsLabel.text = nil
        
    }
    
    public func configure(with model: VideoModel){
        self.model = model
        configureVideo()
        
        //labels
        captionLabel.text = model.caption
        usernameLabel.text = model.username
        tagsLabel.text = model.tags
        
        
    }
    
    func addSubViews() {
        contentView.addSubview(videoContainer)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(tagsLabel)
        
        contentView.addSubview(profileButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        
        // Add Actions
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchDown)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchDown)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchDown)
        
        videoContainer.clipsToBounds = true
        
        contentView.sendSubviewToBack(videoContainer)
    }
    
    @objc private func didTapLikeButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapLikeButton(with: model)

    }
    
    @objc private func didTapShareButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapShareButton(with: model)
        
    }
    
    @objc private func didTapProfileButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapProfileButton(with: model)
    }
    
    @objc private func didTapCommentButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapCommentButton(with: model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoContainer.frame = contentView.bounds
        
        let size = contentView.frame.size.width/10
        let width = contentView.frame.size.width
        let heigth = contentView.frame.size.height - 100
        
        //Buttons
        shareButton.frame = CGRect(x: width-size-10, y: heigth-size-50, width: size, height: size)
        commentButton.frame = CGRect(x: width-size-10, y: heigth-(size*2)-50, width: size, height: size)
        likeButton.frame = CGRect(x: width-size-10, y: heigth-(size*3)-50, width: size, height: size)
        profileButton.frame = CGRect(x: width-size-10, y: heigth-(size*4)-50, width: size, height: size)
        
        shareButton.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 5, right: 0)
        
        profileButton.layer.masksToBounds = true
        profileButton.layer.cornerRadius = profileButton.bounds.width / 2
        
        //Labels
        tagsLabel.frame = CGRect(x: 20, y: heigth-110, width: width-size-10, height: 50)
        captionLabel.frame = CGRect(x: 20, y: heigth-130, width: width-size-10, height: 50)
        usernameLabel.frame = CGRect(x: 20, y: heigth-150, width: width-size-10, height: 50)
    }
    
    func configureVideo() {
        
        guard let model = model else {
            return
        }
        
        guard let path = Bundle.main.path(forResource: model.videoFileName
                                          , ofType: model.videoFileFormat) else {
            print("failed to find video")
            print(model.videoFileName,model.videoFileFormat)
            return
        }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
        
    }
    
}
