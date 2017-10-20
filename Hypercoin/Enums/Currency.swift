//
//  Currency.swift
//  Hypercoin
//
//  Created by Axel Etcheverry on 20/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Foundation

public enum CurrencyType {
    case aud
    case brl
    case cad
    case chf
    case clp
    case cny
    case czk
    case dkk
    case eur
    case gbp
    case hkd
    case huf
    case idr
    case ils
    case inr
    case jpy
    case krw
    case mxn
    case myr
    case nok
    case nzd
    case php
    case pkr
    case pln
    case rub
    case sek
    case sgd
    case thb
    case `try`
    case twd
    case zar

    static let allValues = [
        aud, brl, cad, chf, clp, cny,
        czk, dkk, eur, gbp, hkd, huf,
        idr, ils, inr, jpy, krw, mxn,
        myr, nok, nzd, php, pkr, pln,
        rub, sek, sgd, thb, `try`, twd,
        zar
    ]
}
