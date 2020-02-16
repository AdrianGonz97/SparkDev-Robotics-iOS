//
//  UUIDKey.swift
//  Basic Chat
//
//  Created by Trevor Beaton on 12/3/16.
//  Copyright © 2016 Vanguard Logic LLC. All rights reserved.
//

import CoreBluetooth
//Uart Service uuid


let kBLEService_UUID = "0000dfb0-0000-1000-8000-00805f9b34fb"
let kBLE_Characteristic_uuid_Tx = "0000dfb1-0000-1000-8000-00805f9b34fb"
let kBLE_Characteristic_uuid_Rx = "0000dfb1-0000-1000-8000-00805f9b34fb"
let MaxCharacters = 20

let BLEService_UUID = CBUUID(string: kBLEService_UUID)
let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)
