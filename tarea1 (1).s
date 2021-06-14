/*Este programa muestra un menu con las siguintes opciones.
1. Ingresar datos
2. Minimo
3. Maximo
4. Media Aritmetica.
5. Ordenar
6. Salir

si escoges la opcion 1 ingresar datos, se debera pedir al usuario que diga
cuantos numeros ingresara del 1 al 20.
si se escoge la opcion 5 Ordenar se deberia pedir al usuario decir si sera desendente o ascendente.
*/
		.include "ordenar.s"
		.data
msj1:		.asciz	"\nEscoge una de las siguientes opciones.\n1. Ingresar datos\n2. Minimo\n3. Maximo\n4. Media Aritmetica\n5. Ordenar.\n6. Salir.\n\nIngresar Opcion: "
msj2:		.asciz	"\nOpcion Ingresar datos.\nNumero de Datos a Ingresar: "
msj3:		.asciz	"Ingresar numero %d: "
msj4:		.asciz	"\nDebe escoger una opcion del 1 al 5\n\n"
msj5:       .asciz  "el numero menor es: %d\n"
msj6:       .asciz  "el numero mayor es: %d\n"
msj7:		.asciz	"La media Aritmetica es: %d.%d%d\n"
msj8:		.asciz	"Ordenar: \n1. ASCENDENTE\n2. DESCENDENTE\n   "
msj9: 		.asciz  "Debe escoger ingresar numero del 1 al 20.\n\n"
a:			.skip 80	//reservamos 80 bytes que es la memoria para 20 numeros de 4 bytes cada uno
opcion:		.word 0		//variable que guarda la opcion escogida.
numero: 	.word 0		//variable que guarda el numero introducido de 4 bytes por el usuario.
cantidad:	.word 0 	//variable que guardadra la cantidad de numero a ingresar que sera el tamaño de nuestro arreglo
media:		.word 0 	//variable que almacena la sumatoria de los numeros del arreglo
decimal1:	.word 0 	//almacena el primer decimal de nuestra media aritmetica x.x
entero:		.word 0 	//almacena el entero de nuestra media aritmetica x
decimal2:	.word 0 	//almacena el segundo decimal de nuestra media aritmetica x.xx
residuo:	.word 0 	//almacena el residuo en la division sumatoria/tamaño del arreglo
            .equ  minimo, 1000
            .equ  mayor, 1
fmt:	.asciz "%d\n"	//formato para impresion de numeros
fmt1:	.asciz "%d"		//formato para leer numeros
		.text
		.global main
	main:
		PUSH	{R4,R5,R6,LR}	//le metemos R4 R5 R6 LR a la pila
    
    //aqui mostraremos el menu de nuestra aplicacion
	mostrarMenu:
		LDR		R0, =msj1		//cargamos la direccion de memoria del mensaje 1
		BL 		printf			//llamamos a la funcion imprimir para mostrar el mensaje 1

		LDR		R0, =fmt1		//cargamos la direccion de memoria del formato que tendra la opcion a introducir
		LDR		R1, =opcion 	//cargamos la direccion de memoria de la variable opcion
		BL 		scanf			//llamamos a la funcion leer para leer la opcion
		
		LDR		R4, =a 			//cargamos la direccion de memoria inicial
		LDR		R2, =opcion 	//cargamos la direccion de memoria que almacena nuestra opcion seleccionada
		LDR		R2, [R2]		//cargamos el valor de la opcion seleccionada
		MOV		R5, #0			//inicializamos nuestro contador a cero

		CMP 	R2, #6			//validacion para que se ingrese un numero que este dentro de las opciones
		BGT		leerOpcion		//se manda para la etiqueta leerOpcion que muestra mensaje indicando lo que debe ingresar el usuario

		//Se compara la opcion introducida y si es 1 se ingresara la cantidad de numero a leer
		CMP 	R2, #1				//compara la opcion leida con el numero 1
		BEQ		cantidadNumeros		//sin son iguales salta a la etiqueta cantidadNumeros
		
		//Se compara la opcion introducida y si es 2 se imprimira el numero menor
		MOV     R3, #minimo
		MOV		R5,#0
		CMP 	R2, #2				//compara la opcion leida con el numero 2
		BEQ		calculominimo		//sin son iguales salta a la etiqueta calculominimo

		//Se compara la opcion introducida y si es 3 se imprimira el numero maximo
		MOV     R3, #mayor
		CMP 	R2, #3				//compara la opcion leida con el numero 3
		BEQ		calculomaximo		//sin son iguales salta a la etiqueta calculomaximo

		//Se compara la opcion introducida y si es 4 se imprimira la media Aritmetica
		CMP 	R2, #4				//compara la opcion leida con el numero 4
		BEQ		calculomedia		//sin son iguales salta a la etiqueta calculoMediaAritmetica

		//se compara la opcion introducida y si es 6 saldra.
		CMP 	R2, #6
		BEQ		exit

		//aqui comparamos si opcion=5 mandamos a llamar la funcion ordenar y pedimos si desea imprimir ascendente o descendente
		opcion1:
			CMP 	R2, #5			//Se compara la opcion introducida y si es 5 ordenar
			LDR  	R0, =a 			//cargamos la direccion base de nuestro arreglo en R0 para luego llamar a la funcion ordenar
			LDR  	R2, =cantidad 	//cargamos la direccion de memoria del tamaño del arreglo
			LDR  	R1, [R2]		//cargamos el valdor del tamaño de memoria
			BL  	ordenar			//llamamos la funcion ordenar
			
			LDR		R0, =msj8		//cargamos la direccion de memoria del mensaje 8
			BL 		printf			//llamamos a la funcion imprimir para mostrar el mensaje 8

			LDR		R0, =fmt1		//cargamos la direccion de memoria del formato para ingresar opcion
			LDR		R1, =opcion 	//cargamos la direccion de memoria de la variable opcion
			BL 		scanf			//llamamos a la funcion leer
			
			LDR  	R2, =opcion 	//cargamos la direcicon de memoria de la variable opcion
			LDR  	R2, [R2] 		//cargamos el valor de la variable opcion

			CMP  	R2, #1 				//si opcion=1 imprimimos ascendente
			BEQ  	imprimirorden1 		//llamamos la etiqueta que imprime ascendente

			CMP  	R2, #2 				//si opcion=2 imprimimos descendente
			BEQ  	imprimirorden2 		//llamamos la etiqueta que imprimi descendente

			CMP  	R2, #2 				//si opcion > 2 volvemos a pedir ingresar 1. ascendente 2. descendente
			BGT  	opcion1				//llamamos a la etiqueta que volvera a pedir la opcion de impresion
		

		compara1:					//etiqueta compara1 que viene de cantidadNumeros aqui es donde comenzamos a capturar los datos
		BEQ		cicloIngresar		//si son iguales salta a la etiqueta cicloIngresar

	fincicloingresar:
		MOV		R5,#0			//reiniciamos el contador

	cicloImp:
		CMP 	R5, R2			
		BEQ		mostrarMenu
		ADD		R6, R4, R5, LSL #2   //RECORREMOS LA LISTA DE LOS NUMEROS INGRESADOS EN MEMORIA 
		LDR		R0, =fmt
		LDR		R1, [R6]
		BL 		printf          //aqui imprimimos cada elemento que se recorre del vector que tenemos simulado
		ADD		R5, #1
		LDR		R2, =cantidad
		LDR		R2, [R2]
		//LDR 	R7, R6    //asignamos un numero a r7 que nos servira para hacer comparaciones
		//MOV     R3, R1
		MOV     R3, #minimo
		BAL		cicloImp

	calculominimo:
		LDR		R2, =cantidad
		LDR		R2, [R2]
		CMP 	R5, R2			    //comparamos el contador con la cantidad de numeros ingresados 
		BEQ		fincicloImpMenor    // si contador y canidad de numeros ingresados son iguales saltamos a fincicloImpMenor
		ADD		R6, R4, R5, LSL #2   //RECORREMOS LA LISTA DE LOS NUMEROS INGRESADOS EN MEMORIA 
		LDR		R1, [R6]             //asignamos a R1 el valor del elemento del vector que recorremos
		// aqui haremos comparaciones donde r1 tiene el numero ingresado , r3 tendra el valor menor
		
		CMP R1, R3                   //comparamos R1 con R3 y si R1 es menor lo mandamos a asignar ese elemento como el menor
		BLS asignarMenor             //si R1<=R3 saltamos a la etiqueta asignarMenor

		ADD		R5, #1               //aumentamos el contador 
		LDR		R2, =cantidad        //volvemos a asignar a R2 la cantidad de numeros ingresados 
		LDR		R2, [R2]
		BAL		calculominimo        //saltamos a la etiqueta calculominimo
				
	calculomaximo:
		LDR		R2, =cantidad        //reasignamos a R2 la cantidad de numeros ingresados
		LDR		R2, [R2] 
		CMP 	R5, R2	             //comparaciones entre R5 Y R2 		
		BEQ		fincicloImpMayor     //SI son iguales se salta a la etiqueta fincicloImpMayor
		ADD		R6, R4, R5, LSL #2   //RECORREMOS LA LISTA DE LOS NUMEROS INGRESADOS EN MEMORIA 
		LDR		R1, [R6]				//asignamos el valor del elemento que estemos recorriendo a R1
		// aqui haremos comparaciones donde r1 tiene el numero ingresado , r3 tendra el valor menor
		
		CMP R1, R3                  //comparamos el elemento que tenemos en R1 del vector con el que este asignado como mayor en R3
		BHI asignarMayor      //si R1>=R3 saltamos a esta etiqueta

		ADD		R5, #1        //aumentamos el contador en 1 
		LDR		R2, =cantidad 
		LDR		R2, [R2]
		BAL		calculomaximo   //volvemos a la etiqueta calculomaximo
					
	fincicloImpMenor:
		LDR		R0, =msj5   //asignamos el msj5 a R0
		MOV		R1, R3      //asignamos el valor de R3 a R1 para poder ver el numero menor 
		

		BL 		printf
		B mostrarMenu       //volvemos al menu despues de imprimir el numero menor

	fincicloImpMayor:
		LDR		R0, =msj6   //asignamos el msj5 a R0
		MOV		R1, R3      //asignamos el valor de R3 A R1
		

		BL 		printf
		B mostrarMenu      //Imprimimos el numero mayor y regresamos al menu principal
		
				
	fincicloImp:
		POP	{R4,R5,R6,PC}
	exit:
		MOV		R7, #1
		SWI		0


	//asignamos el menor
	asignarMenor:
		MOV R3, R1      //asiganamos el valor de R1 A R3
		//LDR R7, [R7]
		ADD		R5, #1   //AUMENTAMOS EL CONTADOR
		BAL calculominimo //saltamos a la etiqueta calculominimo

	//asignamos el mayor
	asignarMayor:
		MOV R3, R1     //asignamos el valor de R1 en R3
		//LDR R7, [R7]
		ADD		R5, #1  //aumentamos el contador
		BAL calculomaximo //regresamos a la etiqueta calculomaximo

	//se muestra mensaje indicando que debe ingresar opcion del 1 al 5
	leerOpcion:
		LDR		R0, =msj4		//cargamos la direccion del mensaje 4
		BL 		printf			//se muestra el mensaje Debe escoger una opcion del 1 al 5
		BAL		mostrarMenu		//regresamos al flujo principal para mostrar nuevamente el menu.

	//se lee la cantidad de numeros que se ingresaran
	cantidadNumeros:
		LDR		R0, =msj2		//cargamos la direccion de memoria del mensaje 2
		BL 		printf			//llamamos a la funcion imprimir para mostrar el mensaje 2

		LDR		R0, =fmt1		//cargamos la direccion de memoria del formato que tendra la cantidad de numeros a introducir
		LDR		R1, =cantidad 	//cargamos la direccion de memoria de la variable cantidad
		BL 		scanf			//llamamos a la funcion leer para leer la cantidad

		CMP 	R2, #20				//validacion para que se ingrese un numero que sea menor a 20
		LDRGT 	R0, =msj9			//mostramos mensaje que indica que numero a ingresar debe ser del 1 al 20
		BGT		cantidadNumeros		//regresams a cantidadnumeros
		
		LDR		R2, =cantidad 	//cargamos la direccion de memoria que almacena nuestra cantidad de numeros a ingresar
		LDR		R2, [R2]		//cargamos la cantidad de numero a ingresar en el registro R2
		BAL 	compara1		//regresamos al flujo original

	//ciclo para leer los valores que ingresamos.	
	cicloIngresar:		
		CMP		R5, R2 			//compara el contador R5 con la cantidad de numeros que vamos a ingresar
		BEQ		fincicloingresar//si el contador es igual que la cantidad de numeros a ingresar
		ADD		R6, R4, R5, LSL #2	//calculamos la direccion de memoria R6=R4 + [R5 * 4] en la que se guardara el numero ingresado
		
		LDR		R0, =msj3		//cargamos la direccion de memoria del mensaje 3
		MOV		R1, R5			//movemos el valor de R5 a R1 para mostrarlo en el mensaje 3
		ADD     R1, R1, #1      //LO AGREGAMOS PARA QUE LA IMPRESION SIGA LA SECUENCIA
		BL 		printf			//llamamos la funcion imprimir
		
		LDR		R0, =fmt1		//cargamos el formato que tendra nuestro numero a leer
		LDR		R1, =numero 	//cargamos la direccion de memoria donde se guardara el numero
		BL 		scanf			//llamamos la funcion leer

		LDR		R1, =numero 	//cargamos la direccion de memoria del numero que acabamos de leer
		LDR		R1, [R1]		//caramos el valor del numero recien leido
		MOV		R7, R1			//movemos el valor leido al registro 7
		
		STR		R7, [R6]		//guardamos el valor de R7 recien ingresado en la direccion de memoria de R6=R4 + [R5 * 4]
		ADD		R5, #1			//incrementamos el contador en 1
		LDR		R2, =cantidad 	//cargamos la direccion de memoria de la cantidad de numeros a ingresar
		LDR		R2, [R2]		//cargamos el valor de la cantidad de numero a ingresar
		BAL		cicloIngresar	//regresamos al inicio del ciclo

	//aqui calculamos la media aritmetica de los numeros del arreglo ingresados
	calculomedia:
		MOV 	R5, #0  		//Reiniciamos el contador
		LDR		R2, =cantidad 	//Cargamos la direccion de memoria de la cantidad de elementos del arreglo
		LDR		R2, [R2]		//cargamos valor cantidad de elmentos del arreglo
		MOV 	R3, #0 			//ponemos a cero R3 que almacenara nuestra suma
		//aqui calculamos la sumatoria de los numeros del arreglo
		sumamedia:
			CMP 	R5, R2				//se compara el contador con la cantidad de elementos del arreglo	
			BEQ		divisionmedia		//si contador =  tamaño arrelgo => llamamos la etiqueta que calculara la division
			ADD		R6, R4, R5, LSL #2  //Recorremos el arreglo calculando la memoria R6=R4 + [R5*4] 
			LDR		R1, [R6]			//cargamos el valor R1=valor(R6)
			ADD 	R3, R3, R1			//sumatoria del arreglo R3 = R3 + R1
			
			ADD		R5, #1 				//aumentamos en uno el contador
			LDR		R2, =cantidad 		//cargamos la direccion de memoria del tamaño del arreglo
			LDR		R2, [R2]			//cargamos el valor del tamaño del arreglo
			BAL		sumamedia			//reiniciamos la sumatoria
		
		//aqui calculamos la parte de la division y recibimos la sumatoria del arreglo
		divisionmedia:
			LDR  	R1, =media 		//cargamos la direccion de memoria de la variable media
			STR 	R3, [R1] 		//guardamos la sumatoria en la varibale media=R3

			MOV 	R1, #0 			//colocamos a cero el R1(cociente)
			//aqui calculamos la parte entera de la media aritmetica
			divideentero:
				CMP 	R3, R2			//comparamos el residuo con el divisor R3(Residuo)=R2(Divisor)
				BLT		dividedecimal 	//si el residuo es R3(Residuo) < R2(Divisor) nos vamos a calcular la parte decimal de la media aritmetica
				SUB 	R3, R2 			//restamos al residuo el divisor R3(Residuo)=R3(Residuo) - R2(Divisor)
				ADD 	R1, #1 			//sumamos uno al contador R1(cociente)++
				LDR		R2, =cantidad 	//Cargamos la direccion de memoria del tamaño del arreglo
				LDR		R2, [R2]		//cargamos valor cantidad de elmentos del arreglo
			BAL     divideentero
			
			//aqui calcumalos los dos decimales de la media aritmetica 
			dividedecimal:
				LDR  	R4, =entero 	//cargamos la direccion de memoria de la variable entero
				STR  	R1, [R4] 		//hacemos R4(entero) = R1(cociente)
				LDR  	R4, =residuo 	//cargamos la direccion de memoria de la variable residuo
				STR  	R3, [R4] 		//hacemos R4(residuo) = R3(residuo)

				CMP  	R3, #0 			//comparamos el residuo R3(residuo) = 0
				LDREQ	R4, =decimal1 	//si R3(residuo) = 0   => caramos la direccion de memoria de la variable decimal1
				STREQ	R3, [R4] 		//si R3(residuo) = 0   => R4(decimal1) = R3(residuo)
				BEQ  	imprimirmedia 	//llamamos a la etiqueta que nos va imprimir la media aritmetica

				LDR  	R3, =residuo 	//cargamos la direccion de memoria de la variable residuo
				LDR  	R3, [R3] 		//cargamos el valor de residuo en R3, R3 = residuo
				MOV   	R5, #0 			//iniciamos el contador a cero
				MOV  	R2, #10 		//cargamos el valor de 10 en R2, R2=10

				MUL  	R4, R3, R2  	//multiplicamos por 10 para poder segui dividiento R4=R3(residuo) * R2(10)
				LDR		R2, =cantidad 	//Cargamos la direccion de memoria del tamaño del arreglo
				LDR		R2, [R2]		//cargamos valor cantidad de elmentos del arreglo
				
				//aqui calculamos el primer decimal de la media aritmetica
				divdecimal:
					CMP 	R4, R2 			//comparamos R4(residuo)=R2(divisor)
					BLT		div2decimal 	//si R4(residuo) < R2(divisor) nos vamos a calcular el segundo decimal
					SUB 	R4, R2 			//restamos al R4(residuo) - R2(divisor)
					ADD 	R5, #1 			//sumamos uno al R5(cociente)++
					LDR		R2, =cantidad 	//Cargamos la direccion de memoria del tamaño del arreglo
					LDR		R2, [R2]		//cargamos valor cantidad de elmentos del arreglo
					BAL     divdecimal


				//aqui calculamos el segundo decimal de la media aritmetica
				div2decimal:
				LDR  	R3, =decimal1 		//cargamos la direccion de memoria del primer decimal de la media aritmetica
				STR  	R5, [R3] 			//hacemos R3(decimal1)=R5(cociente)
				LDR  	R3, =residuo 		//cargamos la direccion de memoria de la variable residuo
				STR  	R4, [R3] 			//hacemos R3(residuo) = R4(residuo)

				CMP  	R4, #0 				//comparamos el residuo R4(residuo) = 0
				LDREQ	R3, =decimal2 		//si R4(residuo) = 0   => caramos la direccion de memoria de la variable decimal2
				STREQ	R4, [R3] 			//si R4(residuo) = 0   => R3(decimal2) = R4(residuo)
				BEQ  	imprimirmedia 		//llamamos a la etiqueta que nos imprimira la media aritmetica

				LDR  	R3, =residuo 		//cargamos la direccion de memoria de la variable residuo
				LDR  	R3, [R3] 			//cargamos el valor de residuo en R3, R3 = residuo
				MOV   	R5, #0 				//iniciamos el contador a cero
				MOV  	R2, #10 			//cargamos el valor de 10 en R2, R2=10

				MUL  	R4, R3, R2 			//multiplicamos por 10 para poder segui dividiento R4=R3(residuo) * R2(10)
				LDR		R2, =cantidad 		//Cargamos la direccion de memoria de la cantidad de elementos del arreglo
				LDR		R2, [R2] 			//cargamos valor cantidad de elmentos del arreglo

					//aqui calculamos el segundo decimal de la media aritmetica
					divdecimal2:
						CMP 	R4, R2 			//comparamos R4(residuo)=R2(divisor)
						LDRLT	R3, =decimal2 	//si R4(residuo) < R2(divisor) cargamos la direccion de memoria de decimal2
						STRLT	R5, [R3] 	    //hacemos R3(decimal2)=R5(cociente)
						BLT		imprimirmedia 	//si el residuo es menor que el divisor llamamos a imprimir la media aritmetica
						SUB 	R4, R2			//restamos al R4(residuo) - R2(divisor)
						ADD 	R5, #1 			//sumamos uno al R5(cociente)++
						LDR		R2, =cantidad 	//Cargamos la direccion de memoria del tamaño del arreglo
						LDR		R2, [R2]		//cargamos valor cantidad de elmentos del arreglo
					BAL     divdecimal2			//reiniciamos el ciclo	

	//aqui se imprime la media aritmetica con dos decimales ejem 2.55
	imprimirmedia:
		LDR  	R1, =entero 		//cargamos la direccion de la variable entero
		LDR  	R1, [R1]			//cargamos el valor de entero
		LDR  	R2, =decimal1 		//cargamos la direccion de la variable decimal1
		LDR  	R2, [R2] 			//cargamos el valor de decimal1
		LDR  	R3, =decimal2 		//cargamos la direccion de la variable decimal2
		LDR  	R3, [R3] 			//cargamos el valor de decimal2
		LDR 	R0, =msj7 			//cargamos la direccion de memoria del mensaje 7
		BL 		printf 				//llamamos la funcion imprimir
		BAL 	mostrarMenu	


	//aqui imprimimos el arreglo en forma ascendente
	imprimirorden1:
		MOV   	R5, #0 				//reiniciamos el contador a cero
		LDR  	R2, =cantidad 		//cargamos la direccion de memoria de la variable cantidad
		LDR  	R2, [R2] 			//hacemos R2=cantidad

		//imprimimos ascendente
		imprimir1:
			CMP 	R5, R2					//comparamos el contador el tamño del arreglo R5(contador) = R2(tamaño)
			BEQ		mostrarMenu				//llamamos la etiqueta mostrar menu
			ADD		R6, R4, R5, LSL #2   	//RECORREMOS LA LISTA DE LOS NUMEROS INGRESADOS EN MEMORIA 
			LDR		R0, =fmt 				//cargamos el formato para imprimir %d
			LDR		R1, [R6] 				//cargamos el valor de la direccion de memoria
			BL 		printf 					//llamamos a la funcion imprimir
			ADD		R5, #1 					//aumentamos en uno el contador R5++
			LDR		R2, =cantidad 			//cargamos la direccion de memoria del tamaño del arreglo
			LDR		R2, [R2] 				//cargamos el valor del tamaño del arreglo
		BAL		imprimir1 					//reiniciamos el ciclo

 	//imprimimos en orden descentende
	imprimirorden2:
		LDR  	R4, =a 						//cargamos la direccion base del arreglo
		LDR  	R2, =cantidad 				//cargamos el valor del tamaño del arreglo
		LDR  	R2, [R2]					//cargamos el valor del tamaño del arreglo
		MOV   	R5, R2						//iniciamos el contador con el tamaño del arreglo para poder imprimir descendente
		SUBS	R5, #1 						//restamos uno R5--
		
		//imprimimos descendente
		imprimir2:
			CMP 	R5, #0		 			//comparamos R5(contador) = 0	
			BLT		mostrarMenu 			//si R5(contador) = 0 llamamos a la etiqueta mostrar menu
			ADD		R6, R4, R5, LSL #2   	//RECORREMOS LA LISTA DE LOS NUMEROS INGRESADOS EN MEMORIA 
			LDR		R0, =fmt 				//cargamos el formato para imprimir %d
			LDR		R1, [R6]				//cargamos el valor de R6, R1=valor(R6)
			BL 		printf 					//llamamos a la funcion imprimir
			SUB  	R5, #1 					//restamos en uno el contador R5--
		BAL		imprimir2 					//reiniciamos el ciclo