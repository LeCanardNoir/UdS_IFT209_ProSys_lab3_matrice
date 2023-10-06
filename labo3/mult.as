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



	Auteur:
***********************************************************************/
MultMatVec:
		SAVE





		RESTORE
		ret
