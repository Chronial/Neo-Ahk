# -*- coding: utf-8 -*-

keymap = [
    ('x', 'PGUP'),
    ('v', 'BACKSPACE'),
    ('l', 'UP'),
    ('c', 'DEL'),
    ('w', 'PGDN'),
    
    ('u', 'HOME'),
    ('i', 'LEFT'),
    ('a', 'DOWN'),
    ('e', 'RIGHT'),
    ('o', 'END'),
    
    ('ü', 'ESC'),
    ('ö', 'TAB'),
    ('ä', 'INS'),
    ('p', 'ENTER'),
]


block = """
*{0}::
if (isMod4Active and !isMod3Pressed) {{
	Send {{Blind}}{{{1} DownTemp}}
	key_{0}_down_mod := 1
}} else {{
	Send {{Blind}}{{{0} DownTemp}}
	key_{0}_down := 1
}}
return

*{0} up::
if (key_{0}_down){{
    Send {{Blind}}{{{0} up}}
    key_{0}_down := 0
}}
if (key_{0}_down_mod){{
    Send {{Blind}}{{{1} up}}
    key_{0}_down_mod := 0
}}
return"""

blocks = []

for (x,y) in keymap:
    blocks.append(block.format(x,y))
    
print "\n\n".join(blocks)
