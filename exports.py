#!/usr/bin/env python3

import yaml
import shlex
from os import path

home = path.expanduser("~")

def export(var, values):
	if isinstance(values, str):
		value = values
	else:
		value = ':'.join(values)
	return'export %s=%s' % (var, value)

with open(path.join(home, 'dotfiles/exports.yaml')) as file:
	doc = yaml.load(file)
	lines = [export(k, v) for k, v in doc.items()]
	print('\n'.join(lines))
