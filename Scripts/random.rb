# JS stuff right here https://github.com/devschile/huemul/tree/master/scripts
# Based on juanbrujo's 8ball.js

def random_advice
  ['En mi opinión, sí',
   'Es cierto',
   'Es decididamente así',
   'Probablemente',
   'Buen pronóstico',
   'Todo apunta a que sí',
   'Sin duda',
   'Sí',
   'Sí - definitivamente',
   'Debes confiar en ello',
   'Respuesta vaga, vuelve a intentarlo',
   'Pregunta en otro momento',
   'Será mejor que no te lo diga ahora',
   'No puedo predecirlo ahora',
   'Concéntrate y vuelve a preguntar',
   'No cuentes con ello',
   'Mi respuesta es no',
   'Mis fuentes me dicen que no',
   'Las perspectivas no son buenas',
   'Muy dudoso'].sample
end

# Based on lgaticaq's beneficios.js

def random_benefit
  ['Tómate la tarde libre, proletario.',
   '¡4 semanas de vacaciones pagadas!',
   'Escoje el computador y la silla que quieras.',
   'Snacks, café, frutas y bebidas libre todos los días todo el día.',
   'Aguinaldo en septiembre y diciembre.',
   'Bono anual por metas cumplidas.',
   'Seguro de salud y dental para ti y tu familia.',
   'Bono anual sólo por ser un :energon: dev',
   'Permisos para celebrar y compartir en la :energon: Conf'].sample
end

# Random music video

def random_music
  %w[https://youtu.be/z5OXON8vIaA
     https://youtu.be/M-iXzPkgNpw?t
     https://youtu.be/Q91hydQRGyM?t
     https://youtu.be/HSh73d3TZcA
     https://youtu.be/D_P-v1BVQn8
     https://youtu.be/sFrNsSnk8GM].sample
end
