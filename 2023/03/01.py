s = set(["#","%","&","*","+","-","/","=","@","$"])
d = [str(n) for n in range(10)]
a = []

with open("input.txt", "r") as f:
    for l in f:
        a += [[*l][:-1]]

r, c = len(a) - 1, len(a[0]) - 1


def adj(i, j):
    if i > 0 and a[i-1][j] in s: return True             # n
    if j < c and a[i][j+1] in s: return True             # e
    if i < r and a[i+1][j] in s: return True             # s
    if j > 0 and a[i][j-1] in s: return True             # w
    if i > 0 and j < c and a[i-1][j+1] in s: return True # ne
    if i < r and j < c and a[i+1][j+1] in s: return True # se
    if i < r and j > 0 and a[i+1][j-1] in s: return True # sw
    if i > 0 and j > 0 and a[i-1][j-1] in s: return True # nw
    return False


part_sum = 0

for i in range(r+1):
    n, p, has_adj = 0, 0, False
    for j in reversed(range(c+1)): # visit numbers in their inreasing power.,,,
        cur = a[i][j]
        if cur in d:
            n += int(cur) * 10**p  # no casting or stacks :p ,,,,,,,,,,,,,,,,,,
            p += 1
            if not has_adj and adj(i, j):
                has_adj = True
        else:
            if has_adj:
                part_sum += n
            n, p, has_adj = 0, 0, False
    if has_adj:
        part_sum += n

print(part_sum)
