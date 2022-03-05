//
//  ViewController.swift
//  TestConceptCube
//
//  Created by Vũ Phan on 03/03/2022.
//
import FirebaseAuth
import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
    
    var picture = ["c01.png", "c02.png", "c03.png" ,"c04.png" ,"c05.png", "c06.png" ,"c07.png" ,"c08.png" ,"c09.png", "c10.png", "c11.png", "c12.png" ,"c13.png", "c14.png" ,"m00.png", "m01.png", "m02.png" ,"m03.png" ,"m04.png", "m05.png", "m06.png", "m07.png", "m08.png", "m09.png", "m10.png" ,"m11.png" ,"m12.png" ,"m13.png", "m14.png", "m15.png" ,"m16.png", "m17.png" ,"m18.png" ,"m19.png", "m20.png" ,"m21.png", "p01.png", "p02.png" ,"p03.png", "p04.png" ,"p05.png" ,"p06.png" ,"p07.png" ,"p08.png", "p09.png", "p10.png", "p11.png", "p12.png", "p13.png", "p14.png", "s01.png", "s02.png" ,"s03.png" ,"s04.png", "s05.png","s06.png", "s07.png", "s08.png", "s09.png", "s10.png", "s11.png" ,"s12.png", "s13.png" ,"s14.png", "w01.png" ,"w02.png" ,"w03.png", "w04.png", "w05.png", "w06.png", "w07.png" ,"w08.png" ,"w09.png" ,"w10.png", "w11.png" ,"w12.png" ,"w13.png" ,"w14.png"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // color
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        readNameImg()
        createCard()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setBG()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addTapped))
        
    }
    @objc private func addTapped(){
        
        reMidScreen()
        readNameImg()
        createCard()
        
        
    }
    //set background
    private func setBG(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg2")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    //create cards
    private func createCard(){
        
        var cent = self.view.center
        for i in 0...77 {
            let customView = DraggableView(frame: CGRect(x: 0, y: 0, width: 96, height: 143))
            customView.center = cent
            customView.backgroundColor = .systemBackground
            customView.layer.cornerRadius = 9
            // add image to view
            let imageView = UIImageView(image: UIImage(named: "bb")!)
            imageView.frame = CGRect(x: -12, y: -14, width: 120, height: 170)
            customView.addSubview(imageView)
            
            self.view.addSubview(customView)
            cent = CGPoint(x: cent.x + 0.3, y: cent.y)
            // add name of image
            customView.tag = i
            customView.get(picture[i])
         
        }
        
    }
    private func reMidScreen(){
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        UIView.transition(with: self.view, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        view.subviews.map({ $0.removeFromSuperview() })
        setBG()
    }
    // read image to array
    private func readNameImg(){
        picture.shuffle()
        
    }
    
    
    
    
    
}
class DraggableView: UIView {

    var localTouchPosition : CGPoint?
    var nameOfCard = "bb"
    var tapOne = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        var tapGesture = UITapGestureRecognizer()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.myviewTapped(_:)))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       
       
   }
    func get(_ name : String){
        nameOfCard = name
    }

   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
       let touch = touches.first
       self.localTouchPosition = touch?.preciseLocation(in: self)
   }

   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
       super.touchesMoved(touches, with: event)
       let touch = touches.first
       guard let location = touch?.location(in: self.superview), let localTouchPosition = self.localTouchPosition else{
           return
       }
       self.frame.origin = CGPoint(x: location.x - localTouchPosition.x, y: location.y - localTouchPosition.y)
       
   }
    
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.localTouchPosition = nil
   }
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        
        let imageView = UIImageView(image: UIImage(named: nameOfCard)!)
        imageView.frame = CGRect(x: -12, y: -14, width: 120, height: 170)
        self.addSubview(imageView)
        if tapOne == false{
            UIView.transition(with: self, duration: 0.25, options: [.transitionFlipFromRight], animations: nil, completion: nil)
            tapOne =  true
        }
        
    }
    
   

}



