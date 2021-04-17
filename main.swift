enum Expression {
        case number(Int)
}

let parser = MdlParser()

typealias TokenData = (token: MdlParser.CitronToken, code: MdlParser.CitronTokenCode)

let lexer = CitronLexer<TokenData>(rules: [

        ])
