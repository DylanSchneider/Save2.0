def calc():
	csv = open("Save2.0Data.csv", "r")
	for line in csv.readlines():
		line = line.split(',')
		if line[5] == prevName:
			continue
		prevName = line[5]
		scoreDiff = line[0]
		inningCount = line[1]
		outsCount = line[6]
		baserunnerCount = 0
		if line[2] != "":
			 baserunnerCount += 1
		if line[3] != "":
                 baserunnerCount += 1
		if line[4] != "":
			 baserunnerCount += 1
		print "Score Diff:" + str(scoreDiff) + ", Inning Count:" + str(inningCount) + ", Outs Count" + str(outsCount)

def main():
	prevname = ""
	calc()
	

if __name__== "__main__":
	main()
