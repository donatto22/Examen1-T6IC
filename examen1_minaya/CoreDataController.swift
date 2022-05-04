//
//  CoreDataController.swift
//  examen1_minaya
//
//  Created by Donatto on 4/05/22.
//

import UIKit
import CoreData

var tareas = [NSManagedObject]()

class CoreDataController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "celda")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            tareas = results as[NSManagedObject]
        } catch _ as NSError {
            print("No se ha podido guardar")
        }
        
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "celda")
        
        //cell?.textLabel?.text = tareas[indexPath.row]
        let task = tareas[indexPath.row]
        cell!.textLabel!.text = task.value(forKey: "name") as? String
        
        return (cell)!
    }
    
    @IBAction func addTarea(_ sender: Any) {
        let alert = UIAlertController(title: "Nueva tarea", message: "Agregar tarea nueva", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Guardar", style: .default) { UIAlertAction in
            let textField = alert.textFields!.first
            self.saveTask(nameTask: textField!.text!)
            
            self.tblView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { UIAlertAction in
            
        }
        
        alert.addTextField { (textField: UITextField)  in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveTask(nameTask: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)
        
        let task = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        task.setValue(nameTask, forKey: "name")
        
        do {
            try managedContext.save()
            tareas.append(task)
        } catch _ as NSError {
            print("No se ha podido guardar")
        }
    }
}
