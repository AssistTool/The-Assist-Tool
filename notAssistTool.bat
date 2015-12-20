@echo off
color f
title Assist Tool
	SET /p user= "Please enter your user name. "
		IF not exist "C:\Users\%user%\Desktop\AssistTool\" GOTO :tool
		IF exist "C:\Users\%user%\Desktop\AssistTool\"  GOTO :Assist
	:tool
		md C:\Users\%user%\Desktop\AssistTool\
			Echo Created Succesfully
				Call :copier
	:copier 
		xcopy C:\Users\%user%\Downloads\The-Assist-Tool-master\The-Assist-Tool-master C:\Users\%user%\Desktop\AssistTool
		Call :Assist
:Assist
	SET /p task= "Please enter a command... (For Help type HELP) "
		IF "%task%"== "HELP" Call :CMDS
		IF "%task%"== "ping" Call :Ping
		IF "%task%"== "+ user" Call :AddUser
		IF "%task%"== "- user" Call :DeleteUser
		IF "%task%"== "users" Call :NetUser
		IF "%task%"== "password change" Call :password
		IF "%task%"== "user active" Call :UserActive
		IF "%task%"== "user info" Call :userInfo
		IF "%task%"== "localgroups" Call :SetLocalGroup
		IF "%task%"== "localgroup info" Call :localgroupInfo
		IF "%task%"== "launch program" Call :LaunchProgram
		IF "%task%"== "remote" Call :Remote
		IF "%task%"== "Directory" Call :Direct
		IF "%task%"== "external command" Call :external
		IF "%task%"== "End" Call :End
			:external
				SET /p ext= "Please enter terminal command... "
					echo %ext%
					echo Continue?
					pause
						%ext%
						Call :Assist
			:Direct 
				SET /p direct= "Copy and paste file path here. "
					cd "%direct%"
					Call :Assist
			:Remote
				shutdown /i 
					GOTO :Assist
			:AddUser
				SET /p userName= "What do you want the user name to be? "
					IF "%userName%"== "quit" GOTO :End
					net user %userName% /add 
						GOTO :SetLocalGroup 
			:password
				SET /p Yass= "What user would you like to change the password of? "
				SET /p password= "Are you sure that you would like to change this password? (yes or no) "
					IF "%password%"== "yes" GOTO :change
					IF "%password%"==  "no" GOTO :DoNot
						:change 
							net user %Yass% 
								Call :Assist1
						:DoNot
							Call :Assist
			:UserActive
				Set /p userName= "Which user? "
				Set /p active= "Active (yes or no)? "
					IF "%active%"== "yes" GOTO :UserYesActive
					IF "%active%"== "no" GOTO :UserInactive
						:UserYesActive
							net user %userName% /active:yes
								Call :Assist
						:UserInactive
							net user %userName% /active:no
								Call :Assist
			:SetLocalGroup
				SET /p localGroup= "Would you like to add/remove to/from a localgroup? "
					IF "%localGroup%"== "yes" GOTO :YES 
					IF "%localGroup%"== "no" Call :Assist
						:YES
							SET /p which="Add or remove? "
								IF "%which%"== "add" GOTO :YesYes
								IF "%which%"== "remove" GOTO :NoNo
									:YesYes
										SET /p userYes= "Name the user please " 
										SET /p yes= "Which localgroup do you want it in? " 
											net localgroup %yes% %userYes% /add 
												Call :Assist
									:NoNo
										SET /p userNo= "Name the user please "
										SET /p no= "Which localgroup do you want it removed from? "
											net localgroup %no% %userNo% /del
											Call :Assist
					IF "%localGroup%"== "no" Call :Assist 
			:LaunchProgram
				set /p userFileName= "Enter File Name "
				set /p userSure= "Are You Sure? (yes or no) "
					IF "%userSure%"=="yes" GOTO :yes
					IF "%userSure%"=="no" GOTO :no
						:yes
						start %userFileName%
						Call :Assist
						:no
						Call :Assist 
			:DeleteUser
				Set /p whichOne= "Which user? "
					net user %whichOne% /del 
						Call :Assist
			:localgroupInfo
				SET /p Localgroup= "Which localgroup do you need information from? "
					net localgroup %Localgroup%
						Call :Assist
			:userInfo
				SET /p userInfo= "What user do you want info on? "
					net user %userInfo%
						Call :Assist
			:Ping
				SET /p ping= "What is the URL of the site you would like to ping?(I need the full url) "
					ping %ping%
						Call :Assist
			:CMDS
			    cd C:\Users\%user%\Desktop\AssistTool\
				start README!.txt
				Call :Assist
			:NetUser
				net users 
				SET /p isThat= "Is that all? (yes or no) "
					IF "%isThat%"== "yes" GOTO :End
					IF "%isThat%"== "no" Call :Assist
			:End
				SET /p quitYes= "Are you sure you want to quit? (yes or no) "
					IF "%quitYes%"== "yes" EXIT
					IF "%quitYes%"== "no" Call :Assist
