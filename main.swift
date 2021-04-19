import Foundation

enum Expression {
        case number(Int)
}

struct FloatingLiteral {}
struct MdlVersion { let x: FloatingLiteral }
struct Import {}
struct Dummy {}

let parser = MdlParser()

typealias TokenData = (token: MdlParser.CitronToken, code: MdlParser.CitronTokenCode)

let lexer = CitronLexer<TokenData>(
        rules: [

                // Keywords
                .string("mdl",          (.keyword, .KeywordMdl)),
                .string("import",       (.keyword, .KeywordImport)),
                .string("export",       (.keyword, .KeywordExport)),
                .string("material",     (.keyword, .KeywordMaterial)),
                .string("uniform",      (.keyword, .KeywordUniform)),
                .string("color",        (.keyword, .KeywordColor)),
                .string(":",            (.keyword, .KeywordColon)),
                .string(";",            (.keyword, .KeywordSemicolon)),
                .string("*",            (.keyword, .KeywordAsterisk)),
                .string("(",            (.keyword, .KeywordParenOpen)),
                .string(")",            (.keyword, .KeywordParenClose)),
                .string("=",            (.keyword, .KeywordEquals)),

                // Numbers
                //.regexPattern("[0-9]+", { str in
                //        if let number = Int(str) {
                //                return (.integer(number), .Integer)
                //        }
                //        return nil
                //}),

                .regexPattern("[0-9]+\\.[0-9]+", { str in
                        if let number = Float(str) {
                                return (.float(number), .Float)
                        }
                        return nil
                }),

                // Identifiers
                .regexPattern("[a-zA-Z0-9_]+", { str in
                        (.identifier(str), .Identifier)
                }),


                // Comments
                .regexPattern("/[*]((.|\n)*?)[*]/", { _ in nil }),

                // Whitespace
                .regexPattern("\\s", { _ in nil })
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
