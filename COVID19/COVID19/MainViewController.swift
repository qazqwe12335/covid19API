//
//  MainViewController.swift
//  COVID19
//
//  Created by 張軒瑋 on 2022/5/5.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var countryLable: UILabel!
    @IBOutlet weak var todayGet: UILabel!
    @IBOutlet weak var totalGet: UILabel!
    
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayDeaths: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    
    @IBOutlet weak var reload: UIButton!
    @IBOutlet weak var persentLabel: UILabel!
    
    let url = covidApi.covidapi
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload.layer.borderWidth = 2
        reload.layer.borderColor = UIColor.systemRed.cgColor
        reload.layer.cornerRadius = 20
        
        apiRequest()
    }
    
    func apiRequest(){
        
        var covidrequest = [covidRequest]().self
        
        let url = covidApi.covidapi
        if let url = URL(string: url) { //將string轉為url，並透過url取得response
            URLSession.shared.dataTask(with: url) { [self] data, request, error in
                if let data = data {    //檢查data不是nil
                    let decoder = JSONDecoder() //設定解碼
                    do{ //將data進行解碼，並設定covidRequest型別
                        covidrequest = try decoder.decode([covidRequest].self, from: data)
                        DispatchQueue.main.async {  //解碼後回到主線程改變介面
                            countryLable.text = covidrequest[0].country
                            todayGet.text = covidrequest[0].todayGet
                            totalGet.text = covidrequest[0].totalGet
                            todayDeaths.text = covidrequest[0].todayDeaths
                            totalDeaths.text = covidrequest[0].totalDeaths
                            todayDate.text = covidrequest[0].dateString
                            
                            var vaccine:Double!
                            var population:Double!
                            //這邊計算疫苗施打率，將總人口除上施打疫苗人數，因為有分數，所以使用double型別
                            for index in 0...99 {
                                vaccine = Double(covidrequest[index].totalVaccine)
                                population = Double(covidrequest[index].totalPopulation)
                                //有時候最新資料會沒有總人口及施打人數，所以往前一筆資料取得
                                if vaccine == 0 || population == 0{
                                    
                                }else{
                                    let calculate = (vaccine / population) * 100
                                    let persent = String(format: "%.2f", calculate)
                                    persentLabel.text = "\(persent)%"
                                }
                            }
                        }
                    }
                    catch{
                        print(error)
                    }
                    
                } else {
                    print(error)
                }
            }.resume()
        }
    }
    
    @IBAction func reload(_ sender: UIButton) {
        
        print("AAA")
        
        countryLable.text = "台灣"
        totalGet.text = "----"
        todayGet.text = "----"
        totalDeaths.text = "----"
        todayDeaths.text = "----"
        persentLabel.text = "00.00%"
        
        apiRequest()
    }
}
