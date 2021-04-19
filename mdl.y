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
%nonterminal_type       mdl_version             MdlVersion
%nonterminal_type       floating_literal        FloatingLiteral
%nonterminal_type       mdlImport               Import

root            ::= mdl(a). {
                        return a
                }

mdl             ::= mdl_version(a) mdlImport. {
                        return a
                }

mdl_version     ::= KeywordMdl floating_literal(a) KeywordSemicolon. {
                        return MdlVersion(x: a)
                }

mdlImport          ::= KeywordImport KeywordColon KeywordColon Identifier. { // KeywordColon KeywordColon KeywordAsterisk KeywordSemicolon. {
                        return Import()
                }

floating_literal        ::= Integer KeywordDot Integer. {
                        return FloatingLiteral()
                }
