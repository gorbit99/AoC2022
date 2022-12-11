use v6;
#unit module Hon;
use lib ('runtime-lib');
use HakuPrelude;


sub bunretu( \sutoringu, \derimita, \paato ) {do if (compare(sutoringu, '', '==')) {
  paato
} else {
  do {
    my \atama = head(sutoringu);
    do if (compare(atama, derimita, '==')) {
      concat(concat([], paato), bunretu(tail(sutoringu), derimita, ''))
    } else {
      bunretu(tail(sutoringu), derimita, concat(paato, atama))
    }
  }
}}

sub wakareru( \derimita, \sutoringu ) {bunretu(sutoringu, derimita, '')}

sub egaku( \ekusu, \kauntaa ) {do if (compare(kauntaa, ekusu, '<')) {
  '.'
} else {
  do if (compare(kauntaa, (ekusu + 2), '>')) {
    '.'
  } else {
    '#'
  }
}}

sub suru( \ekusu, \kauntaa, \rain ) {do {
  my \sinrain = concat(rain, egaku(ekusu, kauntaa));
  do if (compare(kauntaa, 40, '==')) {
    do {
      my \nai = show(sinrain);
      ''
    }
  } else {
    sinrain
  }
}}

sub kazoeru( \kauntaa ) {do if (compare(kauntaa, 40, '==')) {
  1
} else {
  (kauntaa + 1)
}}

sub atukau( \insutorakushontachi, \kauntaa, \tikku, \ekusu, \rain ) {do {
  my \sinrain = suru(ekusu, kauntaa, rain);
  do if (compare(insutorakushontachi, [], '==')) {
    []
  } else {
    do {
      my \sinkauntaa = kazoeru(kauntaa);
      my (\komando,\arugumento)  = wakareru(' ', head(insutorakushontachi)); 
      do if (compare(komando, 'noop', '==')) {
        atukau(tail(insutorakushontachi), sinkauntaa, 1, ekusu, sinrain)
      } else {
        do if (compare(tikku, 1, '==')) {
          atukau(insutorakushontachi, sinkauntaa, 2, ekusu, sinrain)
        } else {
          do {
            my \sinekusu = (ekusu + arugumento);
            atukau(tail(insutorakushontachi), sinkauntaa, 1, sinekusu, sinrain)
          }
        }
      }
    }
  }
}}

sub hon() is export {
  my \fairu = fopen('day10_example.txt', &read);
  my \inputto = read(fairu, &all);
  atukau(inputto, 1, 1, 1, "");
  close(fairu)
}

hon();

