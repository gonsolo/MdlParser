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

functionDeclaration       ::= KeywordMaterial Identifier KeywordParenOpen KeywordParenClose . {
                                return Dummy()
                        }
