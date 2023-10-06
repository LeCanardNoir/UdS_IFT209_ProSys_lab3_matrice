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
		section ".text"
				INDEX_STEP=#4

MultMatVec_init:
		mov		x19, x0						// x19 <= Matrice address
		mov		x20, x1						// x20 <= Vector address
		mov		x21, x2						// x21 <= vResult address
		mov		x22, x3						// x22 <= NbrLines
		mov		x23, x4						// x23 <= NbrColumn

		mov		x24, #0						// x24 <= MatriceCurrentIndex
		mov		x25, #0						// x25 <= VectorCurrentIndex
		mov		x26, #0						// x26 <= Result index

MultMatVec_LOOP_START:

		mov		x7, #1						// x7 <= init
		add		x7, x7, x24					// x7 <= x7 + MatriceCurrentIndex
		mul		x7, x7, INDEX_STEP			// Matrice NEXT index
		ldrsw	w26, [x19], x7				// w26 <= LOAD Matrice value 	| Matrice_address ++

		mov		x6, #1						// x6 <= init
		add		x6, x6, x25					// x6 <= x6 + VectorCurrentIndex
		mul		x6, x6, INDEX_STEP			// Matrice NEXT index
		ldrsw	w27, [x20], x25				// w26 <= LOAD Vector value		| Vector_address++

		add		x24, #1
		add		x25, #1						
		
		cpm		x25, x22					// VectorCurrentIndex - NbrLines
		b.ge	MultMatVec_switchCol		// if( VectorCurrentIndex >= NbrLines ) GOTO MultMatVec_switchCol

MultMatVec_switchCol:
		mul		x7, x22, x23				// x7 <= NbrLines X NbrColumn
		mov		x25, #0						// VectorCurrentIndex = 0
		add		x24, x24, #1				// x24 <= MatriceCurrentIndex
		cpm		x24, x7
		b.ge	MultMatVec_LOOP_END			// END LOOP


MultMatVec_LOOP_END:

		RESTORE
		ret
