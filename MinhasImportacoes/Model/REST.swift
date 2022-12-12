//
//  REST.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//

import Foundation

//Listagem de possiveis erros
enum loadError{
    // Erro de URL
    case url
    // Erro na realizacao da tarefa
    case taskError(error: Error)
    // Erro de resposta
    case noResponse(currencyType: String)
    // Erro no dado recebido
    case noData (currencyType: String)
    //erro vindos com Status HTTP
    case responseStatusCode(code: Int)
    //Erro de JSON
    case invalidJson(currencyType: String)
}

class REST {
    
    //Caminhos bases para cada um das moedas
    static let dolarBasePath = "https://economia.awesomeapi.com.br/last/USD-BRL"
    static let euroBasePath = "https://economia.awesomeapi.com.br/last/EUR-BRL"
    static let bitcoinBasePath = "https://economia.awesomeapi.com.br/last/BTC-BRL"
    
    private static let configuration: URLSessionConfiguration = {
        //Cria um configurador padrao
        let config = URLSessionConfiguration.default
        // Configura o cabecalho dessa sessao como sendo uma application tipo Json
        config.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        //Configura o tempo maximo para obter a requisicao
        config.timeoutIntervalForRequest = 60.0
        return config
    }()
    
    //cria uma sessao compartilhada
    private static let session = URLSession(configuration: configuration)
    
    //MARK: LoadDolar
    
    
    //Funcao de classe, que pode ser usada sem a necessidade de instanciar ela
    //Funcao para realizar um "GET" no valor atual do dolar
    class func loadDolar(onComplete: @escaping (dolar) -> Void, onError: @escaping (loadError) -> Void ) {
        //Type de moeda
        let typeDolar = "dolar"
        // Desembrulha a URL, ou retorna um erro.
        guard let urlDolar = URL(string: dolarBasePath) else {
            onError(.url)
            return
        }
        // cria a tarefa da sessao
        let dataTask = session.dataTask(with: urlDolar) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil{
                // Desembrulha a resposta do servidor, ou retorna um erro.
                guard let response = response as? HTTPURLResponse else {
                    onError (.noResponse(currencyType: typeDolar))
                    return
                }
                // Verifica se a resposta esta de acordo com o esperado,  ou retorna um erro.
                if response.statusCode == 200 {
                    // Desembrulha os dados, ou retorna um erro.
                    guard let data = data else {
                        onError(.noData(currencyType: typeDolar))
                        return
                    }
                    
                    do{
                        // Decodifica o JSON recebido,ou retorna um erro.
                        let dolarNow = try JSONDecoder().decode(dolar.self, from: data)
                        onComplete(dolarNow)
                    } catch {
                        onError(.invalidJson(currencyType: typeDolar))
                        return
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else{
                onError(.taskError(error: error!))
            }
            
        }
        
        //Executa a tarefa de sessão
        dataTask.resume()
        
    }
    
    //MARK: LoadEuro
    
    //Funcao de classe, que pode ser usada sem a necessidade de instanciar ela
    //Funcao para realizar um "GET" no valor atual do Euro
    class func loadEuro(onComplete: @escaping (euro)-> Void, onError: @escaping (loadError) -> Void ) {
        //Type de moeda
        let typeEuro = "Euro"
        // Desembrulha a URL, ou retorna um erro.
        guard let urlEuro = URL(string: euroBasePath) else {
            onError(.url)
            return
        }
        // cria a tarefa da sessao
        let dataTask = session.dataTask(with: urlEuro) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil{
                // Desembrulha a resposta do servidor, ou retorna um erro.
                guard let response = response as? HTTPURLResponse else {
                    onError (.noResponse(currencyType: typeEuro))
                    return
                }
                // Verifica se a resposta esta de acordo com o esperado,  ou retorna um erro.
                if response.statusCode == 200 {
                    // Desembrulha os dados, ou retorna um erro.
                    guard let data = data else {
                        onError(.noData(currencyType: typeEuro))
                        return
                    }
                    
                    do{
                        // Decodifica o JSON recebido,ou retorna um erro.
                        let euroNow = try JSONDecoder().decode(euro.self, from: data)
                        onComplete(euroNow)
                    } catch {
                        onError(.invalidJson(currencyType: typeEuro))
                        return
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else{
                onError(.taskError(error: error!))
            }
            
        }
        
        //Executa a tarefa de sessão
        dataTask.resume()
        
    }
    
    //MARK: LoadBitcoin
     
    //Funcao de classe, que pode ser usada sem a necessidade de instanciar ela
    //Funcao para realizar um "GET" no valor atual do Bitcoin
    class func loadBitcoin(onComplete: @escaping (bitcoin)-> Void, onError: @escaping (loadError) -> Void ) {
        //Type de moeda
        let typeBitcoin = "Bitcoin"
        // Desembrulha a URL, ou retorna um erro.
        guard let urlBitcoin = URL(string: bitcoinBasePath) else {
            onError(.url)
            return
        }
        // cria a tarefa da sessao
        let dataTask = session.dataTask(with: urlBitcoin) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil{
                // Desembrulha a resposta do servidor, ou retorna um erro.
                guard let response = response as? HTTPURLResponse else {
                    onError (.noResponse(currencyType: typeBitcoin))
                    return
                }
                // Verifica se a resposta esta de acordo com o esperado,  ou retorna um erro.
                if response.statusCode == 200 {
                    // Desembrulha os dados, ou retorna um erro.
                    guard let data = data else {
                        onError(.noData(currencyType: typeBitcoin))
                        return
                    }
                    
                    do{
                        // Decodifica o JSON recebido,ou retorna um erro.
                        let bitcoinNow = try JSONDecoder().decode(bitcoin.self, from: data)
                        onComplete(bitcoinNow)
                    } catch {
                        onError(.invalidJson(currencyType: typeBitcoin))
                        return
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else{
                onError(.taskError(error: error!))
            }
            
        }
        
        //Executa a tarefa de sessão
        dataTask.resume()
        
    }
    
    
    
    
    
}
