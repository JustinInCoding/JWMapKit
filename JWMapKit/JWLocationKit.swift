//
//  JWLocationKit.swift
//  JWMapKit
//
//  Created by 王晟骏 on 2020/5/13.
//  Copyright © 2020 Justin. All rights reserved.
//

import Foundation

public class JWLocationKit: NSObject {

	static let defaultLocationTimeOut: NSInteger = 10
	static let defaultReGeocodeTimeOut: NSInteger = 5

	private var locationManager: AMapLocationManager?

	public static let shared: JWLocationKit = {
		let shared = JWLocationKit()
        return shared
	}()

	override init() {
		super.init()
		configLocationManager()
	}

	private func configLocationManager() {

		self.locationManager = AMapLocationManager()

		self.locationManager?.delegate = self
		//设置期望定位精度
		self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
		//设置不允许系统暂停定位
		self.locationManager?.pausesLocationUpdatesAutomatically = false
		//设置允许在后台定位
		self.locationManager?.allowsBackgroundLocationUpdates = true
		//设置定位超时时间
		self.locationManager?.locationTimeout = JWLocationKit.defaultLocationTimeOut
		//设置逆地理超时时间
		self.locationManager?.reGeocodeTimeout = JWLocationKit.defaultReGeocodeTimeOut

	}

	public func startLocation(completionBlock: AMapLocatingCompletionBlock?) {

		self.locationManager?.requestLocation(withReGeocode: true, completionBlock: completionBlock)

	}

	public func configKey(key: String) {

		AMapServices.shared()?.apiKey = key

	}


}

extension JWLocationKit: AMapLocationManagerDelegate {

	public func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
		locationManager.requestAlwaysAuthorization()
	}

}
