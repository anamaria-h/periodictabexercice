#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
	echo "Please provide an element as an argument."
else
	INPUT_ELEMENT="$1"

  if [[ ! $INPUT_ELEMENT =~ ^[0-9]+$ ]]
  then
    IS_SYMBOL=$($PSQL "select exists(select 1 from elements where symbol='$INPUT_ELEMENT')")
		if [[ $IS_SYMBOL =~ t ]]
		then
      ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$INPUT_ELEMENT'")
			ATOMIC_NUMBER_FORMATTED=$(echo $ATOMIC_NUMBER | sed 's/ |/"/')
      ELEMENT_NAME=$($PSQL "select name from elements where symbol='$INPUT_ELEMENT'")
			ELEMENT_NAME_FORMATTED=$(echo $ELEMENT_NAME | sed 's/ |/"/')
      TYPE_ID=$($PSQL "select type_id from properties where atomic_number=$ATOMIC_NUMBER")
      TYPE=$($PSQL "select type from types where type_id=$TYPE_ID")
			TYPE_FORMATTED=$(echo $TYPE | sed 's/ |/"/')
      ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ATOMIC_NUMBER")
			ATOMIC_MASS_FORMATTED=$(echo $ATOMIC_MASS | sed 's/ |/"/')
      MELT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")     
			MELT_FORMATTED=$(echo $MELT | sed 's/ |/"/')
      BOIL=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")
			BOIL_FORMATTED=$(echo $BOIL | sed 's/ |/"/')
      echo "The element with atomic number $ATOMIC_NUMBER_FORMATTED is $ELEMENT_NAME_FORMATTED ($INPUT_ELEMENT). It's a $TYPE_FORMATTED, with a mass of $ATOMIC_MASS_FORMATTED amu. $ELEMENT_NAME_FORMATTED has a melting point of $MELT_FORMATTED celsius and a boiling point of $BOIL_FORMATTED celsius." 
		else
		  IS_NAME=$($PSQL "select exists(select 1 from elements where name='$INPUT_ELEMENT')")
      if [[ $IS_NAME =~ t ]]
      then
        	ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where name='$INPUT_ELEMENT'")
					ATOMIC_NUMBER_FORMATTED=$(echo $ATOMIC_NUMBER | sed 's/ |/"/')
	        SYMBOL=$($PSQL "select symbol from elements where name='$INPUT_ELEMENT'")
					SYMBOL_FORMATTED=$(echo $SYMBOL | sed 's/ |/"/')
	        TYPE_ID=$($PSQL "select type_id from properties where atomic_number=$ATOMIC_NUMBER")
	        TYPE=$($PSQL "select type from types where type_id=$TYPE_ID")
					TYPE_FORMATTED=$(echo $TYPE | sed 's/ |/"/')
	        ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ATOMIC_NUMBER")
					ATOMIC_MASS_FORMATTED=$(echo $ATOMIC_MASS | sed 's/ |/"/')
	        MELT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")
					MELT_FORMATTED=$(echo $MELT | sed 's/ |/"/')
	        BOIL=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")
					BOIL_FORMATTED=$(echo $BOIL | sed 's/ |/"/')
	        echo "The element with atomic number $ATOMIC_NUMBER_FORMATTED is $INPUT_ELEMENT ($SYMBOL_FORMATTED). It's a $TYPE_FORMATTED, with a mass of $ATOMIC_MASS_FORMATTED amu. $INPUT_ELEMENT has a melting point of $MELT_FORMATTED celsius and a boiling point of $BOIL_FORMATTED celsius."
      else
        echo "I could not find that element in the database."
      fi
		fi
  else
    IS_ATOMIC_NUMBER=$($PSQL "select exists(select 1 from elements where atomic_number='$INPUT_ELEMENT')")
    if [[ $IS_ATOMIC_NUMBER =~ t ]]
    then
	    ELEMENT_NAME=$($PSQL "select name from elements where atomic_number='$INPUT_ELEMENT'")
			ELEMENT_NAME_FORMATTED=$(echo $ELEMENT_NAME | sed 's/ |/"/')
	    SYMBOL=$($PSQL "select symbol from elements where atomic_number='$INPUT_ELEMENT'")
			SYMBOL_FORMATTED=$(echo $SYMBOL | sed 's/ |/"/')
	    TYPE_ID=$($PSQL "select type_id from properties where atomic_number=$INPUT_ELEMENT")
	    TYPE=$($PSQL "select type from types where type_id=$TYPE_ID")
			TYPE_FORMATTED=$(echo $TYPE | sed 's/ |/"/')
	    ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$INPUT_ELEMENT")
			ATOMIC_MASS_FORMATTED=$(echo $ATOMIC_MASS | sed 's/ |/"/')
	    MELT=$($PSQL "select melting_point_celsius from properties where atomic_number=$INPUT_ELEMENT")
			MELT_FORMATTED=$(echo $MELT | sed 's/ |/"/')
	    BOIL=$($PSQL "select boiling_point_celsius from properties where atomic_number=$INPUT_ELEMENT")
			BOIL_FORMATTED=$(echo $BOIL | sed 's/ |/"/')
	    echo "The element with atomic number $INPUT_ELEMENT is $ELEMENT_NAME_FORMATTED ($SYMBOL_FORMATTED). It's a $TYPE_FORMATTED, with a mass of $ATOMIC_MASS_FORMATTED amu. $ELEMENT_NAME_FORMATTED has a melting point of $MELT_FORMATTED celsius and a boiling point of $BOIL_FORMATTED celsius."
    else
      echo "I could not find that element in the database."
    fi 
  fi
fi