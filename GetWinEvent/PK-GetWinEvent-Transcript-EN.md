1
Hello, my name is Thorsten Butz and my topic today is the Windows Event Viewer
and the Get-WinEvent cmdlet, which is very interesting at second glance.
If you take a look at the Event Viewer, you quickly realize that the problem
is certainly not that you find too little information there.

2
On the contrary, it is the search for a needle in a haystack.
What you really need are powerful tools to filter the information.
We already had command line tools for automation in the past:
WMIC (WMI access), wevtutil (since Windows Vista) should be mentioned here as examples.

3
If you look at these commands, you will realize that you have quite powerful
filtering options to access the XML data behind them.
But of course you don't want to have to deal with a very complex syntax.
syntax.

4 
You can use the graphical user interface. There too, in addition to
general overviews and access to this XML data structure.
But if you are working with scripting languages, you would actually like to have
a command line tool that is just as easy to use as the graphical user interface.

5 
At first glance, Get-EventLog is the perfect candidate.
Introduced with the PowerShell in version 1, the command syntax is very
catchy, very simple.
You can also show colleagues who are perhaps not so deeply involved in automation,
immediately show them code that is understandable. 

6
And with techniques such as splatting, you can simplify the whole thing a little more.
And since you are now working with PowerShell, you can go back 
very simple way to jump back 24 hours,
which is what I have done in this example.
This is a quick way to make friends with Get-EventLog.

7 
But then you discover that Get-EventLog has a number of disadvantages.
And the first and most obvious disadvantage is that Get-EventLog does not display
shows all events that are scattered in any logs.

8
The overview may include the important logs, but by no means all of them.
If you look at the graphical user interface or use Get-WinEvent,
you realize that there are hundreds of logs and only a few of them are displayed by
Get-EventLog, but Get-WinEvent does.
Why is that?


9
This is essentially due to an innovation in Windows Vista.
At that time, the Windows Event Log Engine was completely overhauled.
And if you simplify it a little, you can say that Get-EventLog is still a tool for the old world.
still a tool for the old world.
Get-WinEvent is the tool for the new world, with which you can access the new
formats and gain full access to them.

10
However, this is only one disadvantage of Get-EventLog. Get-EventLog is not PowerShell 7 compatible.
If you call Get-EventLog in PowerShell 7
you use a technique called Implicit Remoting.

11
This can be switched off. 
Now you try to solve the same task with Get-WinEvent,
that was just so easy with Get-EventLog.
And then you realize that it works, but it seems strange,
that I need a Where-Object for this.

12
Because Get-WinEvent does not know the specific parameters that I would like to have for this.
If you search a bit and read the documentation, you find out 
that you can use the "FilterHashtable" parameter.

13
The problem here again is that you have to work out this syntax.
Very strange. There is a better way.
And, interestingly, this is via the graphical user interface.
I am back in the Event Viewer and there you can
under the customized views

14
build your own filter rules.
This is then super, super simple and you could now safely leave it on a single
computer with the graphical interface.
But the really interesting thing is, you can see it at the top right
by the yellow arrow that you then also have the option,

15
to take a closer look at the details of the underlying filters.
And here we are back in the context of XML.
It's not easy to understand, especially if you have to write it down yourself, but well
but well, I can copy the text with CTRL-C (Control-C).


16
This in turn makes it very simple.
With Get-WinEvent there is a second
parameter called FilterXML and it accepts exactly that.
As XML is always a bit sensitive,
you should be careful when changing this text,

17 
so that it is best to enclose it in a HereString.
And on this slide you can see this here again compared to the
FilterHashtable that we just had and below the FilterXPath parameter,
which you can use as an alternative. Be careful with the operators!

18
Let's move on to a demo of the other advantages of Get-WinEvent.
So far we have only seen that Get-WinEvent is more powerful,
but also seems to be a little more complicated to use.
We can see that here in comparison. I have packed the various examples
into a demo file. I'll call it up now.

19 
Let's see what happens when we simply measure
how long the runtimes are.
And then you realize very quickly that there are big differences.
And since a test is not a test, I'll repeat this directly.
There are big differences with Get-EventLog, which is due to this
implicit remoting. 

20
The session is already active on the second call, so it is faster.
The really important information, however, is what we have just seen,
that the XML expression that I can copy out of the event viewer
is not only convenient, but also the fastest option of all.
