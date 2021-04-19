// [] optional
// {} zero or more


%class_name MdlParser

%preface {
        enum Token {
                case keyword            // mdl
                case punctuation        // .
                case integer(Int)
                case float(Float)
                case string(String)
                case identifier(String)
        }
}

%token_type Token

%nonterminal_type       root                    MdlVersion
%nonterminal_type       mdl                     MdlVersion
%nonterminal_type       mdlVersion              MdlVersion
%nonterminal_type       floatingLiteral         Dummy
%nonterminal_type       stringLiteral           Dummy
%nonterminal_type       zeroOrMoreStringLiterals        Dummy
%nonterminal_type       mdlImports              Import
%nonterminal_type       mdlImport               Import
%nonterminal_type       globalDeclaration       Dummy
%nonterminal_type       functionDeclaration     Dummy
%nonterminal_type       type                    Dummy
%nonterminal_type       simpleType              Dummy
%nonterminal_type       frequencyQualifier      Dummy
%nonterminal_type       simpleName              Dummy
%nonterminal_type       parameterList           Dummy
%nonterminal_type       parameter               Dummy
%nonterminal_type       assignmentExpression    Dummy
%nonterminal_type       postfixExpression       Dummy
%nonterminal_type       primaryExpression       Dummy
%nonterminal_type       argumentList            Dummy
%nonterminal_type       annotationBlock         Dummy
%nonterminal_type       annotationList          Dummy
%nonterminal_type       annotation              Dummy
%nonterminal_type       qualifiedName           Dummy
%nonterminal_type       literalExpression       Dummy
%nonterminal_type       positionalArguments     Dummy
%nonterminal_type       positionalArgument      Dummy
%nonterminal_type       expression              Dummy
%nonterminal_type       letExpression           Dummy

root                    ::= mdl(a) . {
                                print("root")
                                return a
                        }

mdl                     ::= mdlVersion(a) mdlImports KeywordExport globalDeclaration . {
                                print("mdl")
                                return a
                        }

mdlVersion              ::= KeywordMdl floatingLiteral(a) KeywordSemicolon . {
                                print("mdlVersion")
                                return MdlVersion(x: a)
                        }

mdlImports              ::= . {
                                return Import();
                        }

mdlImports              ::= mdlImport mdlImports . {
                                return Import()
                        }

mdlImport               ::= KeywordImport KeywordColon KeywordColon Identifier KeywordColon KeywordColon KeywordAsterisk KeywordSemicolon . {
                                return Import()
                        }

floatingLiteral        ::= Float(a) . {
                                print("floatingLiteral \(a)")
                                return Dummy()
                        }

stringLiteral           ::= String . {
                                return Dummy()
                        }

globalDeclaration       ::= functionDeclaration . {
                                print("globalDeclaration")
                                return Dummy()
                        }

functionDeclaration     ::= type simpleName KeywordParenOpen parameterList KeywordParenClose annotationBlock KeywordEquals expression . {
                                print("functionDeclaration")
                                return Dummy()
                        }

type                    ::= simpleType . {
                                print("no freq type")
                                return Dummy()
                        }

type                    ::= frequencyQualifier simpleType . {
                                print("type freq simple type")
                                return Dummy()
                        }

frequencyQualifier      ::= KeywordUniform . {
                                print("freq uniform")
                                return Dummy()
                        }

simpleType              ::= KeywordMaterial . {
                                print("simple type material")
                                return Dummy()
                        }

simpleType              ::= KeywordColor . {
                                print("simple type color")
                                return Dummy()
                        }

simpleType              ::= KeywordFloat . {
                                print("simple type float")
                                return Dummy()
                        }

simpleName              ::= Identifier(a) . {
                                print("simpleName \(a)")
                                return Dummy()
                        }

parameterList           ::= . {
                                print("empty parameterList")
                                return Dummy()
                        }

parameterList           ::= parameter . {
                                print("one parameter list")
                                return Dummy()
                        }

parameterList           ::= parameter KeywordComma parameterList . {
                                print("full parameter list")
                                return Dummy()
                        }

parameter               ::= type simpleName . {
                                print("parameter")
                                return Dummy()
                        }
parameter               ::= type simpleName KeywordEquals assignmentExpression annotationBlock . {
                                print("parameter =")
                                return Dummy()
                        }

annotationBlock         ::= KeywordBracketOpen KeywordBracketOpen annotationList KeywordBracketClose KeywordBracketClose . {
                                return Dummy()
                        }

annotationList          ::= annotation . {
                                return Dummy()
                        }

annotationList          ::= annotation KeywordComma annotationList . {
                                return Dummy()
                        }

annotation              ::= qualifiedName argumentList . {
                                print("annotation")
                                return Dummy()
                        }

qualifiedName           ::= simpleName KeywordColon KeywordColon simpleName . {
                                print("qualifiedName")
                                return Dummy()
                        }

assignmentExpression    ::= postfixExpression . {
                                print("assignmentExpression")
                                return Dummy()
                        }
postfixExpression       ::= primaryExpression . {
                                print("postfix primary")
                                return Dummy()
                        }

postfixExpression       ::= primaryExpression argumentList . {
                                print("postfix with argumentList")
                                return Dummy()
                        }

primaryExpression       ::= simpleType . {
                                print("primary simple type")
                                return Dummy()
                        }

primaryExpression       ::= literalExpression . {
                                print("primary literal")
                                return Dummy()
                        }

literalExpression       ::= floatingLiteral . {
                                print("literal float")
                                return Dummy()
                        }

literalExpression       ::= stringLiteral zeroOrMoreStringLiterals . {
                                print("literalExpression")
                                return Dummy()
                        }

zeroOrMoreStringLiterals        ::= . {
                                print("zero string literal")
                                return Dummy()
                        }

zeroOrMoreStringLiterals        ::= stringLiteral zeroOrMoreStringLiterals . {
                                print("stringLiteral+")
                                return Dummy()
                        }

argumentList            ::= KeywordParenOpen positionalArguments KeywordParenClose . {
                                print("argumentList")
                                return Dummy()
                        }

positionalArguments     ::= positionalArgument . {
                                print("one pos args")
                                return Dummy()
                        }

positionalArguments     ::= positionalArgument KeywordComma positionalArguments . {
                                print("non-empty pos args")
                                return Dummy()
                        }

positionalArgument      ::= assignmentExpression . {
                                print("positionalArgument")
                                return Dummy()
                        }

expression              ::= letExpression . {
                                return Dummy()
                        }

letExpression            ::= KeywordLet KeywordBraceOpen KeywordBraceClose . {
                                return Dummy()
                        }
