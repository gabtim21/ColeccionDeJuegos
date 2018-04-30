//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by MAC09 on 30/04/18.
//  Copyright © 2018 Gabtim. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var JuegoImagenView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil {
            JuegoImagenView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
        
    }
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
            juego!.titulo = tituloTextField.text
            juego!.imagen = UIImagePNGRepresentation(JuegoImagenView.image!) as NSData?

        }else {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let juego = Juego(context: context)
        juego.titulo = tituloTextField.text
        juego.imagen = UIImagePNGRepresentation(JuegoImagenView.image!) as NSData?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenSeleccionada = info[UIImagePickerControllerOriginalImage] as! UIImage
        JuegoImagenView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
}
