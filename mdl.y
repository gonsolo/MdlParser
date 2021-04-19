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

root                    ::= mdl(a) . {
                                return a
                        }

mdl                     ::= mdlVersion(a) mdlImports KeywordExport globalDeclaration . {
                                return a
                        }

mdlVersion              ::= KeywordMdl floatingLiteral(a) KeywordSemicolon . {
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

floatingLiteral        ::= Float . {
                                return Dummy()
                        }

stringLiteral            ::= String . {
                                return Dummy()
                        }

globalDeclaration       ::= functionDeclaration . {
                                return Dummy()
                        }

functionDeclaration     ::= type simpleName KeywordParenOpen parameterList KeywordParenClose . {
                                return Dummy()
                        }

type                    ::= simpleType . {
                                return Dummy()
                        }

type                    ::= frequencyQualifier simpleType . {
                                return Dummy()
                        }

frequencyQualifier      ::= KeywordUniform . {
                                return Dummy()
                        }

simpleType              ::= KeywordMaterial . {
                                return Dummy()
                        }

simpleType              ::= KeywordColor . {
                                return Dummy()
                        }

simpleType              ::= KeywordFloat . {
                                return Dummy()
                        }

simpleName              ::= Identifier . {
                                return Dummy()
                        }

parameterList           ::= . {
                                return Dummy()
                        }

parameterList           ::= parameter . {
                                return Dummy()
                        }

parameterList           ::= parameter KeywordComma parameterList . {
                                return Dummy()
                        }

parameter               ::= type simpleName KeywordEquals assignmentExpression annotationBlock . {
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
                                return Dummy()
                        }

qualifiedName           ::= simpleName KeywordColon KeywordColon simpleName . {
                                return Dummy()
                        }

assignmentExpression    ::= postfixExpression . {
                                return Dummy()
                        }

postfixExpression       ::= primaryExpression argumentList . {
                                return Dummy()
                        }

primaryExpression       ::= simpleType . {
                                return Dummy()
                        }

primaryExpression       ::= literalExpression . {
                                return Dummy()
                        }

literalExpression       ::= floatingLiteral . {
                                return Dummy()
                        }

literalExpression       ::= stringLiteral . {
                                return Dummy()
                        }

argumentList            ::= . {
                                return Dummy()
                        }

argumentList            ::= KeywordParenOpen positionalArguments KeywordParenClose . {
                                return Dummy()
                        }

positionalArguments     ::= positionalArgument . {
                                return Dummy()
                        }

positionalArguments     ::= positionalArgument KeywordComma positionalArguments . {
                                return Dummy()
                        }

positionalArgument      ::= assignmentExpression . {
                                return Dummy()
                        }

