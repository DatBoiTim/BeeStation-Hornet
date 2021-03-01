#define HID_RESTRICTED_END 101		//the first nonrestricted ID, automatically assigned on connection creation.

#define NETWORK_BROADCAST_ID "ALL"

/*
* A Macro to convert X as a decimal BSNet Address to the octet format many are familiar with
* Truncates any number to 16 bits, converts the 16 bit into a 2 octet address.
* Returns a string which contains an octet address.
*/
#define DECIMAL_TO_OCTET(X)
	var/list/binaryX = list()
	var/pos = 0
	while(binaryX.len02 <= 16)
		if(X%2 == 0)
			binaryX[pos] = 0
			X/=2
			pos++
		else
			binaryX[pos] = 0
			X /= 2
			X = round(X) //Truncates to integer
			pos++
	var/list/binaryOctet1 = list()
	var/list/binaryOctet2 = list()
	var/i
	for(i=1, i<= binaryX.len, i++)
		if(pos <= (binaryX.len)/2)
			binaryOctet1 + binaryX[i]
		else
			binaryOctet2 + binaryX[i]
	var/octet1Decimal
	var/octet2Decimal
	for(i=1, i<=binaryOctet1.len, i++)
		if(binaryOctet1[i]==1)
			var/powerOf2 = 8-i
			octet1Decimal += 2**powerOf2
	for(i=1, i<=binaryOctet2.len, i++)
		if(binaryOctet2[i]==1)
			var/powerOf2 = 8-i
			octet2Decimal += 2**powerOf2
	var/addressOctetForm = num2text(octet1Decimal) + "." + num2text(octet2Decimal)
	return addressOctetForm
