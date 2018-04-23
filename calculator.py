csv = open("Save2.0Data.csv", "r")


for line in csv.readlines():
	line = line.split(',')
	print line
