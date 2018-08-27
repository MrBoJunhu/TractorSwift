//
//  MapBaseViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/21.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class MapBaseViewController: BaseViewController,MAMapViewDelegate {

    enum MapControllerType {
        case Homepage,Detail
    }
    
    @IBOutlet weak var trackBtn: UIButton!
    @IBOutlet weak var starBtn: UIButton!
    
    private let standardZoomLevel:CGFloat = 17.0
    private var userLocationAnnotationView:MAAnnotationView!
    
    public var mapCenter:CLLocationCoordinate2D!
    
    private var type:MapControllerType!
    @IBOutlet weak var mapView: MAMapView!
    
    init(mapType:MapControllerType) {
        super.init(nibName: nil, bundle: nil)
        self.type = mapType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
      
        self.designUI()
      
        self.mapView.zoomLevel = standardZoomLevel
        
        self.mapView.delegate = self

        self.mapView.mapType = .standard

        self.mapView.isRotateEnabled = false
        
        self.mapView.showsCompass = true
        
        self.mapView.setCompassImage(UIImage.init(named: "compass"))
        
        self.mapView.isShowsIndoorMap = false
        
        self.mapView.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        let r:MAUserLocationRepresentation = MAUserLocationRepresentation.init()
        r.image = UIImage.init(named: "userPosition")
        self.mapView.update(r)
        
    }
    
    func designUI() -> Void {
        
        self.starBtn.borderStyle(width: 1.5, borderColor: .white, cornerRadius: (self.starBtn.frame.size.width > self.starBtn.frame.size.height ? self.starBtn.frame.size.height/2 : self.starBtn.frame.size.width/2))
        self.trackBtn.borderStyle(width: 1.5, borderColor: .white, cornerRadius: (self.trackBtn.frame.size.width > self.trackBtn.frame.size.height ? self.trackBtn.frame.size.height/2 : self.trackBtn.frame.size.width/2))
        
        self.starBtn.imageView?.contentMode = .scaleAspectFit
        self.trackBtn.imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mapView.frame = self.view.bounds
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .followWithHeading
        if (self.mapCenter != nil) {
            self.mapView.setCenter(self.mapCenter, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
  
    @IBAction func clickStarBtn(_ sender: UIButton) {
      
        sender.isSelected = !sender.isSelected
        self.mapView.mapType = sender.isSelected  ? .satellite : .standard
        
    }
   
    @IBAction func clickTrackBtn(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        self.mapView.isShowTraffic = sender.isSelected
    }
    
    @IBAction func clickLoactionBtn(_ sender: UIButton) {
        
        if self.mapView.userLocation.isUpdating && self.mapView.userLocation.location != nil {
            
            self.mapView.setCenter(self.mapView.userLocation.coordinate, animated: true)

        }
        
    }
    
    @IBAction func clickIncreaseAction(_ sender: UIButton) {
        
        let zoomLevel:CGFloat = self.mapView.zoomLevel
        self.mapView.setZoomLevel(zoomLevel + 1, animated: true)
        self.mapView.showsScale = true
        
    }
    
    @IBAction func clickDecreaseAction(_ sender: UIButton) {
        
        let zoomLevel:CGFloat = self.mapView.zoomLevel
        self.mapView.setZoomLevel(zoomLevel - 1, animated: true)
        self.mapView.showsScale = true
    }
    
    //TODO:标记点
    func addAnnotations(annotations: inout [MAAnnotation]) -> Void {
        
       self.mapView.addAnnotations(annotations)
        
    }
    
    //TODO:MAMapViewDelegate
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        if !updatingLocation && self.userLocationAnnotationView != nil {
           
            UIView.animate(withDuration: 0.1) {
                
                let degree = userLocation.heading.trueHeading - Double(self.mapView.rotationDegree)
                let radian = (degree * Double.pi) / 180.0
                self.userLocationAnnotationView.transform = CGAffineTransform.init(rotationAngle: CGFloat(radian))
            }
           
        }
    }

    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAUserLocation.classForCoder()) {
            
            MapDataManager.manager.userLocation = annotation.coordinate
            let userlocationIdentifier = "uerloactionID"
            var userAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: userlocationIdentifier)
            if userAnnotationView == nil {
                userAnnotationView = MAAnnotationView.init(annotation: annotation, reuseIdentifier: userlocationIdentifier)
            }
            userAnnotationView?.image = UIImage.init(named: "userPosition")
            self.userLocationAnnotationView = userAnnotationView
            
            return userAnnotationView
      
        } else if annotation.isKind(of: MAPointAnnotation.self) {
         
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?

            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }

            annotationView?.canShowCallout = false
            annotationView?.isDraggable = false
            annotationView?.animatesDrop = true
            annotationView!.image = UIImage(named: "拖拉机彩色")
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView!.centerOffset = CGPoint.init(x: 0, y: -18)
            
            return annotationView!
        
        }
        
       
        return nil
        
    }
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        
    }

    func mapView(_ mapView: MAMapView!, didAnnotationViewTapped view: MAAnnotationView!) {
        
        let dialogV = MapDialogView.view()
        dialogV.show()
        dialogV.click(workF: { (m) in
            
        }, nav: { (m) in
            
            MapNavigationHelper.naviagion(startAdd: "起点", startLocation: MapDataManager.manager.userLocation!, endLocation: view.annotation.coordinate, endAdd: "终点")

        }, config: { (m) in
            
            let configVC = ConfigBaseViewController.init(nibName: nil, bundle: nil)
            self.parent?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(configVC, animated: true)
            self.parent?.hidesBottomBarWhenPushed = self.type == MapControllerType.Homepage ? false : true
            
        }, collect: { (m) in
            
        }) { (m) in
            
        }
    
        
    }
    
    //MARK:-地图加载错误
    func mapViewDidFailLoadingMap(_ mapView: MAMapView!, withError error: Error!) {
        //http://lbs.amap.com/api/ios-sdk/guide/map-tool/errorcode/
    }

    
}
