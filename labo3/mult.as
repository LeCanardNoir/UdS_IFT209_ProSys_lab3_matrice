.include "/root/SOURCES/ift209/tools/ift209.as"
.global MultMatVec


.section ".text"


/***********************************************************************

	MultMatVec

	Effectue la multiplication d'une matrice par un vecteur.



	Entrées:
		(paramètre) x0: adresse de la matrice
		(paramètre) x1: adresse du vecteur
		(paramètre) x2: adresse du vecteur de résultats
		(paramètre) x3: nombre de lignes (ou hauteur)
		(paramètre) x4: nombre de colonnes (ou largeur)



	Sorties:
		(écran)	Affichage de l'opération
		(écran) vecteur résultant (suite d'entiers)



	Auteur: Gabriel Dumont-Hétu et Bruno Pouliot
***********************************************************************/
MultMatVec:
		SAVE
		mov		x20, x0				//Matrice
		mov		x21, x1				//Vecteur
		mov		x22, x2				//Vecteur Résultat
		mov		x23, x3				//nbRangées
		mov		x24, x4				//nbColonnes

		mov		x19, #0				//Index de la matrice
		mov		x26, #0				//Index du vecteur résultat
		mov		x27, #0				//Index du vecteur



MultMatVec_0100:
		mov		x28, #0				// resulat de la cellule courante
		cmp		x26, x23, lsl #2	//Si x26 == 4*nbRangées
		b.eq	MultMatVec_0400		//Alors, le calcul est fini
MultMatVec_0200:
		ldrsw	x9, [x21, x27]		//Élément du vecteur
		add 	x27, x27, #4
		ldrsw	x10, [x20, x19]		//Élément de la matrice
		add		x19, x19, #4
		madd	x28, x9, x10, x28	//x28 += élément du vecteur*élément de la matrice
		cmp		x27, x24, lsl #2	//Tant que l'index du vecteur est plus petit que le nombre d'éléments du vecteur
		b.ne	MultMatVec_0200		//On continue
MultMatVec_0300:
		str		w28, [x22, x26]		//Sinon, on le range dans le vecteur résultat
		add		x26, x26, #4
		mov		x27, #0				//On met l'index du vecteur à 0
		b		MultMatVec_0100		//Et on passe au prochain
MultMatVec_0400:
		//TODO Afficher le vecteur résultat qui est dans x22
		



		RESTORE
		ret
