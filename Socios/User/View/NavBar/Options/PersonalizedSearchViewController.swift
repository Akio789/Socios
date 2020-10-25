//
//  PersonalizedSearchViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import CoreML
import Vision
//ML solo funciona a partir de iOS 11
@available(iOS 11.0, *)


class PersonalizedSearchViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    
    private let miPicker = UIImagePickerController()
    var resultML: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        miPicker.delegate = self
        image.image = UIImage(named: "ImagePlaceholder")
    }
    
    func alertUser(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
       self.present(alert, animated: true)
    }
    

    @IBAction func MlBusqueda() {
        if image.image?.pngData() == UIImage(named: "ImagePlaceholder")?.pngData() {
            alertUser("Favor de ingresar una imágen.")
            return
        }
        
        //instanciar el modelo de la red neuronal
        let modelFile = ML_Socios_1()
        let model = try! VNCoreMLModel(for: modelFile.model)
        //Convertir la imagen obtenida a CIImage
        let imagenCI = CIImage(image: image.image!)
        //Crear un controlador para el manejo de la imagen, este es un requerimiento para ejecutar la solicitud del modelo
        let handler = VNImageRequestHandler(ciImage: imagenCI!)
        //Crear una solicitud al modelo para el análisis de la imagen
        let request = VNCoreMLRequest(model: model, completionHandler: resultadosModelo)
        try! handler.perform([request])
        self.performSegue(withIdentifier: "MLSegue", sender: self)
    }
    

    
    func resultadosModelo(request: VNRequest, error: Error?)
    {
        guard let results = request.results as? [VNClassificationObservation] else { fatalError("No hubo respuesta del modelo ML")}
        var bestPrediction = ""
        var bestConfidence: VNConfidence = 0
        //recorrer todas las respuestas en búsqueda del mejor resultado
        for classification in results{
            if (classification.confidence > bestConfidence){
                bestConfidence = classification.confidence
                bestPrediction = classification.identifier
            }
        }
        let resultado = bestPrediction+" "+String(bestConfidence)
        resultML = bestPrediction
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        miPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(miPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
           image.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
           picker.dismiss(animated: true, completion: nil)
    }
       
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func goBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! ContainerSpecializedSearchResultsViewController
        nextView.typeCategoryInput = resultML
        nextView.imageInput = image.image!
    }
}
