#!/usr/bin/env python3

import sys

cmd = sys.argv[1]
path = '/sys/class/backlight/intel_backlight/brightness'

curr = int(open(path, 'r').read().strip())

if cmd[0] == '+':
    sign = 1
elif cmd[0] == '-':
    sign = -1
else:
    print('Invalid command')
    sys.exit(1)

next = int(curr * (1 + sign*float(cmd[1:])/100.0))

print(cmd)
print(curr)
print(next)

# write next to the file
open(path, 'w').write(str(next) + "\n")

