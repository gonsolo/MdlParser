import Foundation

enum Expression {
        case number(Int)
}

let parser = MdlParser()

typealias TokenData = (token: MdlParser.CitronToken, code: MdlParser.CitronTokenCode)

let lexer = CitronLexer<TokenData>(rules: [

        ])

guard CommandLine.argc == 2 else {
        print("Usage: mdl <file>")
        exit(0)
}

let fileName = CommandLine.arguments[1]
let input = try String(contentsOfFile: fileName)
do {
        try lexer.tokenize(input) { (t, c) in 
                try parser.consume(token: t, code: c)
        }
        let tree = try parser.endParsing()
        print(tree)
} catch (let error) {
        print("Error \(error)")
}
