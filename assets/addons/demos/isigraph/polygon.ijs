NB. polygon drawing   - isigraph demo
NB.
NB. experiment with numbers of sides,
NB. e.g. replace last line with:
NB. 255 0 255 gpolygon ,roundint gscale 8 polygon 27

w=. 2 3{ GSIZE%1000
gback 0 0 128
0 192 192 gpolygon ,roundint w*"1 gscale 4 polygon 17
255 255 0 gpolygon ,roundint w*"1 gscale 10 polygon 17
255 0 255 gpolygon ,roundint w*"1 gscale 8 polygon 17
