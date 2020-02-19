//
//  UartModuleViewController.swift
//  Basic Chat
//
//  Created by Trevor Beaton on 12/4/16.
//  Copyright © 2016 Vanguard Logic LLC. All rights reserved.
//





import UIKit
import WebKit
import CoreBluetooth

class UartModuleViewController: UIViewController, CBPeripheralManagerDelegate, UITextViewDelegate, UITextFieldDelegate, WKUIDelegate {
    
    //UI
 //   @IBOutlet weak var baseTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var switchUI: UISwitch!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var webVideoView: WKWebView!
    @IBOutlet weak var controllerDirection: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var carbonLabel: UILabel!
    
    
    //Data
    var peripheralManager: CBPeripheralManager?
    var peripheral: CBPeripheral!
    private var consoleAsciiText:NSAttributedString? = NSAttributedString(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.plain, target:nil, action:nil)
/*        self.baseTextView.delegate = self
        //self.inputTextField.delegate = self
        //Base text view setup
        self.baseTextView.layer.borderWidth = 3.0
        self.baseTextView.layer.borderColor = UIColor.blue.cgColor
        self.baseTextView.layer.cornerRadius = 3.0
        self.baseTextView.text = ""*/
        //Input Text Field setup
        /*self.inputTextField.layer.borderWidth = 2.0
        self.inputTextField.layer.borderColor = UIColor.blue.cgColor
        self.inputTextField.layer.cornerRadius = 3.0*/
        //Create and start the peripheral manager
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        //-Notification for updating the text view with incoming text
        updateIncomingData()
        
        let myURL = URL(string: "http://10.0.0.56:81/stream");
        let myRequest = URLRequest(url: myURL!);
        webVideoView.load(myRequest);
    }
    
    override func viewDidAppear(_ animated: Bool) {
      //  self.baseTextView.text = ""
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // peripheralManager?.stopAdvertising()
        // self.peripheralManager = nil
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    

    /*func updateIncomingData () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Notify"), object: nil , queue: nil){
            notification in
            let appendString = "\n"
            let myFont = UIFont(name: "Helvetica Neue", size: 15.0)
            let myAttributes2 = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): myFont!, convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.red]
            let attribString = NSAttributedString(string: "[Incoming]: " + (characteristicASCIIValue as String) + appendString, attributes: convertToOptionalNSAttributedStringKeyDictionary(myAttributes2))
            let newAsciiText = NSMutableAttributedString(attributedString: self.consoleAsciiText!)
            self.baseTextView.attributedText = NSAttributedString(string: characteristicASCIIValue as String , attributes: convertToOptionalNSAttributedStringKeyDictionary(myAttributes2))
            
            newAsciiText.append(attribString)
            
            self.consoleAsciiText = newAsciiText
            self.baseTextView.attributedText = self.consoleAsciiText
            
        }
    }*/
    
    func updateIncomingData () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Notify"), object: nil , queue: nil){
            notification in
            
            let currentString = characteristicASCIIValue;
            
            let valueList = currentString.components(separatedBy: ",")
            
            self.humidityLabel.text = valueList[0] + "%"
            self.temperatureLabel.text = valueList[1] + "°C"
            self.carbonLabel.text = valueList[2] + "%"
            
        }
    }
    
 /*   @IBAction func clickSendAction(_ sender: AnyObject) {
        outgoingData()
        
    }
   */
    @IBAction func sendForwardDown(_ sender: Any) {
        print("Forward")
        sendData(inputText: "a")
        controllerDirection.text = "Frwd"
    }
    
    @IBAction func sendRightDown(_ sender: Any) {
        print("Right")
        sendData(inputText: "b")
        controllerDirection.text = "Right"
    }
    
    @IBAction func sendBackDown(_ sender: Any) {
        print("Back")
        sendData(inputText: "c")
        controllerDirection.text = "Back"
    }
    
    @IBAction func sendLeftDown(_ sender: Any) {
        print("Left")
        sendData(inputText: "d")
        controllerDirection.text = "Left"
    }
    
    func sendCancel() {
        print("Stop")
        sendData(inputText: "e")
        controllerDirection.text = "Stop"
    }
    
    @IBAction func sendForwardUp(_ sender: Any) {
        sendCancel();
    }
    
    
    @IBAction func sendRightUp(_ sender: Any) {
        sendCancel();
    }
    
    
    @IBAction func sendBackUp(_ sender: Any) {
        sendCancel();
    }
    
    
    @IBAction func sendLeftUp(_ sender: Any) {
        sendCancel();
    }
    
    
    
    
/*    func outgoingData () {
        let appendString = "\n"
        
        let inputText = inputTextField.text
        
        let myFont = UIFont(name: "Helvetica Neue", size: 15.0)
        let myAttributes1 = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): myFont!, convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.blue]
        
        writeValue(data: inputText!)
        
        let attribString = NSAttributedString(string: "[Outgoing]: " + inputText! + appendString, attributes: convertToOptionalNSAttributedStringKeyDictionary(myAttributes1))
        let newAsciiText = NSMutableAttributedString(attributedString: self.consoleAsciiText!)
        newAsciiText.append(attribString)
        
        consoleAsciiText = newAsciiText
        baseTextView.attributedText = consoleAsciiText
        //erase what's in the text field
        inputTextField.text = ""
        
    }*/
    
    func sendData (inputText: String) {
        let appendString = "\n"
                              
        let myFont = UIFont(name: "Helvetica Neue", size: 15.0)
        let myAttributes1 = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): myFont!, convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.blue]

        writeValue(data: inputText)

        let attribString = NSAttributedString(string: "[Outgoing]: " + inputText + appendString, attributes: convertToOptionalNSAttributedStringKeyDictionary(myAttributes1))
        let newAsciiText = NSMutableAttributedString(attributedString: self.consoleAsciiText!)
        newAsciiText.append(attribString)

        consoleAsciiText = newAsciiText
//        baseTextView.attributedText = consoleAsciiText
        //erase what's in the text field

    }
    
    // Write functions
    func writeValue(data: String){
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        //change the "data" to valueString
        if let blePeripheral = blePeripheral{
            if let txCharacteristic = txCharacteristic {
                blePeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
            }
        }
    }
    
    func writeCharacteristic(val: Int8){
        var val = val
        let ns = NSData(bytes: &val, length: MemoryLayout<Int8>.size)
        blePeripheral!.writeValue(ns as Data, for: txCharacteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
    
    
    //MARK: UITextViewDelegate methods
  /*  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView === baseTextView {
            //tapping on consoleview dismisses keyboard
            inputTextField.resignFirstResponder()
            return false
        }
        return true
    }*/
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        scrollView.setContentOffset(CGPoint(x:0, y:250), animated: true)
//    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
//    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            return
        }
        print("Peripheral manager is running")
    }
    
    //Check when someone subscribe to our characteristic, start sending the data
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Device subscribe to characteristic")
    }
    
    //This on/off switch sends a value of 1 and 0 to the Arduino
    //This can be used as a switch or any thing you'd like
    @IBAction func switchAction(_ sender: Any) {
        if switchUI.isOn {
            print("On ")
            writeCharacteristic(val: 1)
        }
        else
        {
            print("Off")
            writeCharacteristic(val: 0)
            print(writeCharacteristic)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
 /*   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        outgoingData()
        return(true)
    }*/
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("\(error)")
            return
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
