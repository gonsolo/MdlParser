%class_name MdlParser

%preface {
        enum Token {
                case keyword            // mdl
                case punctuation        // .
                case integer(Int)
                case identifier(String)
        }
}

%token_type Token

%nonterminal_type       root                    MdlVersion
%nonterminal_type       mdl                     MdlVersion
%nonterminal_type       mdlVersion              MdlVersion
%nonterminal_type       floatingLiteral         FloatingLiteral
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

floatingLiteral        ::= Integer KeywordDot Integer . {
                                return FloatingLiteral()
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

simpleName              ::= Identifier . {
                                return Dummy()
                        }

parameterList           ::= . {
                                return Dummy()
                        }

parameterList           ::= parameter . {
                                return Dummy()
                        }

parameter               ::= type . {
                                return Dummy()
                        }



