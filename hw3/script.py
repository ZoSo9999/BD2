for x in range(0, 121):
  if x <=3 :
    print(str(x)+",0-3",file="out.csv")
  elif x <=17 :
    print(str(x)+",3-17")
  elif x <=30 :
    print(str(x)+",18-30")
  elif x <=50 :
    print(str(x)+",31-50")
  elif x <=70 :
    print(str(x)+",51-70")
  elif x <=90 :
    print(str(x)+",71-90")
  else:
    print(str(x)+",91-120")