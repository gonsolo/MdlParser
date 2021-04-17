%class_name MdlParser

%preface {
        enum Token {
                case keyword            // mdl
                case punctuation        // .
                case integer(Int)
        }
}

%token_type Token

%nonterminal_type       root                    MdlVersion
%nonterminal_type       mdl                     MdlVersion
%nonterminal_type       mdl_version             MdlVersion
%nonterminal_type       floating_literal        FloatingLiteral

root            ::= mdl(a). {
                        return a
                }

mdl             ::= mdl_version(a). {
                        return a
                }

mdl_version     ::= KeywordMdl floating_literal(a) KeywordSemicolon. {
                        return MdlVersion(x: a)
                }

floating_literal        ::= Integer KeywordDot Integer. {
                        return FloatingLiteral()
                }
