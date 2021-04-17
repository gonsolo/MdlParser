%class_name MdlParser

%token_type Int

%nonterminal_type       root    Expression
%nonterminal_type       mdl     Expression

root ::= mdl(a). {
        return a
}

mdl ::= Integer(a). {
        return .number(a)
}
