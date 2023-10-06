/***********************************************************************
	Laboratoire 4
	Ce programme lit une matrice et un vecteur, affiche l'opération de
	multiplication à faire, réalise la multiplication et finalement,
	affiche le résultat.

	Le programme principal appelle plusieurs sous-programmes:
	-LireMatrice pour lire la matrice;
	-LireVecteur pour lire le vecteur;
	-AfficherMultiplication pour afficher l'opération à faire;
	-MultMatVec pour faire la multiplication;
	-AfficherVecteur pour afficher le résultat.

	À compléter:
	-MultMatVec

	Entrées:
		(clavier) Suite d'éléments de la matrice (entiers)


	Sorties:
		(écran)	Affichage de l'opération
		(écran) vecteur résultant (suite d'entiers)



	Auteur: Mikaël Fortin
***********************************************************************/


.include "/root/SOURCES/ift209/tools/ift209.as"
.global Main


.section ".text"

MAXLIGNES=100
MAXCOLONNES=100


Main:
		SAVE					//Sauvegarde l'environnement de l'appelant

		/*
			Préparation: obtention des dimensions et vérifications
		*/
		adr		x0,ptfmt1		//Param1: adresse du message à imprimer
		bl		printf			//Demande les dimensions

		adr		x0,scfmt1		//Param1: adresse du format de lecture
		adr		x19,dimensions	//Garde l'adresse des dimensions
		mov		x1,x19			//Param2: adresse du nombre de lignes
		add		x2,x19,4		//Param3: adresse du nombre de colonnes
		bl		scanf			//Lecture des nombres de lignes et colonnes

		ldr		w27,[x19]		//Obtention du nombre de lignes
		ldr		w28,[x19,4]		//Obtention du nombre de colonnes

		cmp		x27,0			//lignes < 0?
		b.le	matriceErreur	//Si oui, message d'erreur et fin

		cmp		x27,MAXLIGNES	//lignes > MAXLIGNES?
	   	b.gt	matriceErreur	//Si oui, message d'erreur et fin

		cmp		x28,0			//colonnes < 0?
		b.le	matriceErreur	//Si oui, message d'erreur et fin

		cmp		x28,MAXCOLONNES	//colonnes > MAXCOLONNES?
	   	b.gt	matriceErreur	//Si oui, message d'erreur et fin




		adr		x0,ptfmt2		//Param1: adresse du message
		bl		printf			//Demande l'entrée des éléments de la matrice

		adr		x0,dataMatrice
		mov		x1,x27
		mov		x2,x28
		bl		LireMatrice


		adr		x0,dataVecteur
		mov		x1,x28
		bl		LireVecteur


		adr		x0,dataMatrice
		adr		x1,dataVecteur
		mov		x2,x27
		mov		x3,x28

		bl		AfficherMultiplication

		adr		x0,dataMatrice
		adr		x1,dataVecteur
		adr		x2,dataResultat
		mov		x3,x27
		mov		x4,x28
		bl		MultMatVec

		adr		x0,dataResultat
		mov		x1,x27
		bl		AfficherVecteur
		adr		x0,ptfmt5
		bl		printf


matriceFin:

		mov		x0,1			//Code d'erreur 0 : fin normale
		bl		exit			//Fin du programme

matriceErreur:

		adr		x0,ptfmt6		//Param1: adresse du message
		bl		printf			//Affiche le message d'erreur

        mov		x0,1			//Code d'erreur 1 : erreur
		bl		exit			//Fin du programme



		/*
			Boucle de lecture
		*/
LireMatrice:
		SAVE
		mul		x1,x1,x2		//Calcule le nombre d'éléments à lire

		bl		LireVecteur

		RESTORE
		ret


LireVecteur:
		SAVE

		mov		x20,x0
		mov		x21,x1
		mov		x22,0

lireVec10:
		adr		x0,scfmt2
		add		x1,x20,x22
		bl		scanf

		add		x22,x22,4
		subs	x21,x21,1
		b.gt	lireVec10
		RESTORE
		ret


		RESTORE
		ret


AfficherMultiplication:

		SAVE

		mov		x19,x0
		mov		x20,x1
		mov		x21,x2
		mov		x22,x3

		mul		x23,x22,x21
		mov		x24,0

affMul10:
		cmp		x23,0
		b.le	affMulFin

		adr		x0,ptfmt4
		ldr		w1,[x19],4
		bl		printf
		sub		x23,x23,1

		add		x24,x24,1
		cmp		x24,x22
		b.ne	affMul10

		mov		x24,0
		adr		x0,ptfmt5
		bl		printf
		b		affMul10

affMulFin:
		adr		x0,ptfmt9
		bl		printf
		mov		x0,x20
		mov		x1,x22
		bl		AfficherVecteur

		adr		x0,ptfmt10
		bl		printf
		RESTORE
		ret



AfficherVecteur:
		SAVE
		mov		x19,x0
		mov		x28,x1

affVec10:
		ldr		w20,[x19],4
		adr		x0,ptfmt4
		mov		x1,x20
		bl		printf

		subs	x28,x28,1
		b.gt	affVec10


affVecFin:

		RESTORE
		ret



/* Espace réservé pour recevoir le résultat de scanf. */

.section ".bss"

			.align 	4
dimensions:	.skip 	8

dataMatrice:
			.skip	MAXLIGNES*MAXCOLONNES*4

dataVecteur:
			.skip	MAXCOLONNES*4

dataResultat:
			.skip	MAXCOLONNES*4

/* Formats de lecture et d'écriture pour printf et scanf */
.section ".rodata"

scfmt1:		.asciz 	"%d%d"
scfmt2:		.asciz 	"%d"
ptfmt1:		.asciz 	"Entrez le nombre de lignes et de colonnes de la matrice:\n"
ptfmt2:		.asciz 	"Entrez les éléments de la matrice:\n\n"
ptfmt4:		.asciz 	"%d "
ptfmt5:		.asciz	"\n"
ptfmt6:		.asciz	"Erreur: dimensions invalides (1 à 100 lignes et colonnes)\n"
ptfmt7:		.asciz	"%d\n"

ptfmt9:		.asciz	"\n  X\n\n"
ptfmt10:	.asciz	"\n  =\n\n"
