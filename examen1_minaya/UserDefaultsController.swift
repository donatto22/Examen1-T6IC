//
//  UserDefaultsController.swift
//  examen1_minaya
//
//  Created by Donatto on 4/05/22.
//

import UIKit

class UserDefaultsController: UIViewController {

    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var putButton: UIButton!
    @IBOutlet weak var deletebutton: UIButton!
    @IBOutlet weak var txtClave: UITextField!
    
    private let key = "secret_key"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getButtonAction(_ sender: Any) {
        if let value = UserDefaults.standard.string(forKey: key) {
            showAlert(message: value)
        }
        
        else {
            showAlert(message: "No hay valor para esta clave")
        }
    }

    @IBAction func putButtonAction(_ sender: Any) {
        if txtClave.text == "" {
            showAlert(message: "El campo no debe estar vacio")
        }
        
        else {
            let text = txtClave.text
            UserDefaults.standard.set(text, forKey: key)
            UserDefaults.standard.synchronize()
            
            showAlert(message: "Se ha guardado el valor")
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        if UserDefaults.standard.string(forKey: key) != nil {
            UserDefaults.standard.removeObject(forKey: key)
            UserDefaults.standard.synchronize()
            
            showAlert(message: "Se ha eliminado el valor")
        }
        
        else {
            showAlert(message: "No hay nada para eliminar")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Pregunta 1 - Minaya", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
