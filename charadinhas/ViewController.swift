//
//  ViewController.swift
//  charadinhas
//
//  Created by Mateus Rodrigues Santos on 04/08/19.
//  Copyright © 2019 Mateus Rodrigues Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var perguntaStrb: UILabel!
    @IBOutlet weak var respostaStrb: UILabel!
    
    //----Variéveis da URLSession
    //Sessao
    let session = URLSession(configuration: .default)
    //Tarefa
    var tarefa: URLSessionDataTask?
    
    //JSON
    var json = NSDictionary()
    //Pergunta
    var pergunta = String()
    //Resposta
    var resposta = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func chamaPiada(_ sender: Any) {
        
        tarefa?.cancel()
        
        let urlBase = URLComponents(string: "https://us-central1-kivson.cloudfunctions.net/charada-aleatoria")
        var request = URLRequest(url: urlBase!.url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        tarefa = session.dataTask(with: request) { (data, response, error) in
            do{
                self.json = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments]) as! NSDictionary
                self.pergunta = self.json["pergunta"] as! String
                self.resposta = self.json["resposta"] as! String
                
                self.perguntaStrb.isHidden = false
                self.respostaStrb.isHidden = false
                
                self.perguntaStrb?.text = self.pergunta
                self.respostaStrb?.text = self.resposta
            }catch{
                print(error as Any)
            }
        }
        
        tarefa?.resume()
        
        
    
    }
    
}

