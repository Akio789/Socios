//
//  EditProfileViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 22/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var names: UITextField!
    @IBOutlet weak var lastNames: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var birthday: UIDatePicker!
    
    let db = Firestore.firestore()
    private let miPicker = UIImagePickerController()
    var user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        miPicker.delegate = self
        profilePicture.image = UIImage(named: "ImagePlaceholder")
        db.collection("users").whereField("id", isEqualTo: user?.uid).getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            var userInfo = querySnapshot!.documents.first?.data()
            self.names.text = userInfo?["names"] as! String
            self.lastNames.text = userInfo?["lastNames"] as! String
            self.phone.text = userInfo?["phone"] as! String
            let dob = userInfo?["dob"] as! Timestamp
            self.birthday.date = dob.dateValue()
            }
        }
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        miPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(miPicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        profilePicture.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        db.collection("users").document(user!.uid as! String).updateData([
            "names": self.names.text,
            "lastNames": self.lastNames.text,
            "phone": self.phone.text,
            "date": self.birthday.date
        ])
        performSegue(withIdentifier: "editedProfileSegue", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
