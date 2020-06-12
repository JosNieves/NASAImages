//
//  DetailiewController.swift
//  NASAImages
//
//  Created by Cristian Gochi on 11/06/20.
//  Copyright © 2020 JoseNieves. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

struct Datos: Decodable{
    var copyright: String?
    var date: String?
    var explanation: String?
    var hdurl: String?
    var media_type: String?
    var service_version: String?
    var title: String?
    var url: String?
}

class DetailiewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var date = Date()
    let DEMO_KEY = "J8hdm5FShljnZZhYZB4cuaSTKpD8Ezghib8vcboD"
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func getDataFromAPI(urlString: String) {
        AF.request(urlString).response { (responseData) in
            guard let data = responseData.data else {return}
            do{
                let datos = try JSONDecoder().decode(Datos.self, from: data)
                self.titleLabel.text = datos.title
                self.descriptionLabel.text = datos.explanation
                print(datos.url!)
                let url = URL(string: datos.hdurl ?? "")
                let resource = ImageResource(downloadURL: url!, cacheKey: datos.hdurl ?? "")
                self.imageView.kf.setImage(with: resource)
            }
            catch{

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateString = formatter.string(from: date)
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(DEMO_KEY)&date=\(dateString)"
        getDataFromAPI(urlString: urlString)
    }
}
