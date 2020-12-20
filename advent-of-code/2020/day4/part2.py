import re

file = open('input', 'r')
data = file.read()
file.close()
data = data.split('\n\n')
liste = []
valid = 0
fields = set(["byr","iyr","eyr","hgt","hcl","ecl","pid"])


def test(dico):
    tests = {
            "byr": lambda value: 1920 <= int(value) <= 2002,
            "iyr": lambda value: 2010 <= int(value) <= 2020,
            "eyr": lambda value: 2020 <= int(value) <= 2030,
            "hgt": lambda value: ((value.endswith('cm') and 150 <= int(value[0:-2]) <= 193) or (value.endswith('in') and 59 <= int(value[0:-2]) <= 76)),
            "hcl": lambda value: re.match("^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$", value),
            "ecl": lambda value: re.match("^(amb|blu|brn|gry|grn|hzl|oth)$", value),
            "pid": lambda value: re.match("^[0-9]{9}$", value)
            }
    for item in dico:
        if not tests[item](dico[item]):
                return False
        print(item, dico[item])
    return True

for d in data:
    tempdata = [item for item in d.split()]
    tempdict = { item.split(':')[0]:item.split(':')[1] for item in tempdata}
    tempdict.pop('cid', None)
    valid += (test(tempdict) and set(tempdict.keys()) == fields)

print(valid)
