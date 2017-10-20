//
//  Currency.swift
//  Hypercoin
//
//  Created by Axel Etcheverry on 20/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Foundation

public enum CurrencyType: String {
    case aud = "aud"
    case brl = "brl"
    case cad = "cad"
    case chf = "chf"
    case clp = "clp"
    case cny = "cny"
    case czk = "czk"
    case dkk = "dkk"
    case eur = "eur"
    case gbp = "gbp"
    case hkd = "hkd"
    case huf = "huf"
    case idr = "idr"
    case ils = "ils"
    case inr = "inr"
    case jpy = "jpy"
    case krw = "krw"
    case mxn = "mxn"
    case myr = "myr"
    case nok = "nok"
    case nzd = "nzd"
    case php = "php"
    case pkr = "pkr"
    case pln = "pln"
    case rub = "rub"
    case sek = "sek"
    case sgd = "sgd"
    case thb = "thb"
    case `try` = "try"
    case twd = "twd"
    case zar = "zar"

    static let allValues = [
        aud, brl, cad, chf, clp, cny,
        czk, dkk, eur, gbp, hkd, huf,
        idr, ils, inr, jpy, krw, mxn,
        myr, nok, nzd, php, pkr, pln,
        rub, sek, sgd, thb, `try`, twd,
        zar
    ]
}
