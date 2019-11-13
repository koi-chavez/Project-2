#!/bin/bash
chmod 755 project2.sh

if [ ! -d "/home/kdc0820/todo" ]; then
  mkdir todo
fi

if [ ! -d "/home/kdc0820/todocompleted" ]; then
  mkdir todocompleted
fi  

function add(){
if [ ! -d "/home/kdc0820/todo" ]; then
	cd todo
fi	

declare -i file=1
while [ -f "/home/kdc0820/todo/$file" ]
do
	file=$((file+1))
done
touch /home/kdc0820/todo/$file
chmod 755 /home/kdc0820/todo/$file
cat $1 > /home/kdc0820/todo/$file
}

function addcl(){
if [ ! -d "/home/kdc0820/todo" ]; then
	cd todo
fi	
declare -i file=1
while [ -f "/home/kdc0820/todo/$file" ]
do
	file=$((file+1))
done

touch /home/kdc0820/todo/$file
chmod 755 /home/kdc0820/todo/$file

if [ $2 = ""]; then
cat $2 > /home/kdc0820/todo/$file

else
	echo $2 | /home/kdc0820/todo/$file
fi
}

function help(){
echo 'The commands that can be used are: list, complete, seeCompleted, and add.'	
}

function list(){
if [ ! -d "/home/kdc0820/todo" ]; then
	cd todo
fi
declare -i file=1
while [ -f "/home/kdc0820/todo/$file" ]
do
	#read -r line < $file
	line=$(head -n 1 "/home/kdc0820/todo/$file")
	echo "$file) $line"
	file=$((file+1))	
done   
}

function complete(){
if [ ! -d "/home/kdc0820/todo" ]; then
	cd todo
fi

read -p "Which number would you like to mark as completed? " file
mv  /home/kdc0820/todo/$file todocompleted

file=$((file+1))

while [ -f "/home/kdc0820/todo/$file" ]
do
	mv /home/kdc0820/todo/$file /home/kdc0820/todo/$((file-1))
	file=$((file+1))
done
}
function listItem(){
	read -p "Which number item would you like to see more on? " file
	cat /home/kdc0820/todo/$file
        echo ""	
}
function seeCompleted(){
if [ ! -d "/home/kdc0820/todocompleted" ]; then
	cd todocompleted
fi
declare -i file=1
while [ -f "/home/kdc0820/todocompleted/$file" ]
do
	
	line=$(head -n 1 "/home/kdc0820/todocompleted/$file")
	echo "$file) $line"
	file=$((file+1))	
done  
}
#Command line use cases
#$#

while [ "$1" != '' ]; do
case $1 in
	add)
		addcl
		break;;
	help)
		help
		break;;
	list) 
		list
		break;;
	complete)
	       	complete
		break;;
	seeCompleted)
		seeCompleted
		break;;
	*) echo "Invalid argument. Please try again."
	   help 
	   break;;	
esac
done


while ["$1" = ''];
do
      clear 
      echo "Welcome to the to-do list manager! Here are your current items:"
      list
      echo""
      echo "What would you like to do?"
      echo ""
      echo "A) Mark an item as completed"
      echo "B) Add a new item"
      echo "C) See completed items"
      echo "D) See more information on a specific item"
      echo "Q) Quit"
      echo""
      echo "Enter choice:"
      read choice      
case $choice in
      A)
	    complete;;
      B)
	    echo "What would you like to add to your todo list?"  
  	    add ;;
      C)    seeCompleted
  	    ;;
      D)    listItem;;	    
      Q)    break;;
      *)
           echo "Invalid menu option entered, please try again.";;      
esac
      echo "Enter return to continue"
      read input
done

