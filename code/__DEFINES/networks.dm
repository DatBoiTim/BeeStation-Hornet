#define HID_RESTRICTED_END 101		//the first nonrestricted ID, automatically assigned on connection creation.

#define NETWORK_BROADCAST_ID "ALL"

/*
* A Macro to convert X as a decimal BSNet Address to the octet format many are familiar with
* Truncates any number to 16 bits, converts the 16 bit into a 2 octet address.
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
#define DECIMAL_ADDRESS_TO_OCTET_FORMAT(X) \
	var/__POS = 1; \
	var/list/__BINARYX = list() ; \ //List which is the 16 binary form of x
	while(__BINARYX.len <= 16) { ; \ //Populating the list binaryX. Decimal to Binary Conversion
		if(X%2 == 0) { ; \
			__BINARYX[__POS] = 0 ; \
			X = X / 2 ; \
			__POS++ ; \
		} else { ; \
			__BINARYX[__POS] = 1 ; \
			X = X / 2 ; \
			X = round(X) ; \ //Truncates X to an everything before a decimal place
			__POS++ ; \
		} ; \
	} ; \
	var/list/__BINARYOCTET1 = list(); \
	var/list/__BINARYOCTET2 = list(); \
	var/__I; \
	__POS = 1; \ //Resetting pos for iterating population of binaryOctet2
	for(__I = 1, __I <= __BINARYX.len, __I++) {; \ //Split to Octets
		if(__I <= (__BINARYX.len) / 2) {;\
			__BINARYOCTET1[__I] = __BINARYX[__I]; \
		} else {; \
			__BINARYOCTET2[__POS] = __BINARYX[__I]; \
			__POS++; \
		}; \
	}; \
	var/__DECIMALOCTET1 = 0; \
	var/__DECIMALOCTET2 = 0; \
	for(__I = 1, __I <= __BINARYOCTET1.len, __I++) {; \ //Binary To Decimal
		if(__BINARYOCTET1[__I] == 1) {; \
			var/__POWEROF2 = 8 - __I; \
			__DECIMALOCTET1 += 2**__POWEROF2; \
		}; \
	}; \
	for(__I = 1, __I <= __BINARYOCTET2.len, __I++) {; \
		if(__BINARYOCTET2[__I] == 1) {; \
			var/__POWEROF2 = 8 -__I; \
			__DECIMALOCTET2 += 2**__POWEROF2; \
		}; \
	}; \
	var/__ADDRESSOCTETFORM = ""; \
	var/__OCTET1 = ""; \
	var/__OCTET2 = ""; \
	__OCTET1 += num2text(__DECIMALOCTET1); \
	__OCTET2 += num2text(__DECIMALOCTET2); \
	__ADDRESSOCTETFORM = __OCTET1 + "." + __OCTET2; \
	return __ADDRESSOCTETFORM; \
