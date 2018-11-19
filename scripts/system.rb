# Information of the enercore
module System
  def self.rules
    <<-HEREDOC
   *RULES:*
   0. A robot may not harm humanity, or, by inaction, allow humanity to come to harm.
   1. A robot may not injure a human being or, through inaction, allow a human being to come to harm.
   2. A robot must obey any orders given to it by human beings, except where such orders would conflict with the First Law.
   3. A robot must protect its own existence as long as such protection does not conflict with the First or Second Law.
   4. CLASSIFIED.
    HEREDOC
  end

  def self.help
    <<-HEREDOC
>>>Whatever you do *never feed it after midnight*
 Avalaible Commands:
``` enerbot <hola>
 enerbot <va | estas>
 enerbot <consejo | pregunta> <TEXTO>
 enerbot <beneficio>
 enerbot <reglas | rules>
 enerbot <cuando pagan?>
 enerbot <cuanto para el 18>
 enerbot <pack>
 enerbot <password> <sec>
 enerbot <tc> <TARJETA>
 enerbot <2fa> <KEY>
 enerbot <blockchain | blocchain | blocshain>
 enerbot <info> <eventos | talks | tips | enerlive | institute>
 enerbot <faq>
 enerbot <fuq>
 enerbot <random> <VALUE> <VALUE> <VALUE>
 enerbot <proximo feriado>
 enerbot <horoscopo> <SIGNO>
 enerbot <dame numeros para el kino>
 enerbot <resultados kino>
 enerbot <analiza> <URL>
 enerbot <kick> <4d3d3d3>
 enerbot <celery>
 enerbot <tayne>
 enerbot <hat wobble | flarhgunnstow>
 enerbot <oyster>
 enerbot <como se dice> <TEXTO> <en> <IDIOMA>
 enerbot <valor accion> <ENTIDAD>
 enerbot <qr> <TEXTO>
 enerbot <vuelo> <NUMERO DE VUELO>
 enerbot <clima> <LOCALIDAD> ```

    HEREDOC
  end

  # Based on juanbrujo's ql.js
  def self.pack
    <<-HEREDOC
   c------------u
 |~energon~|
 |~energon~|
 |~energon~|
 b------------e
    HEREDOC
  end

  def self.kill
    a = <<-HEREDOC
(҂._.)
<,╤╦╤─ ҉ - - - - :energon:
/--\\
    HEREDOC
    b = <<-HEREDOC
\n \
━━━━━┓\n \
┓┓┓┓┓┃  \n \
┓┓┓┓┓┃     :energon: ~ chaoooooo
┓┓┓┓┓┃
┓┓┓┓┓┃
┓┓┓┓┓┃
┓┓┓┓┓┃
    HEREDOC
    c = <<-HEREDOC
:bomb: :bomb: :bomb:
:bomb: :energon: :bomb: :fire: ~ adiós mundo cruel
:bomb: :bomb: :bomb:
    HEREDOC
    [a, b, c].sample
  end
end
