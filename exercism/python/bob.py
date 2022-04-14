def response(hey_bob):
    hey_bob = hey_bob.strip()
    if hey_bob == "":
        return "Fine. Be that way!"
    question = hey_bob[-1] == '?'
    capitals = hey_bob.isupper()
    if question:
        if capitals:
            return "Calm down, I know what I'm doing!"
        return "Sure."
    if capitals:
        return "Whoa, chill out!"
    return "Whatever."
