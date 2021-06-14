	.global ordenar
ordenar:
	PUSH	{R5,R6,R7}
	SUB  	R2, R1, #1     //R1 es la cantidad de numeros ingresados por teclado R2=R1-1
						//R0 Tiene la base del arreglo
	_for1:
		MOV  	R3, R0   //R3=[R0] Ahora R3 tiene el valor del arreglo que se recorre 
		MOV  	R5, #0   //contador R5=0

		_for2:
			LDR  	R6, [R3]      //R6 Tiene el valor del elemento del vector v[i] y cada vez que se menciona se actualiza por ejemplo v[1]
			LDR 	R7, [R3, #+4]! //R7 tiene el valor del siguiente elemento v[i+1] por ejemplo v[2]
			CMP  	R6, R7         //comparamos los dos elementos por ejemplo v[1] > v[2]
			STRGT  	R7, [R3, #-4]  // si R6>R7  copiamos el valor de R7 en la posicion de R6
			STRGT  	R6, [R3]	  // si R6>R7  copiamos el valor de R6 en la posicion que estaba R7 anteriormente	
			ADD  	R5, R5, #1		//aumentamos el contador en 1 R5=+1
			CMP  	R5, R2
		BLT _for2
		SUBS  	R2, R2, #1
	BNE _for1

	POP {R5,R6,R7}
	BX LR