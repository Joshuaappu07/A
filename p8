def negation(literal):
    if literal.startswith("~"):return literal[1:]
    else:return "~"+literal
def resolve(clause1,clause2):
    resolvents=[]
    for literal1 in clause1:
        for literal2 in clause2:
            if literal1==negation(literal2):
                resolvent=[lit for lit in(clause1+clause2)if lit!=literal1 and lit!=literal2]
                if resolvent not in resolvents:resolvents.append(resolvent)
                break
    return resolvents
def resolve_all(clauses):
    new_clauses=[]
    for i,clause1 in enumerate(clauses):
        for clause2 in clauses[i+1:]:
            for r in resolve(clause1,clause2):
                if r not in new_clauses:new_clauses.append(r)
    return new_clauses
def resolution(kb):
    clauses=[[lit.strip()for lit in clause.replace("(","").replace(")","").split("||")]for clause in kb]
    while True:
        new_clauses=resolve_all(clauses)
        for clause in new_clauses:
            if not clause:print("Empty clause found");return "Unsatisfiable"
        if not new_clauses:return "Satisfiable"
        for c in new_clauses:
            if c not in clauses:clauses.append(c)
        if len(clauses)==len(clauses[:len(clauses)-len(new_clauses)]+new_clauses):return "Satisfiable"
knowledge_base=["(P || Q || ~R)","(~P || R)","(~Q || R)","(~R || ~P || Q)"]
result=resolution(knowledge_base)
print("Knowledge Base Status:",result)
