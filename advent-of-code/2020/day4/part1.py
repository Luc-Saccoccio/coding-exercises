file = open('input', 'r')
data = file.read()
file.close()
data = data.split('\n\n')
liste = []
valid = 0
fields = set(["byr","iyr","eyr","hgt","hcl","ecl","pid"])

for d in data:
    tempdata = [item for item in d.split()]
    tempdict = { item.split(':')[0]:item.split(':')[1] for item in tempdata}
    tempdict.pop('cid', None)
    valid += set(tempdict.keys()) == fields

print(valid)
