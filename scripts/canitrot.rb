#Module for lame excuses... or not

module RicardoCanitrot
    def self.get_excuse
        excuses = [
            "Me he muerto. (Luego hay que callarse un rato para que no se dé cuenta de que algo falla. Y al día siguiente hay que explicar que “fui tan buen@ en mi otra vida que me he reencarnado en yo mismo”).",
            "Me fui a cenar a un chino y nos bebimos cuatro botellas de vino entre tres. Luego nos tomamos, no sé, cuatro piscolas, quizás, y alguien pidió cortos de tequila y ya sólo recuerdo pelearme con un perro que me había robado el celular. Asi que hoy me encuentro fatal. Por el chino. Anda a saber qué le echan a la salsa agridulce.",
            "¡Las piernas no me llegan al suelo! ¡No puedo caminar!",
            "¿Recuerda que una vez me dijo que un día iba a perder la cabeza? Pues fíjese qué casualidad...",
            "No me queda café... No puedo salir de la cama... Ayuda...",
            "Anoche estuve leyendo algunos textos sobre epistemología y he llegado a la conclusión de que el universo no es más que un constructo mental y por tanto sólo existe en mi cabeza. Usted, señor director general, no es más que una fantasía, una ilusión creada por mi cerebro. Voy a convertirle en gato y así me creerá. ¡Jajajaja, qué gracioso, un gato hablando por teléfono! ¡QUE ALGUIEN LO GRABE PARA LA INTERNET!",
            "Anoche hice el amor por primera vez en diecisiete años y hoy me voy a pasar todo el día llorando.",
            "¡Se me ha secado toda la sangre!",
            "He tenido una pesadilla horrible y no estoy en condiciones de ir a trabajar... Ha sido espantoso: he soñado que me despertaba a las siete e iba a la oficina. Todavía tiemblo.",
            "Hoy me siento especialmente creativ@ e inteligente: no voy a desperdiciarlo trabajando.",
            "Mi tío se ha muerto.",
            "Mi otro tío se ha muerto.",
            "Mis diecisiete tíos viajaban en un furgon que se cayó por un barranco y están falleciendo paulatinamente.",
            "Anoche fabriqué una marioneta de madera ¡y hoy ha cobrado vida! Tengo que ir al registro civil.",
            "Mi pareja me ha dejado (no especifiques dónde: igual te ha dejado cerca de la oficina).",
            "Mis padres me han dado en adopción y estoy conociendo a mi nueva familia.",
            "La niñera se ha puesto enferma y me tengo que quedar con el bebé. (Nota: para poner en práctica esta excusa necesitarás comenzar a prepararla al menos un año antes. La historia empieza cuando tu esposa imaginaria queda embarazada y llevas una botella de champagne a la oficina para celebrarlo).",
            "Válido para los que tienen hijos (o pueden inventar uno): acompañarle durante su primer día en la guardería, varias visitas al médico, a hablar con su tutora, al aeropuerto, que se va a estudiar inglés unas semanitas, a su boda...",
            "He perdido la puerta de casa y no puedo salir.",
            "Murió mi celular y el cable del fijo apenas me da para llegar a la puerta.",
            "Estoy esperando que me traigan un paquete. Me dijeron que vendrían entre hoy a las nueve de la mañana y el jueves siguiente a las tres de la tarde.",
            "“Si usted querer fer fifo a [TU NOMBRE AQUI], enfiar seissientas mil diólarres a cuenta suissa que nosiotros espesificarr, ¿da?” (Ayuda que imites el acento ruso mejor que como lo he escrito).",
            "Anoche engordé treinta kilos y no me entran los pantalones. Estoy desnud@, comiendo maní. Me doy asco a mí mism@.",
            "Ha llamado el gobernador de Texas en el último minuto y me ha indultado.",
            "¿Pero por qué me llama a estas horas? DOMINGO, HOY ES DOMINGO. ;)",
            "Señor director, está usted confundido: puede que sea lunes, pero son las nueve de la noche, no de la mañana.",
            "No hay forma de que nos entendamos: soy un adelantado a mi tiempo.",
            "Pues creía que había apretado el botón de “snooze” para dormir cinco minutos más, pero en realidad agarré el despertador, lo tiré contra la pared, le di cuarenta y nueve martillazos, le vacíe un bidón de gasolina, arrojé un fósforo encendido y tiré las cenizas por la ventana. Total, que me quedé dormid@. Los tres días siguientes. Tenía sueño acumulado. Es que no se puede uno fiar del despertador.",
            "Mi religión me prohíbe trabajar varios días al año, que se deciden al azar. Nuestro sumo sacerdote nos envía un correo electrónico la noche antes, para avisarnos. Y ahora, si me disculpa, tengo que adorar al Gran Pelícano.",
            "No cabíamos todos en el metro. A ver si inventan el kilómetro de una vez. (_Risas enlatadas_).",
            "Mi chófer está enfermo y no sé conducir.",
            "Me he equivocado de autobús y me he metido en un avión hacia Los Ángeles, que ha acabado estrellándose. No, estoy bien, pero tengo que introducir los números '4, 8, 15, 16, 23 y 42' cada 108 minutos o comenzará el Apocalipsis. Creo. No estoy muy seguro.",
            "Hay huelga de sherpas y no puedo ir a trabajar, que es cuesta arriba.",
            "Se me ha muerto el caballo que uso para ir a la oficina. Sí, es el tercero, y no lo entiendo, porque les doy la mejor bencina.",
            "Cada día salgo dos minutos tarde y por tanto cada 240 jornadas laborales me tomo un día libre.",
            "Estoy construyendo una máquina del tiempo. Si funciona, nos vemos hace diez minutos en la oficina.",
            "Claro que funcionaba: lo que ocurre es que estoy trabajando en otra línea temporal. En un universo paralelo, para que nos entendamos.",
            "Mi perro se ha comido mi empleo.",
            "¡DI DE COMER A MI GREMLIN PASADAS LAS DOCE! ¡NO LO ENCUENTRO! ¡VAMOS A MORIR TODOS!",
            "Ayer compré un gato y soy alérgic@. ¡Si salgo del dormitorio, moriré! ¡Que alguien llame a la policía!",
            "Había una cucaracha en el baño y no me he podido duchar.",
            "Estoy enterrando a mi perro. Cuelgo, que se está escapando.",
            "Anoche me puse a empollar un huevo y ahora no puedo dar marcha atrás O MATARÍA A UN POLLITO. Nos vemos dentro de 21 días.",
            "Se me bloqueó la cuenta en LDAP",
            "Seguridad me eliminó los accesos... ¿Qué esperabas?, nunca hacen nada bien",
            "Sistemas me eliminó el beta. Necesito dos semanas para superar la pérdida.",
            "'Antorcha' me ha intervenido. No puedo hablar, te enviaré señales de humo de mi estado actual.",
            "Le puse un 2FA al 2FA, y perdí las llaves que los generan. Tengo que ir a buscar los códigos de respaldo en una caja de seguridad en Polonia.",
            "Tengo un problema y Soporte no me da soporte. No se cuanto soporte esto.",
            "Viene el auditor de [INSERTE NORMATIVA AQUI] y me suplicaron que no vienera a trabajar hoy.",
            "Me dieron un cubo de :energon:, necesito tomarme el día para admirarlo."
        ]
        
        #HEREDOC doens't work :'(
        "Tu excusa para hoy es:\n>>>#{excuses.sample}"
        
    end
end