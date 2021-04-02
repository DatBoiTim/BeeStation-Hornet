//A File Dedicated to all procs which involve binary numbers and their manipulation
//These can range from Binary Conversion/Deconversion and more
/*
* A Macro to convert X as a decimal BSNet Address to the octet format many are familiar with
* Truncates any number to 16 bits, converts the 16 bit into a 2 octet decimal address.
* Returns a string which contains an octet address.
*
* Binary Conversion:
*	Check if Number is perfectly divisible by 2;
*	Yes: Write 0 to array @ bit position, divide x by 2, iterate bit position;
*	No: Write 1 to array @ bit position, divide x by 2, truncate x to integer, iterate bit position;
*	End: 16 bits written to array;
*
* Split to Octets:
* 	For each bit;
* 		Check if position of bit is in first octet;
*		Yes: Write bit to first octet, iterate
*		No: Write bit to second octet, iterate
*
* Binary to Decimal:
* 	For each bit;
*		Check if bit is equal to 1;
* 		Yes: Calculate power of 2 from bit position, raise 2 to powerOf2, add to decimalOctet, iterate
* 		No: Iterate
*/
/proc/decimal_address_to_octet_format(x)
	var/pos = 1
	var/list/binaryX = list()
	while(binaryX.len <= 16) //Decimal to Binary
		if(x%2 == 0)
			binaryX[pos] = 0
			x = x / 2
			pos++
		else
			binaryX[pos] = 1
			x = x / 2
			x = round(x)
			pos++
	var/list/binaryOctet1 = list()
	var/list/binaryOctet2 = list()
	var/i
	pos = 1
	for(i = 1, i <= binaryX.len, i++) //Split Binary into two Octets
		if(i <= (binaryX.len) / 2)
			binaryOctet1[i] = binaryX[i]
		else
			binaryOctet2[pos] = binaryX[i]
			pos++
	var/decimalOctet1 = 0
	var/decimalOctet2 = 0
	for(i = 1, i <= binaryOctet1.len, i++) //Binary to Decimal
		if(binaryOctet1[i] == 1)
			var/powerOf2 = 8 - i
			decimalOctet1 += 2**powerOf2
	for(i = 1, i <= binaryOctet2.len, i++)
		if(binaryOctet2[i] == 1)
			var/powerOf2 = 8 -i
			decimalOctet2 += 2**powerOf2
	var/addressOctetForm = ""
	var/octet1 = ""
	var/octet2 = ""
	octet1 += num2text(decimalOctet1)
	octet2 += num2text(decimalOctet2)
	addressOctetForm = octet1 + "." + octet2
	return addressOctetForm
