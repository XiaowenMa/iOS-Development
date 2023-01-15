//
//  ViewController.swift
//  XiaowenMa-Lab3
//
//  Created by 马晓雯 on 6/27/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentPath:Path?
    var canvas:PathView!
    
    //var currentColor:UIColor?
    var buttons:[CustomButton]=[]
    var currentButton: CustomButton?
    var opacity: CGFloat=1
    var isDash:Bool=false
    var isStraight:Bool=false
    
    //line pattern buttons
    @IBOutlet weak var dashButton: UIButton!
    
    @IBOutlet weak var lineButton: UIButton!
    
    @IBOutlet weak var curveButton: UIButton!
    
    
    //RGB Sliders
    @IBOutlet weak var R: UISlider!
    
    @IBOutlet weak var G: UISlider!
    
    @IBOutlet weak var B: UISlider!
    
    //Opacity Slider
    @IBOutlet weak var opacitySlider: UISlider!
    
    //thickness Slider
    @IBOutlet weak var theSlider: UISlider!
    //initialize my custom button
    var blue=CustomButton(frame: .zero)
    var black=CustomButton(frame: .zero)
    var red=CustomButton(frame: .zero)
    var yellow=CustomButton(frame: .zero)
    var green=CustomButton(frame: .zero)
    var custom=CustomButton(frame: .zero)
    //var purple=CustomButton(frame: .zero)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let canvasView=CGRect(x: 0, y: 120, width: view.frame.width, height: view.frame.height-230);
        canvas=PathView(frame:canvasView)
        //canvas=PathView(frame:view.frame)
        
        
        //default pen color: black
        //currentColor=UIColor.black;
        
        buttons.append(black)
        buttons.append(blue)
        buttons.append(red)
        buttons.append(yellow)
        buttons.append(green)
        //buttons.append(purple)
        
       // custom=CustomButton(frame: .zero)
        buttons.append(custom)
        
        
        for button in buttons{
            button.setSize()
        }
        //blue.setSize()
        black.setStyle(color: UIColor.black)
        blue.setStyle(color: UIColor.systemBlue);
        red.setStyle(color: UIColor.systemRed);
        yellow.setStyle(color: UIColor.systemYellow)
        green.setStyle(color: UIColor.systemGreen)
        //purple.setStyle(color: UIColor.purple)
        
        
        custom.setStyle(color:UIColor(red:CGFloat(R.value),green:CGFloat(G.value),blue:CGFloat(B.value),alpha:1))
        //custom.setStyle(color:UIColor(red:CGFloat(0.5),green:CGFloat(0.5),blue:CGFloat(0.5),alpha:1))
        
        setLocation(button: red, x: -150, y: -60)
        setLocation(button: black, x: -150, y: -20)
        setLocation(button:blue,x: -110, y: -20)
        setLocation(button: custom, x: -70, y: -20)
        setLocation(button: green, x: -110, y: -60)
        setLocation(button: yellow, x: -70, y: -60)
        view.addSubview(canvas)
        
        //set  the default color choice to be black
        
        currentButton=black
        black.layer.shadowColor=UIColor.black.cgColor
        black.layer.shadowOffset=CGSize(width: 0, height: 5)
        black.layer.shadowRadius=3
        black.layer.shadowOpacity=0.5
 
        
        //set the default line pattern to curve
        curveButton.layer.cornerRadius=5
        curveButton.layer.borderWidth=3
        curveButton.layer.borderColor=UIColor.lightGray.cgColor
 
 

        addActiontoButtons()
    }
    
    func addActiontoButtons(){
        for button in buttons{
            button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        }
    }
    
    @objc func tapped(button: CustomButton){
        for other in buttons{//remove the shadow for other buttons
            other.layer.shadowColor=nil
            other.layer.shadowOffset=CGSize(width: 0, height: 0)
            other.layer.shadowRadius=0
            other.layer.shadowOpacity=0
        }
        button.layer.shadowColor=UIColor.black.cgColor
        button.layer.shadowOffset=CGSize(width: 0, height: 5)
        button.layer.shadowRadius=3
        button.layer.shadowOpacity=0.5
        
        //print("tapped")
        //currentColor=button.color
        currentButton=button;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touchPoint = (touches.first)!.location(in: canvas) as CGPoint
        
        //initialize the currentPath with currentButton's color
        currentPath=Path(points:[touchPoint], startPoint: touchPoint,color:(currentButton!).color!,thickness: CGFloat(theSlider.value),dashed: isDash,straight:isStraight)
        
    }
    
    @IBAction func clearStuff(_ sender: Any) {
        canvas.thePath = nil
        canvas.pathes = []
    }
    
    @IBAction func undoLast(_ sender: Any) {
        if(canvas.pathes.count>0){
        canvas.pathes.remove(at: canvas.pathes.count-1)
        }
        else{
            //print("No more to Undo.")
        }
        canvas.thePath = nil
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: canvas) as CGPoint

        currentPath!.points.append(touchPoint)
        canvas.thePath=currentPath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        if let newPath = currentPath {
            canvas.pathes.append(newPath)
            canvas.thePath=nil//make thePath nil or there will be two thePath!!!! then the opacity doubles!!!
        }

    }

    
    func setLocation(button:CustomButton,x:CGFloat,y:CGFloat){
        view.addSubview(button);
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: x).isActive=true;
        button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: y).isActive=true;
        button.heightAnchor.constraint(equalToConstant: 30).isActive=true;
        button.widthAnchor.constraint(equalToConstant: 30).isActive=true;
    }
    
    @IBAction func changeR(_ sender: Any) {
        custom.setStyle(color: UIColor(red:CGFloat(R.value),green:CGFloat(G.value),blue:CGFloat(B.value),alpha:1))
    }
    
    @IBAction func changeG(_ sender: Any) {
        custom.setStyle(color: UIColor(red:CGFloat(R.value),green:CGFloat(G.value),blue:CGFloat(B.value),alpha:1))
    }
    
    @IBAction func changeB(_ sender: Any) {
        custom.setStyle(color: UIColor(red:CGFloat(R.value),green:CGFloat(G.value),blue:CGFloat(B.value),alpha:1))
    }
    
    
    @IBAction func changeOpacity(_ sender: Any) {
        opacity=CGFloat(opacitySlider.value)
        
        for button in buttons{
            var rValue:CGFloat=0
            var gValue:CGFloat=0
            var bValue:CGFloat=0
            var alphaValue:CGFloat=0
            
            button.color!.getRed(&rValue, green: &gValue, blue: &bValue, alpha: &alphaValue)
            
            button.setStyle(color: UIColor(red:rValue,green: gValue,blue:bValue,alpha: CGFloat(opacitySlider.value)))
        }
    }

    @IBAction func changeDash(_ sender: Any) {
        //switch the value of isDash
        if isDash==false{
            isDash=true
            dashButton.layer.cornerRadius=5
            dashButton.layer.borderWidth=3
            dashButton.layer.borderColor=UIColor.lightGray.cgColor
        }
        else{
            isDash=false
            dashButton.layer.cornerRadius=0
            dashButton.layer.borderWidth=0
            dashButton.layer.borderColor=nil
        }

    }
    
    
    @IBAction func changeStraight(_ sender: Any) {
        isStraight=true
        lineButton.layer.cornerRadius=5
        lineButton.layer.borderWidth=3
        lineButton.layer.borderColor=UIColor.lightGray.cgColor
        
         //turn of the border for curve button
        curveButton.layer.cornerRadius=0
        curveButton.layer.borderWidth=0
        curveButton.layer.borderColor=nil
    }
    
    
    @IBAction func toCurve(_ sender: Any) {
        isStraight=false
        curveButton.layer.cornerRadius=5
        curveButton.layer.borderWidth=3
        curveButton.layer.borderColor=UIColor.lightGray.cgColor

        //turn of the shadow for straight line button
        lineButton.layer.cornerRadius=0
        lineButton.layer.borderWidth=0
        lineButton.layer.borderColor=nil
    }
    
    
}

