from datetime import datetime #module for working with dates


def reformat_twofiles(fin1, fin2, fout, indx_check=True):
    """This function takes inputs of an energy and a temperature file. The energy file is unique by date, while the temperature file has multiple entries per one date. After checking that times are sorted from earliest to latest by date, we extract the latest temperature reading in each date. Final output is a csv containing the temperature and energy readings, with energy readings being the last reading on that date"""
    with open(fin1, 'r') as fh:
        #Set global variables for fin1
        linelist = fh.readlines()
        headers = linelist[0]
        energyDates = []
        Wh = []
        currentEnergyDay = []
        n_energy = 0
        for line in linelist[1:len(linelist)-2]:
            if line.strip():
                n_energy +=1
                currentEnergyDay.append(str(n_energy))
                actual_line = line.rstrip('\n').split(',')
                d = actual_line[0].split(' ')
                d_format = datetime.strptime(d[0], '%Y-%m-%d')
                print(d_format)
                energyDates.append(d_format)
                if d[1] != "00:00:00":
                    print("error in time stamp")
                Wh.append(actual_line[1])
        Wh_scale = [float(i)/1000 for i in Wh]  
        print("everything ran without error for ", fin1)
    
    with open(fin2, 'r') as fh:
        #set global variables for fin2
        linelist = fh.readlines()
        headers = ["id", "date", "time", "temp"]
        tempDates = []
        temp = []
        for line in linelist[4:len(linelist)]:
            if line.strip():
                actual_line = line.rstrip('\n').split(',')
                d = actual_line[1].split(' ')
                d_format = datetime.strptime(d[0], '%m/%d/%y')
                tempDates.append(d_format)
                temp.append(actual_line[-1])
            else:
                continue
                
        tenergy = ["" for i in range(len(tempDates))]
        for i in range(len(energyDates)):
            n_energy = tempDates.index(energyDates[i]) - 1
            if n_energy >= 0:
                tenergy[n_energy] = Wh_scale[i]
        print("everything ran without error for ", fin2)

    #Combine output and write to csv
    Timestr = [dt.strftime('%m/%d/%y %I:%M:%S %p') for dt in tempTimeDate] #convert to string
    f = open("../output/test2.csv", 'w')
    for i in range(len(Timestr)):
        f.write("{} {} {}\n".format(Timestr[i], temp[i], tenergy[i]))
    f.close()
                
 
    
    
    
    
    
    
    