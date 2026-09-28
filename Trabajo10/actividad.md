# Arbol de Desiciones en CLISP - CodZombies

---

## Extraccion con car y cdr
* car: Obtiene el primer elemento (la clave del nodo)
* cdr: Obtiene el resto de la lista (los datos o sub-arboles, sin la clave)
* cadr: Obtiene directamente el primer valor dentro del contenido (car del cdr)

```lisp
(car (assoc 'black_ops_1 *codZombies*))         ; => BLACK_OPS_1
(cdr (assoc 'black_ops_1 *codZombies*))         ; ((ULTIMIS ...) (EQUIPO_FIVE ...) (ACTORES_COTD ...))
``` 

## Niveles

1. **Juego de aparicion:** `black_ops_1`, `black_ops_2`, `black_ops_3`
2. **Faccion / Grupo:** `ultimis`, `primis`, `victis`, `mafiosos_alcatraz`, `malditos_morg_city`, `equipo_five`, `actores_cotd`
3. **Genero:** `hombre`, `mujer`
4. **Nacionalidad:** `aleman`, `ruso`, `estadounidense`, `japones`, `cubano`, `mexicano`
5. **Rol / Caracteristicas:** Personalidad o caracteristica del personajes
6. **Personaje**


## Codigo:

```lisp
(defparameter *codZombies*  '(
    (black_ops_1
      ; ultimis
      (ultimis
        (hombre
          (aleman
            (cientifico_sociopata (richtofen_ultimis)))
          (ruso
            (soldado_adicto_al_vodka (nikolai_ultimis)))
          (estadounidense
            (marine_agresivo_y_rudo (dempsey_ultimis)))
          (japones
            (obsesionado_con_el_honor (takeo_ultimis)))))

      ; equipo five (five)
      (equipo_five
        (hombre
          (estadounidense
            (presidente_de_los_estados_unidos (john_f_kennedy))
            (expresidente_paranoico (richard_nixon))
            (secretario_de_defensa (robert_mcnamara)))
          (cubano
            (dictador_revolucionario (fidel_castro)))))

      ; actores (call of the dead)
      (actores_cotd
        (mujer
          (estadounidense
            (cazavampiros_famosa (sarah_michelle_gellar))))
        (hombre
          (estadounidense
            (villano_de_pesadillas_del_cine (robert_englund))
            (actor_intimidante_y_rudo (michael_rooker)))
          (mexicano
            (actor_que_usa_machetes (machete))))))

    (black_ops_2
      ; primis
      (primis
        (hombre
          (aleman
            (recolector_de_almas_con_kronorium (richtofen_primis)))
          (ruso
            (piloto_de_mech_amargado (nikolai_primis)))
          (estadounidense
            (sujeto_congelado_en_capsula (dempsey_primis)))
          (japones
            (portador_de_catana_ancestral (takeo_primis)))))

      ; victis
      (victis
        (mujer
          (estadounidense
            (chica_de_granja_ruda (misty))))
        (hombre
          (estadounidense
            (come_carne_zombie_escucha_voces (samuel_stuhlinger))
            (ingeniero_nerd_claustrofobico (marlton))
            (ex_agente_roto_amnesico (russman)))))

      ; mafiosos_alcatraz
      (mafiosos_alcatraz
        (hombre
          (estadounidense
            (dibujante_de_comics_y_soplon (albert_weasel))
            (jefe_mafioso_poderoso (sal_deluca))
            (sicario_leal_con_cuchillo (billy_handsome))
            (estafador_y_esposo_infiel (michael_finn_oleary))))))

    (black_ops_3
      ; primis
      (primis
        (hombre
          (aleman
            (recolector_de_almas_con_kronorium (richtofen_primis)))
          (ruso
            (piloto_de_mech_amargado (nikolai_primis)))
          (estadounidense
            (sujeto_congelado_en_capsula (dempsey_primis)))
          (japones
            (portador_de_catana_ancestral (takeo_primis)))))

      ; ultimis 
      (ultimis
        (hombre
          (aleman
            (cientifico_sociopata (richtofen_ultimis)))
          (ruso
            (soldado_adicto_al_vodka (nikolai_ultimis)))
          (estadounidense
            (marine_agresivo_y_rudo (dempsey_ultimis)))
          (japones
            (obsesionado_con_el_honor (takeo_ultimis)))))

      ; malditos de morg city (shadows of evil)
      (malditos_morg_city
        (mujer
          (estadounidense
            (actriz_de_burlesque_y_asesina (jessica_rose))))
        (hombre
          (estadounidense
            (mago_arrogante_en_deuda (nero_blackstone))
            (policia_corrupto_y_sobornable (jack_vincent))
            (boxeador_que_usa_nudilleras (floyd_campbell))))))))
```

<img src="arbol.svg"  width="100%">

---