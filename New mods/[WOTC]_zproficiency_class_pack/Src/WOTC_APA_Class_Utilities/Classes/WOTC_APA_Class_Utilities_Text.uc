
class WOTC_APA_Class_Utilities_Text extends Object;


// Float values converted to strings output with lots of extra zeros - this trims the output string to just the important digits
// Primarily for localization tags... Ex: "2.0500" outputs "2.05" or "2.0000" outputs "2"
simulated static function TrimTrailingZerosFromFloat(float InputValue, out string text)
{
	text = string(InputValue);

	while ((Len(text) > 0) && (InStr(text, "0", true) == Len(text) - 1))
		text = left(text, Len(text) - 1);
	while ((Len(text) > 0) && (InStr(text, ".", true) == Len(text) - 1))
		text = left(text, Len(text) - 1);
}


simulated static function RoundUpFloat(float InputValue, out int i)
{

	if (InputValue - int(InputValue) > 0)
	{
		i = int(InputValue) + 1;
	}
	else
	{
		i = InputValue;
	}
}