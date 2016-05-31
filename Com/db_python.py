import sys
import os
import sqlite3 as lite
import RPi.GPIO as GPIO
#initialize the device
GPIO.setmode(GPIO.BOARD)


con = None 

try:
	con = lite.connect('test2.db')
	
	with con:

		cur = con.cursor()
		
                cur2 = con.cursor()
                cur2.execute("SELECT * FROM target_value;")

                rows2 = cur2.fetchall()

		def hot():
			pin = 11
			return row[0]<rows[0][0]

		def dark():
			return row[0]>rows[0][0]

		def hum_air():
			return row[0]>rows[0][0]

		def hum_sol():
                        return row[0]>rows[0][0]		
		
		options = {1 : hot, 4 : dark, 2 : hum_air, 3: hum_sol}
		pins = {1 : 11, 2 : 13, 3 : 15, 4: 12}
		
		for row in rows2:

			cur.execute("SELECT * FROM value where  data_card_id = 1 AND value_type_id = "+str(row[1])+";")
                	rows = cur.fetchall()
	
						
			if not rows:
				print "empty"
			else:
				if options[row[1]]():
					GPIO.setup(pins[row[1]],GPIO.OUT)
					GPIO.output(pins[row[1]],1)		
					print "yay"
				else: 
					GPIO.setup(pins[row[1]],GPIO.IN)
					#GPIO.output(pins[row[1]],0)
					print "nan"
			

			
			
			
	cur = con.cursor()
	cur.execute('SELECT SQLITE_VERSION()')
	
	data = cur.fetchone()
	
	print "SQLite version: %s" % data

except lite.Error, e:
	
	print "Error %s:" % e.args[0]
	sys.exit(1)

finally:
	
	if con:
		con.close()
