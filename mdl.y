%class_name MdlParser

%preface {
        enum Token {
                case keyword            // mdl
                case punctuation        // .
                case integer(Int)
        }
}

%token_type Token

%nonterminal_type       root            MdlVersion
%nonterminal_type       mdl             MdlVersion
%nonterminal_type       mdl_version     MdlVersion

root            ::= mdl(a).             { return a }
mdl             ::= mdl_version(a).     { return a }
mdl_version     ::= KeywordMdl Integer KeywordDot Integer KeywordSemicolon. {
                        return MdlVersion()
                }
