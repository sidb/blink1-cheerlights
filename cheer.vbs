sysTest = blink1("id")
If sysTest = "" Then
	echo "No webserver"
	WScript.Quit
ElseIf InStr(sysTest, "00000000") > 0 Then
	echo "No blink(1)"
	WScript.Quit
End If

Set colDict = CreateObject("Scripting.Dictionary")
colDict.Add "Red", "FF0000"
colDict.Add "Orange", "FF9C00"
colDict.Add "Yellow", "FFDE00"
colDict.Add "Green", "00FF00"
colDict.Add "Cyan", "00FFFF"
colDict.Add "Blue", "0000FF"
colDict.Add "Magenta", "FF00DE"
colDict.Add "Purple", "CD00FF"
colDict.Add "Warmwhite", "FFEBAF"
colDict.Add "White", "FFF4F0"
colKeys = colDict.Keys

colCheer = getCheerlights

For Each strKey in colKeys
	If LCase(colCheer) = LCase(strKey) Then
		echo "Setting cheerlights to " & strKey & " " & colDict.Item(strKey)
		Call blink1("pattern/stopall")
		Call blink1("fadeToRGB?rgb=%23" & colDict.Item(strKey) & "&time=0.01")
		Exit For
	End If
Next

'################################
Function blink1(strUrl)
	strUrl = "http://localhost:8934/blink1" & "/" & strUrl
	echo "GET:" & strUrl
	On Error Resume Next
	Err.Clear
	Set http = CreateObject("Microsoft.XmlHttp")
	If Err.Number = 0 Then http.Open "GET", strUrl, False
	If Err.Number = 0 Then http.Send
	If Err.Number = 0 And http.Status = 200 Then
		blink1 = http.responseText
	End If
	Set http = Nothing
	Err.Clear
	On Error Goto 0
End Function

Function getCheerlights
	strUrl = "http://api.thingspeak.com/channels/1417/field/1/last.txt"
	echo "getCheerlights"
	Set http = CreateObject("Microsoft.XmlHttp")
	http.Open "GET", strUrl, False
	http.Send
	If http.Status = 200 Then
		getCheerlights = http.responseText
	End If
	Set http = Nothing
End Function

Function echo(strText)
	If False Then WScript.Echo strText
End Function

'################################
