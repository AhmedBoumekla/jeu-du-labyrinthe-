#!/bin/bash


#################################################################################################
#pour creer la matrice (n*m) de largeur LARG et de longueur LONG, puis on l'a initialise à 0 pour l'interieur et -1 pour l'exterieur 
function init_laby 
{
	
	for ((y=0; y<LONG; y++))
	do
		for ((x=1; x<$LARG; x++))
		do
			laby[$((y * LARG + x))]=0
		done
		laby[$((y * LARG + 0))]=-1
		laby[$((y * LARG + (LARG -1)))]=-1		
	done
	for ((x=0; x<LARG; x++))
	do
		laby[$x]=-2
		laby[$(((LONG - 1) * LARG + x))]=-2
	done
	laby[$(((LONG - 1) * LARG + x))]=-2
}
 ####################################################################################

function afficher_laby     #la fonction qui affiche le labyrinthe 
{
	clear
	for ((y=0; y<LONG; y++))
	do

		for ((x = 0; x < LARG; x++ ))
		do
			if [[ laby[$((y * LARG + x ))] -eq -2 ]]	#pour les bords haut et bas 
			then
				echo -e -n '\033[36m'    #pour changer la couleur 
				echo -n "--"
				echo -e -n '\033[01;32m'
			elif [[ laby[$((y * LARG + x ))] -eq -1 ]]	#pour les bords à gauche et à droite 
			then
				echo -e -n '\033[36m'
				echo -n "||"
				echo -e -n '\033[01;32m'
			elif [[ laby[$((y * LARG + x ))] -eq 0 ]]	#pour donner les murs on a choisis le caractère ██
			then
				echo -n "██"
			elif [[ laby[$((y * LARG + x ))] -eq 1 ]]	#pour le chemin on a choisi le caractère espace " " 
			then
				echo -n "  "
			elif [[ laby[$((y * LARG + x ))] -eq 2 ]]	#pour le thésée 
			then
				echo -e -n '\033[34m'
				echo -n "T "
				echo -e -n '\033[01;32m'
			elif [[ laby[$((y * LARG + x ))] -ge 30 && laby[$((y * LARG + x ))] -le 39  ]]	#pour les Minotaures
			then
				echo -e -n '\033[01;31m'
				echo -n "M "
				echo -e -n '\033[01;32m'
			fi
		done
	echo
	done

	sleep 0.25
}

#######################################################################################

# la fonction qui découpe le labyrinthe, elle commence par une position donnée puis découpe aléatoirement

function laby_aleatoire
{

	local direction=$RANDOM					#pour donner une direction aléatoire au debut
	local i=0						
	local coord=$1						#c'est l'emplacement du début du découpage, il est donné à l'appel de la fonction
	laby[$coord]=1						#pour creer la premiere case de labyrinthe
	while [ $i -le 4 ]					#c'est une boucle de taille 4 pour les 4 directions 
	do	
		local orientation=0					#la variable qui indique le sens 
		case $((direction % 4)) in
			0) orientation=1 ;;					#pour aller à droite
			1) orientation=-1 ;;					#pour aller à gauche 
			2) orientation=$LARG ;;				#pour descendre d'une case 
			3) orientation=$(( -$LARG )) ;;			#pour monter d'une case 
		esac
		local coord2=$((coord + orientation))			#coord2 qui est ls coordonée plus le pas qu'on va faire			
		if [[ laby[$coord2] -eq 0 ]]				#Si il y a un mur
		then
			local coord_nv=$((coord2 + orientation))		#coord_nv repesente la case après coord2
			if [[ laby[$coord_nv] -eq 0 ]]			#si coord_nv est un mur 
			then
				laby[$coord2]=1					
				laby_aleatoire $coord_nv			#Appel recursif en partant de la coord_nv
				i=0						
				direction=$RANDOM				#on initialise direction de nouveau aléatoirement 
				coord=$coord_nv				#coord recoit coord_v 
			fi
		fi
		((direction++))						#on incrémente la direction 
		((i++))							#on incrémente le i pour toutes les directions 
	done
}

#####################################################################
#c'est la fonction qui trouve des coordonnées aléatoirement pour placer les minotors et thésée 
function coord_random
{
	coord_y=$(( RANDOM % (LONG-2) + 1 ))
	coord_x=$(( RANDOM % (LARG-2) + 1 ))
	pos_dans_laby=$(( $coord_y * $LARG + $coord_x ))
	while [[ laby[$pos_dans_laby] -ne 1 ]]
	do
		coord_y=$(( RANDOM % (LONG-2) + 1 ))
		coord_x=$(( RANDOM % (LARG-2) + 1 ))
		pos_dans_laby=$(( $coord_y * $LARG + $coord_x ))
	done
}


###################################################################
#les fonctions qui placent les minotors de 0 jusqu'au 9 comme ça aprés on va les placer selon le nombre des minotors demandé par l'utiisateur et on a choisis que le nombre max des minotaures soit 10 

function placer_mino_0
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]  #si les coord aléatoire ne permet pas de placer un minotaur, on initialise d'autre coord aléatoirement 
	then
		coord_random
	else
		laby[$pos_dans_laby]=30      #pour le minotaurs on a choisi les valeur de 30 jusqu'à 39
	fi
}

function placer_mino_1                          #pour les autres fonction c'est le meme principe 
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=31
	fi
}

function placer_mino_2
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=32
	fi
}

function placer_mino_3
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=33
	fi
}

function placer_mino_4
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=34
	fi
}

function placer_mino_5
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=35
	fi
}

function placer_mino_6
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=36
	fi
}

function placer_mino_7
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=37
	fi
}

function placer_mino_8
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=38
	fi
}

function placer_mino_9
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]
	then
		coord_random
	else
		laby[$pos_dans_laby]=39
	fi
}


##############################################################
#c'est la fonction qui place thesee d'une maniere aléatoire 
function placer_thesee                        
{
	coord_random
	if [[ laby[$pos_dans_laby] -ne 1 ]]          #si les coord aléatoire ne sont pas valide, on donne d'autre coord 
	then
		coord_random
	else
		laby[$pos_dans_laby]=2               #sinon on affecte la valeur 2 au labyrinthe de coord choisi (pos_dans_laby)
	fi
}

###################################################################
#la fonction qui trouve thesee, elle va parcourir tout le labyrinthe et cherche les coord qui ont comme valuer 2 puis elle renvoie les coord 

function trouver_thesee
{
	for ((y=0; y<LONG; y++))
	do
		for ((x=1; x<$LARG; x++))
		do
			pos_dans_laby=$(( $y * $LARG + $x ))
			if [[ laby[$pos_dans_laby] -eq 2 ]]
			then
				coord_t=$pos_dans_laby	
			fi
		done
	done
}

###################################################################
#la fonction qui trouve les minotaures , elle va parcourir tout le labyrinthe et cherche les coord qui ont comme valeur de 30 jusqu'à 39 puis elle renvoie les coord


function trouver_mino
{
	for ((y=0; y<LONG; y++))
	do
		for ((x=1; x<$LARG; x++))
		do
			pos_dans_laby=$(( $y * $LARG + $x ))
			if [[ laby[$pos_dans_laby] -eq 3$(($1)) ]]
			then
				coord_m=$pos_dans_laby
				return
			fi
		done
	done
}


##################################################
#c'est la fonction qui permet de faire marcher thesee manuelement 

function dep_thesee_manu
{
	trouver_thesee
	mouvement=0	
	while test $mouvement -eq 0
	do
		read -n1 -s input	
		
		if [ "$input" == "d" ]  #si l'utilisateur tape "d" on va affecter la valeur 1 à pas, et comme ça il peut tourner à gauche 
		then
			pas=1
		elif [ "$input" == "q" ]   #pour tourner à gauche
		then
			pas=-1
		elif [ "$input" == "s" ]   #ppour avancer vers l'avant
		then	
			pas=$LARG
		elif [ "$input" == "z" ]   #pour que thesee descend 
		then
			pas=$(( -$LARG )) 
		elif [ "$input" == "k" ]   #pour quitter la partie 
		then
			echo "Fin de la partie"
			exit
		fi

		coord_t2=$(( coord_t+pas ))      #on affecte à la variable coord_t2 les coord de thesee plus le pas 
		
		if [[ laby[$coord_t2] -eq 1 ]]    #si les coord_t2 permetent de se deplacer  
		then
			laby[$coord_t]=1
			laby[$coord_t2]=2
			(( mouvement=1 ))
			afficher_laby
		elif [[ laby[$coord_t2] -eq -2 ]]    #si les coord_t2 correspondent à une sortie
		then
			laby[$coord_t]=1
			laby[$coord_t2]=2
			afficher_laby
			echo -e "\n Le jeu est fini, Thésée est sorti"
			(( mouvement=1 ))
			Th_s=1
		elif [[ laby[$coord_t2] -eq -1 ]]     ##si les coord_t2 correspondent à une sortie
		then
			laby[$coord_t]=1
			laby[$coord_t2]=2
			afficher_laby
			echo -e "\n Le jeu est fini, Thésée est sorti"
			(( mouvement=1 ))
			Th_s=1
		elif [[ laby[$coord_t2] -ge 30 && laby[$coord_t2] -le 39 ]]    #si les coord_t2 contiennent un minotaure
		then
			laby[$coord_t]=1
			afficher_laby
			echo -e "\n Le jeu est fini, Thésée est mort, il est tombé sur un Minotaure"
			(( mouvement=1 ))
			Th_m=1
		fi
	done
}

#####################################################################
#c'est la fonction qui permet de faire deplacer thesee d'une maniere automatique 

function dep_thesee_auto
{
	trouver_thesee                #pour trouver les coord de thesee 
	mouvement=0	
	direction=$RANDOM             #pour donner une direction aléatoire 
	while test $mouvement -eq 0
	do
		case $((direction % 4)) in
			0) pas=1 ;;	           #on fait le modulo de direction pour avoir une direction aléatoire
			1) pas=-1 ;;		
			2) pas=$LARG ;;			
			3) pas=$(( -$LARG )) ;;	
		esac

		coord_t2=$(( coord_t+pas ))      #et la on teste de la meme facon que avant si les coord finale permetent de se deplacer ou pas!
		
		if [[ laby[$coord_t2] -eq 1 ]]   #si le deplacement est valide 
		then
			laby[$coord_t]=1
			laby[$coord_t2]=2
			(( mouvement=1 ))
			afficher_laby
		elif [[ laby[$coord_t2] -eq -2 ]]       #si thesee est arrivé à la sortie
		then
			laby[$coord_t]=1
			laby[$coord_t2]=2
			afficher_laby
			echo -e "\n Le jeu est fini, Thésée est sorti"
			(( mouvement=1 ))
			Th_s=1
		elif [[ laby[$coord_t2] -eq -1 ]]
		then
			laby[$coord_t]=1
			laby[$coord_t2]=2
			afficher_laby
			echo -e "\n Le jeu est fini, Thésée est sorti"
			(( mouvement=1 ))
			Th_s=1
		elif [[ laby[$coord_t2] -ge 30 && laby[$coord_t2] -le 39 ]]     #si thesee est tombé sur un minotaure
		then
			laby[$coord_t]=1
			afficher_laby
			echo -e "\n Le jeu est fini, Thésée est mort, il est tombé sur un Minotaure"
			(( mouvement=1 ))
			Th_m=1
		else
			(( direction++ ))     
		fi
	done
}



#######################################################
#c'est la fonction qui permet de faire déplacer les minotaure d'une facon aléatoire 
function dep_mino_auto
{
	trouver_mino $(($1))   #on suit la meme methode que celle de thesee 
	mouvement=0
	direction=$RANDOM
	while test $mouvement -eq 0
	do
		case $((direction % 4)) in       #pour avoir une direction 
			0) pas=1 ;;	
			1) pas=-1 ;;		
			2) pas=$LARG ;;			
			3) pas=$(( -$LARG )) ;;	
		esac
		coord_m2=$(( coord_m+pas ))
		if [[ laby[$coord_m2] -eq 1 ]]   #si le deplacement est valide (ya pas d'obstacle)
		then
			laby[$coord_m]=1
			laby[$coord_m2]=3$(($1))
			(( mouvement=1 ))
			afficher_laby
		elif [[ laby[$coord_m2] -eq 2 ]]  #si on tombe sur thesee 
		then
			laby[$coord_m]=1
			laby[$coord_m2]=3$(($1))
			afficher_laby
			echo -e "\n Le jeu est fini, Thésée est mort!, un minotaure est tombé sur lui"
			(( mouvement=1 ))
			Th_m=1
		elif [[ laby[$coord_m2] -ge 30 && laby[$coord_m2] -le 30 ]]
		then
			(( mouvement=1 ))
		else
			(( direction++ ))
		fi
	done
}
	
####################################################
#là c'est la fonction principal qui va appeler les autres fonction, et qui fait démarrer la partie


# Taille du labyrinthe doit être impaire, sinon le labyrinthe n'a pas de mur sur 2 côtés
LARG=0		
LONG=0		
Th_m=0	 #la variable qui permet de savoir si thesee est mort  
Th_s=0	 #la variable qui permet de savoir si thesee est sorti

choix=0
while test $choix -ne 1 -a $choix -ne 2 -a $choix -ne 3
do
	clear
	echo -e -n '\033[01;31m'
	echo "****************************************************************************************"
	echo "*****                    BIENVENUE DANS LABYRINTHE V3.0                            *****"
	echo "*****                                                                              *****"
	echo "*****                                                Développé par:                *****"
	echo "*****                                                      -TOUALBI Ali            *****"
	echo "*****                                                      -BOUMEKLA Ahmed Amazigh *****"
	echo "*****                                                      -GROUPE:06              *****"
	echo "*****                                                                              *****"
	echo "*****                              ENJOY :)                                        *****"
	echo "****************************************************************************************"
	sleep 3
	clear
	echo -e -n '\033[01;31m'
	echo "****************************************************************************************"
	echo "*****                                  MENU                                        *****"
	echo "*****                                                                              *****"
	echo "*****      -POUR JOUER TAPEZ  : 1                                                  *****"
	echo "*****      -POUR LAISSER L'ORDINATEUR JOUER A VOTRE PLACE TAPEZ : 2                *****"
	echo "*****      -POUR QUITTER TAPEZ :    3                                              *****"
	echo "*****                                                                              *****"
	echo "*****                                                                              *****"
	echo "*****                                                                              *****"
	echo "****************************************************************************************"
	echo -e -n '\033[01;34m'
	read -p "votre choix : " choix
done 

if test $choix -eq 1             
then
	partie=0

	clear
	echo
	echo -e -n '\033[03;31m'

	echo "****************************************************************************************"
	echo "*****                                COMMENT JOUER                                 *****"
	echo "*****                                                                              *****"
	echo "*****      -TAPEZ Z POUR MONTER                                                    *****"
	echo "*****      -TAPEZ S POUR DESCENDRE                                                 *****"
	echo "*****      -TAPEZ D POUR ALLER À DROITE                                            *****"
	echo "*****      -TAPEZ Q POUR ALLER À GAUCHE                                            *****"
	echo "*****      -TAPEZ K POUR QUITTER                                                   *****"
	echo "*****                                                                              *****"
	echo "****************************************************************************************"


	nbr_mino=0
	while [[ $nbr_mino -le 0 || $nbr_mino -ge 11 ]]
	do
		echo -e "\n Combien de minotaures contiendera votre labyrinthe (entre 1 et 10)? "
		read nbr_mino
	done

	while test $LONG -le 10 -o $LONG -ge 44 -o  $(( LONG%2 )) -eq 0
	do
		read -p "Quelle est la longueur de votre labyrinthe  (un nombre impaire entre 11 et 43) :   " LONG
		echo
	done

	while test $LARG -le 10 -o  $LARG -ge 44  -o $(( LARG%2 )) -eq 0
	do
		read -p "Quelle est la largeur de votre labyrinthe  (un nombre impaire entre 11 et 43) :   " LARG
		echo
	done
	 
	while test $partie -eq 0
	do
		clear
		init_laby
		laby[$((LARG + 2))]=1
		laby_aleatoire $((2 * LARG+ 2 ))

		laby[$(((LONG - 2) * LARG + LARG - 3))]=1

		for ((i=0;i<nbr_mino;i++))
		do
			placer_mino_$i
		done

		placer_thesee

		afficher_laby
		read  -p "si vous voulez changer de labyrinthe tapez 0 sinon tapez 1: " partie 
	done
	echo "*************************************"
	echo "*** la partie a commencé, jouez ! ***"
	echo "*************************************"
	while test $Th_m -ne 1 -a $Th_s -ne 1
	do
		dep_thesee_manu
		if test $Th_m -eq 0 -a $Th_s -eq 0
		then
			for ((i=0;i<nbr_mino;i++))
			do
				dep_mino_auto $(($i))
			done
		fi
	done
	echo


elif test $choix -eq 2
then

	partie=0
	clear
	echo -e -n '\033[01;31m'

	echo "****************************************************************************************"
	echo "*****                                COMMENT JOUER                                 *****"
	echo "*****                                                                              *****"
	echo "*****      VOUS DEVEZ JUSTE ENTRER LES OPTIONS ET RAGARDER LA PARIE SE DEROULER    *****"
	echo "*****                                                                              *****"
	echo "*****                                                                              *****"
	echo "*****                                                                              *****"
	echo "*****                                                                              *****"
	echo "*****                                                                              *****"
	echo "****************************************************************************************"
	

	nbr_mino=0
	while [[ $nbr_mino -le 0 || $nbr_mino -ge 11 ]]
	do
		echo -e "\n Combien de minotaures contiendera votre labyrinthe (entre 1 et 10)? "
		read nbr_mino
	done



	while test $LONG -le 10 -o $LONG -ge 44 -o  $(( LONG%2 )) -eq 0
	do
		read -p "Quelle est la longueur de votre labyrinthe  (un nombre impaire entre 11 et 43) :   " LONG
		echo
	done

	while test $LARG -le 10 -o  $LARG -ge 44  -o $(( LARG%2 )) -eq 0
	do
		read -p "Quelle est la largeur de votre labyrinthe  (un nombre impaire entre 11 et 43) :   " LARG
		echo
	done
	while test $partie -eq 0
	do
		clear
		init_laby
		laby[$((LARG + 2))]=1
		laby_aleatoire $((2 * LARG+ 2 ))

		laby[$(((LONG - 2) * LARG + LARG - 3))]=1

		for ((i=0;i<nbr_mino;i++))
		do
			placer_mino_$i
		done

		placer_thesee

		afficher_laby
		read  -p "si vous voulez changer de labyrinthe tapez 0 sinon tapez 1: " partie 
	done
	echo "*************************************"
	echo "*** la partie a commencé, jouez ! ***"
	echo "*************************************"

	while test $Th_m -ne 1 -a $Th_s -ne 1
	do
		dep_thesee_auto
		if test $Th_m -eq 0 -a $Th_s -eq 0
		then
			for ((i=0;i<nbr_mino;i++))
			do
				dep_mino_auto $(($i))
			done
		fi
	done
	echo

elif test $choix -eq 3
then
	echo "*************************************************************"
	echo "**********       AU REVOIR ! À BIENTOT!!        *************"
	echo "**********                                      *************"
	echo "**********               ^ ^                    *************"
	echo "**********               O O                    *************"
	echo "**********                *                     *************"
	echo "**********                V                     *************"
	echo "**********                                      *************"
	echo "*************************************************************" 
	sleep 2
	clear
fi

#_____________________________________________________________________________________________________________
