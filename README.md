blink1-cheerlights
==================

A Windows Scripting Host (WSH) VBScript to set ThingM's blink(1) to the current CheerLights color using Blink1Control.

The blink(1) should be working with a running instance of Blink1Control. This script polls the CheerLights API and sets the blink(1) colour via the local Web API.

To test the script, enter the following in a command shell:

<code>cscript cheer.vbs</code>

Once you're up and running, add a Scheduled Task to call the script every 5 minutes:

<code>schtasks /create /sc minute /mo 5 /tn "Blink(1) CheerLights" /tr "wscript 'D:\Scripts\cheer.vbs'"</code>

Make sure that the last argument is the correct path to your script. To remove the task:

<code>schtasks /delete /tn "Blink(1) CheerLights"</code>

