//
//  SimonSaysController.swift
//  MemoryGame
//
//  Created by Apps2M on 24/10/22.
//

import Foundation

import UIKit


var bestScore: Int = 0

class SimonSaysController: UIViewController {
    
    var score: Int = 0
    
    var gameIndex: Int = 0
    
    var imagesGenerated: [Int] = []
    
    var imagesPulsed: [Int] = []
    
    var images: [Int : UIImageView] = [:]
    
    var buttons: [Int : UIButton] = [:]
    
    @IBOutlet weak var imagesView: UIView!
    
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var rex1Image: UIImageView!
    @IBOutlet weak var therizinosaurusImage: UIImageView!
    @IBOutlet weak var beelzebufoImage: UIImageView!
    @IBOutlet weak var mononycusImage: UIImageView!
    @IBOutlet weak var redEyesTherizinoImage: UIImageView!
    @IBOutlet weak var rex2Image: UIImageView!
    @IBOutlet weak var brontosImage: UIImageView!
    @IBOutlet weak var carnotaurusImage: UIImageView!
    @IBOutlet weak var mosasaurusImage: UIImageView!
    
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var bestScoreText: UILabel!
    
    @IBOutlet weak var rex1Button: UIButton!
    @IBOutlet weak var theri1Button: UIButton!
    @IBOutlet weak var beelzebufo1Button: UIButton!
    @IBOutlet weak var mononycusButton: UIButton!
    @IBOutlet weak var theri2Button: UIButton!
    @IBOutlet weak var rex2Button: UIButton!
    @IBOutlet weak var brontosButton: UIButton!
    @IBOutlet weak var carnotaurusButton: UIButton!
    @IBOutlet weak var mosasaurusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = [0: rex1Image, 1: therizinosaurusImage, 2: beelzebufoImage, 3: mononycusImage, 4: redEyesTherizinoImage, 5:rex2Image, 6: brontosImage, 7: carnotaurusImage, 8: mosasaurusImage]
        
        scoreText.text = "Score: " + String(score)
        bestScoreText.text = "Best Score: " + String(bestScore)
        
        RestartGame()
    }
    
    func ShowImages(){
        
        imagesPulsed.removeAll()
        
        HideButtonsView(hidden: true)
        
        imagesGenerated.append(GenerateNewImage())
        
        print("ImagesGenerated: ", imagesGenerated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.ImageShowingProcess()}
        
    }
    
    func ImageShowingProcess(){
        
        var index = 0
        
        var time = 0
        
        for id in imagesGenerated{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
                
                self.ShowImage(_img: self.images[id]!)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time + 1)) {
                self.HideAllImages()
                index += 1
                
            }
            
            
            time += 2

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
            self.StartGame()
        }
        
        
    }
    
    func StartGame(){
        
        gameIndex = 0
        
        imagesPulsed.removeAll()
        
        HideButtonsView(hidden: false)
    }
    
    func GenerateNewImage() -> Int{
        
        return Int.random(in: 0..<images.count - 1)
    }
    
    func HideButtonsView(hidden: Bool){
        if(hidden){
            imagesView.isHidden = false
        } else {
            imagesView.isHidden = true
        }
        buttonsView.isHidden = hidden
    }
    
    func ShowImage(_img: UIImageView){
        
        _img.isHidden = false
        
    }
    
    func HideImage(_img: UIImageView){
        _img.isHidden = true
    }
    
    
    @IBAction func OnPressedButton(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        if imagesPulsed.count == imagesGenerated.count{
            sender.isEnabled = true
            return }
        
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        imagesPulsed.append(sender.tag)
        
        print("ImagesPulsed: ", imagesPulsed)

        gameIndex += 1
        
        print("Game Index: ", gameIndex)
        
        if(images[imagesPulsed[gameIndex - 1]]! == images[imagesGenerated[gameIndex - 1]]!){
            
            print("correct")
            
        } else {
            print("incorrect")
            
            RestartGame()
        }
        
        if imagesPulsed.count >= imagesGenerated.count{
            score += 1
            
            scoreText.text = "Score: " + String(score)
            
            if score > bestScore{
                SaveScore()
            }
            
            HideButtonsView(hidden: true)
            
            ShowImages()
        }
        sender.isEnabled = true
    }
    
    func RestartGame(){
        score = 0
        
        scoreText.text = "Score: " + String(score)
        
        for b in buttons{
            b.value.backgroundColor = UIColor.clear
        }
        
        imagesGenerated.removeAll()
        
        imagesPulsed.removeAll()
        
        gameIndex = 0
        
        ShowImages()
    }
    
    func SaveScore(){
        bestScore = score
        bestScoreText.text = "Best Score: " + String(bestScore)
    }
    
    func HideAllImages(){
        for img in images{
            img.value.isHidden = true
        }
    }
}
