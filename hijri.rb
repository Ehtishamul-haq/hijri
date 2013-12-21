# comment added by shaghil

def gmod(n,m)
	((n%m)+m)%m
end

def kuwaiticalendar(adjust =0)
	 today =  Time.now
	if adjust && (adjust!=0)
		adjustmili = 1000*60*60*24*adjust
		todaymili = ((Time.now - Time.at(0)) * 1000)+adjustmili
		today = Time.new(todaymili)
	end
	day = today.day
	month = today.month
	year = today.year
	m = month
	y = year


	if(m<3) 
		y -= 1
		m += 12
	end

	a = (y/100.0).floor
	b = 2-a+ (a/4.0).floor
	if y<1583
		b = 0
	end
	if y==1582
		if m>10  
			b = -10
			if m==10 
				b = 0
			end
			if day>4
				b = -10
			end
		end
	end

	jd = (365.25*(y+4716)).floor+(30.6001*(m+1)).floor+day+b-1524
	
	b = 0
	if jd>2299160
		a = ((jd-1867216.25)/36524.25).floor
		b = 1+a-(a/4.0).floor
	end
	bb = jd+b+1524
	cc = ((bb-122.1)/365.25).floor
	dd = (365.25*cc).floor
	ee = ((bb-dd)/30.6001).floor
	day =(bb-dd)-(30.6001*ee).floor
	month = ee-1
	if ee>13
		cc += 1
		month = ee-13
	end
	year = cc-4716

	if adjust
		wd = gmod(jd+1-adjust,7)+1
	else 
		wd = gmod(jd+1,7)+1
	end

	iyear = 10631.0/30.0
	epochas = 1948084
	epochcivil = 1948085

	shift1 = 8.01/60.0
	
	z = jd - epochas
	cyc = (z/10631.0).floor
	z = z-10631*cyc
	j = ((z-shift1)/iyear).floor
	iy = 30*cyc+j
	z = z-(j*iyear+shift1).floor
	im = ((z+28.5001)/29.5).floor
	if im==13
		im = 12
	end
	id = z-(29.5001*im-29).floor

	myRes = []

	myRes[0] = day #calculated day (CE)
	myRes[1] = month-1 #calculated month (CE)
	myRes[2] = year #calculated year (CE)
	myRes[3] = jd-1 #julian day number
	myRes[4] = wd-1 #weekday number
	myRes[5] = id #islamic date
	myRes[6] = im-1 #islamic month
	myRes[7] = iy #islamic year
	 return myRes
end
def writeIslamicDate(adjustment =0) 
	wdNames = ["Ahad","Ithnin","Thulatha","Arbaa","Khams","Jumuah","Sabt"]
	iMonthNames = ["Muharram","Safar","Rabi'ul Awwal","Rabi'ul Akhir", "Jumadal Ula","Jumadal Akhira","Rajab","Sha'ban","Ramadan","Shawwal","Dhul Qa'ada","Dhul Hijja"]
	iDate = kuwaiticalendar(adjustment)
	outputIslamicDate = " #{wdNames[iDate[4]]}, #{iDate[5]}  #{iMonthNames[iDate[6]]}  #{iDate[7]} AH"
	 outputIslamicDate
end

def writeIslamicMonth(adjustment =0 ) 
	iMonthNames = ["Muharram","Safar","Rabi'ul Awwal","Rabi'ul Akhir", "Jumadal Ula","Jumadal Akhira","Rajab","Sha'ban","Ramadan","Shawwal","Dhul Qa'ada","Dhul Hijja"]
	iDate = kuwaiticalendar(adjustment)
	outputIslamicMonth =  iMonthNames[iDate[6]]
	 return outputIslamicMonth
end

# Till this are the ruby methods 

# we can call writeIslamicDate & writeIslamicMonth methods to fetch the date & month respectively

# following is the sample usage of the function which you may delete

puts "Islamic Date is : #{writeIslamicDate}"
puts "Islamic Month is : #{writeIslamicMonth}"
