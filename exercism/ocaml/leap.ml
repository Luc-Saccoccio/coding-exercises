let leap_year n = n mod 400 == 0 || ((not (n mod 100 == 0)) && n mod 4 == 0)
