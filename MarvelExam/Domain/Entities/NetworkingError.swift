//
//  NetworkingError.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import Foundation

enum NetworkingError: String, Error {

    case serviceError = "Error en el servidor"
    case timeout = "Tiempo de espera agotado"
    case invalidForm = "Intente de nuevo más tarde"
    case notPerformed = "Fallo la operación"
    case unknow = "Error inesperado"

}
