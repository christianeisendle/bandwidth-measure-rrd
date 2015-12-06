#!/bin/bash
cd /mnt/flashdrive/weather
./create_graph.sh temp_kombi_$1.png "Temperatur Kombi" $1 Grad\ C temps9 e0000080 Kombi Grad\ C 10 25
./create_graph.sh hum_kombi_$1.png "Luftfeuchtigkeit Kombi" $1 % hums9 e0000080 Kombi %%\ \ \ \  0 100
./create_graph.sh wind_kombi_$1.png "Windgeschwindkeit Kombi" $1 km/h winds9 e0000080 Kombi km/h\ \ \ \  0 20 
./create_abshum_graph.sh abshum_kombi_$1.png "Luftfeuchtigkeit (absolut) Kombi" $1 temps9 hums9 e0000080 Kombi
./create_dewpoint_graph.sh dewpoint_kombi_$1.png "Taupunkt Kombi" $1 temps9 hums9 e0000080 Kombi
./create_rain_graph.sh rain_kombi_$1.png "Regen Kombi" $1 e0000080 Kombi

./create_graph.sh temp_keller_$1.png "Temperatur Keller" $1 Grad\ C temps1 e0000080 Keller Grad\ C 10 25
./create_graph.sh hum_keller_$1.png "Luftfeuchtigkeit Keller" $1 % hums1 e0000080 Keller %%\ \ \ \  0 100
./create_abshum_graph.sh abshum_keller_$1.png "Luftfeuchtigkeit (absolut) Keller" $1 temps1 hums1 e0000080 Keller
./create_dewpoint_graph.sh dewpoint_keller_$1.png "Taupunkt Keller" $1 temps1 hums1 e0000080 Keller

./create_graph.sh temp_lagerraum_$1.png "Temperatur Lagerraum" $1 Grad\ C temps5 e0ee0080 Lagerraum Grad\ C 10 25
./create_graph.sh hum_lagerraum_$1.png "Luftfeuchtigkeit Lagerraum" $1 % hums5 e0ee0080 Lagerraum %%\ \ \ \  0 100
./create_abshum_graph.sh abshum_lagerraum_$1.png "Luftfeuchtigkeit (absolut) Lagerraum" $1 temps5 hums5 e0ee0080 Lagerraum
./create_dewpoint_graph.sh dewpoint_lagerraum_$1.png "Taupunkt Lagerraum" $1 temps5 hums5 e0ee0080 Lagerraum

./create_graph.sh temp_hobbyraum_$1.png "Temperatur Hobbyraum" $1 Grad\ C temps6 80000080 Hobbyraum Grad\ C 10 25
./create_graph.sh hum_hobbyraum_$1.png "Luftfeuchtigkeit Hobbyraum" $1 % hums6 80000080 Hobbyraum %%\ \ \ \  0 100
./create_abshum_graph.sh abshum_hobbyraum_$1.png "Luftfeuchtigkeit (absolut) Hobbyraum" $1 temps6 hums6 80000080 Hobbyraum
./create_dewpoint_graph.sh dewpoint_hobbyraum_$1.png "Taupunkt Hobbyraum" $1 temps6 hums6 80000080 Hobbyraum

./create_graph.sh temp_aussen_$1.png "Temperatur Aussen" $1 Grad\ C temps2 ffff0080 Aussen Grad\ C -15 40
./create_graph.sh hum_aussen_$1.png "Luftfeuchtigkeit Aussen" $1 % hums2 ffff0080 Aussen %%\ \ \ \  0 100
./create_abshum_graph.sh abshum_aussen_$1.png "Luftfeuchtigkeit (absolut) Aussen" $1 temps2 hums2 ffff0080 Aussen 
./create_dewpoint_graph.sh dewpoint_aussen_$1.png "Taupunkt Aussen" $1 temps2 hums2 ffff0080 Aussen

./create_graph.sh temp_wohnzimmer_$1.png "Temperatur Wohnzimmer" $1 Grad\ C temps4 0000ff80 Wohnzimmer Grad\ C 12 28
./create_graph.sh hum_wohnzimmer_$1.png "Luftfeuchtigkeit Wohnzimmer" $1 % hums4 0000ff80 Wohnzimmer %%\ \ \ \  0 100
./create_abshum_graph.sh abshum_wohnzimmer_$1.png "Luftfeuchtigkeit (absolut) Wohnzimmer" $1 temps4 hums4 0000ff80 Wohnzimmer
./create_dewpoint_graph.sh dewpoint_wohnzimmer_$1.png "Taupunkt Wohnzimmer" $1 temps4 hums4 0000ff80 Wohnzimmer

./create_graph.sh temp_kinderzimmer_$1.png "Temperatur Kinderzimmer" $1 Grad\ C temps3 00ff0080 Kinderzimmer Grad\ C 12 28
./create_graph.sh hum_kinderzimmer_$1.png "Luftfeuchtigkeit Kinderzimmer" $1 % hums3 00ff0080 Kinderzimmer %%\ \ \ \  0 100
./create_abshum_graph.sh abshum_kinderzimmer_$1.png "Luftfeuchtigkeit (absolut) Kinderzimmer" $1 temps3 hums3 00ff0080 Kinderzimmer
./create_dewpoint_graph.sh dewpoint_kinderzimmer_$1.png "Taupunkt Kinderzimmer" $1 temps3 hums3 00ff0080 Kinderzimmer

cp *$1*.png /mnt/weather

