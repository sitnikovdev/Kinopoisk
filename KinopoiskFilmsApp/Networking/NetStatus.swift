//
//  APIClient.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 15.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation
import Network

public class NetStatus {
    
    // MARK: -  NetStatus Singleton
    
    static public let shared = NetStatus()
    
    // MARK: - Private Initializer
    
    private init() {}
    
    deinit {
        stopMonitoring()
    }
    
    // MARK: - Network Path Monitor instance
    
    var monitor: NWPathMonitor?
    
    // MARK: - Monitoring Flag
    
    public   var isMonitoring = false
    
    // MARK: - Device Is Connected
    
    public   var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    // MARK: - Current Interface Type
    
    public   var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil}
        
        return monitor.currentPath.availableInterfaces.filter {monitor.currentPath.usesInterfaceType($0.type)}.first?.type
    }
    
    // MARK: - Available Interface Type
    
    public  var availableInterfaceTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil}
        
        return monitor.currentPath.availableInterfaces.map {$0.type}
        
    }
    
    // MARK: - Checking For Expensive Interfaces
    
    public   var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false 
    }
    
    // MARK: - Monitoring Callbacks
    
    /// Start monitoring for network changes
    public var didStartMonitoringHandler: (() -> Void)?
    /// Stop monitoring for network changes
    public var didStopMonitoringHandler: (() -> Void)?
    /// Changes on network status occur
    public var netStatusChangeHandler: (() -> Void)?
    
    
    // MARK: - Start Monitoring
    
    public func startMonitoring() {
        // Check if monitoring alredy or not
        guard !isMonitoring else {return}
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)
        
        // Notify caller when any network changes occur
        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
        
        isMonitoring = true
        didStartMonitoringHandler?()
        
    }
    
    // MARK: - Stop Monitoring
    
    public func stopMonitoring() {
        // Check if class is currently monitoring
        guard isMonitoring, let monitor = monitor else { return }
        
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
    
    
    
    
}
