#!/usr/bin/env python3

import yaml
import shlex
from os import path

home = path.expanduser("~")

def alias(al, value):
	return'alias %s=%s' % (al, shlex.quote(value))

with open(path.join(home, '.aliases.yaml')) as file:
	doc = yaml.load(file)
	lines = [alias(k, v) for k, v in doc.items()]
	print('\n'.join(lines))