# EncodedPolyline

EncodedPolyline implements [Google's algorithm](http://code.google.com/apis/maps/documentation/utilities/polylinealgorithm.html) for compressing arrays of geographic points. The compressed string can then be passed to the Google Maps API.
The Maps API limits URL requests to 2048 characters. This library does not enforce this limit on the encoding length.

## Examples

An [example map](http://maps.googleapis.com/maps/api/staticmap?size=400x400&sensor=false&path=weight:3|color:blue|enc:{hjxEikzcTpl@~B_Slg@_BbDgw@uV~CbIky@ph@gMh^hL|Zue@rK~o@wE_z@zQpW{ZoGxNGrSml@t_@bBeg@sh@{Qma@it@qK_^hXzj@z`@tLzCpo@x[uWtJ`Fba@mt@lCic@vCmIaXnCpJaf@~FtGc_@zS~Cpd@b|@m[xAba@wPuVyWhj@uSdK~W|HoNiXho@vO~Da`@u|@vg@eD~|@{Lbh@`PiD{b@ou@dr@ox@bDye@u{@lGyv@y[kLvS~XlH}Djq@kl@zWbTzv@lFqEal@`t@my@lh@cSq]af@gu@gw@fDai@gv@eg@jYwLyEyZlz@wn@aM{IwHbRa_@_TpKhs@nc@br@bIj\nx@ps@}[fz@|v@wHn]m}@sz@tVzUzZqWg^bx@tw@{Rh{@e}@`{@dBvWpMha@hEft@|KyLkd@ro@vy@wMdu@sYse@tEoSoK~i@cWSlQcZar@rJiJsVdOxRoGfUwI}H{RwQ) from a 100-point random walk, encoded using the library.

Using the library:

    EncodedPolyline.encode(-179.9832104)               # "`~oia@"
    EncodedPolyline.decode("`~oia@")                   # -179.98321
    EncodedPolyline.encode_points([[37.782,-122.406]]) # "ohreFnlbjV"
    EncodedPolyline.decode_points("ohreFnlbjV")        # [[37.782,-122.406]]

## Performance

Some of the steps outlined in the algorithm spec are composed together, for speediness. Included is a benchmark that creates a 100-point random walk and encodes/decodes it 10,000 times (1 million points total).

    Raw length(JSON):     3682 characters
    Encoded length:       495 characters
    Compression ratio:    0.134437805540467

                              user     system      total        real
    encoding              9.090000   0.000000   9.090000 (  9.092519)
    decoding             16.470000   0.010000  16.480000 ( 16.473547)

## Known Issues

Haven't tested with Ruby 1.9; probably doesn't work.

