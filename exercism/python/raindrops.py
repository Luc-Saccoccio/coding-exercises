def convert(number: int) -> str:
    res = ""
    if not number%3:
        res += "Pling"
    if not number%5:
        res += "Plang"
    if not number%7:
        res += "Plong"
    return res if res != "" else str(number)
